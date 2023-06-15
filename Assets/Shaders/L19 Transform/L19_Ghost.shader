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
                float scale = _RingScaleParams.x * color.g * sin(frac(_Time.y * _RingScaleParams.y) * TWO_PI);
                vertex.xz *= 1.0 + scale;
                //vertex.y -= _RingScaleParams.z * scale;
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
                fixed3 finalRGB = var_MainTex.rgb;
                fixed opacity = var_MainTex.a * _Opacity;
                return fixed4(finalRGB * opacity, opacity);
            }
            ENDCG
        }
    }
}
