Shader "ZhuangDong/L19/Ghost"
{
    Properties
    {
        _MainTex            ("Texture   RGB:BaseColor A:AC", 2D)                            = "white" {}
        _Opacity            ("Opacity", range(0, 1))                                        = 0.5
        _RingScaleParams    ("RingScaleParams   X: Range Y: Speed Z: Calibration", vector)  = (0.2, 1.0, 4.5, 0.0)
        _SwingXParams       ("SwingXParams   X: Range Y: Speed Z: Wavelength", vector)      = (1.0, 3.0, 1.0, 0.0)
        _SwingZParams       ("SwingZParams   X: Range Y: Speed Z: Wavelength", vector)      = (1.0, 3.0, 1.0, 0.0)
        _SwingYParams       ("SwingYParams   X: Range Y: Speed Z: Delay", vector)           = (1.0, 3.0, 0.3, 0.0)
        _ShakeHeadParams    ("ShakeHeadParams   X: Range Y: Speed Z: Delay", vector)        = (1.0, 3.0, 1.0, 0.0)
    }
    SubShader
    {
        Tags {
            "Queue"="Transparent"
            "RenderType"="TransparentCutout"
            "ForceNoShadowCasting"="True"
            "IgnoreProjector"="True"
        }
        Pass
        {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend One OneMinusSrcAlpha

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            uniform sampler2D _MainTex; uniform half4 _MainTex_ST;
            uniform fixed _Opacity;
            uniform half3 _RingScaleParams;
            uniform half3 _SwingXParams;
            uniform half3 _SwingZParams;
            uniform half3 _SwingYParams;
            uniform half3 _ShakeHeadParams;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv0 : TEXCOORD0;
                float4 color :COLOR;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 color :COLOR;
            };

            #define TWO_PI 6.283185

            void Ghost(inout float3 vertex, inout float3 color) {
                // Ring scaling
                float scale = _RingScaleParams.x * color.g * sin(frac(_Time.y * _RingScaleParams.y) * TWO_PI);
                vertex.xyz *= 1.0 + scale;
                vertex.y -= _RingScaleParams.z * scale;
                //vertex.xz *= 1.0 + scale;

                // Swing
                float swingX = _SwingXParams.x * sin(frac(_Time.y * _SwingXParams.y + vertex.y * _SwingXParams.z) * TWO_PI);
                float swingZ = _SwingZParams.x * sin(frac(_Time.y * _SwingZParams.y + vertex.y * _SwingZParams.z) * TWO_PI);
                vertex.xz += float2(swingX, swingZ) * color.r;

                // Head shaking
                float radY = radians(_ShakeHeadParams.x) * (1.0 - color.r) * sin(frac(_Time.y * _ShakeHeadParams.y - color.g * _ShakeHeadParams.z) * TWO_PI);
                float sinY, cosY = 0;
                sincos(radY, sinY, cosY);
                vertex.xz = float2(
                    vertex.x * cosY - vertex.z * sinY,
                    vertex.x * sinY + vertex.z * cosY
                );

                // Floating
                float swingY = _SwingYParams.x * sin(frac(_Time.y * _SwingYParams.y - color.g * _SwingYParams.z) * TWO_PI);
                vertex.y += swingY;

                // Vertex color
                float lightness = 1.0 + color.g * 1.0 + scale * 2.0; // Highlight + flash
                color = float3(lightness, lightness, lightness);
            }

            v2f vert (appdata v)
            {
                v2f o;
                Ghost(v.vertex.xyz, v.color.rgb);
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv0 = TRANSFORM_TEX(v.uv0, _MainTex);
                o.color = v.color;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 var_MainTex = tex2D(_MainTex, i.uv0);
                fixed3 finalRGB = var_MainTex.rgb * i.color.rgb;
                fixed opacity = var_MainTex.a * _Opacity;
                return fixed4(finalRGB * opacity, opacity);
            }
            ENDCG
        }
    }
}
