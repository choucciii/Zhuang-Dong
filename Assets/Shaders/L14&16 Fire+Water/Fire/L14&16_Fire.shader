Shader "ZhuangDong/L14&16/Fire"
{
    Properties
    {
        _Mask               ("R: Outer G: Inner B: Alpha A: Intensity Mask", 2d)        = "blue" {}
        _Noise              ("R: Noise1 G: Noise2 ", 2d)                                = "gray" {}
        _Noise1Params       ("Noise1Params   X: Scale Y: Speed Z: Intensity", vector)   = (1.0, 0.2, 0.2, 1.0)
        _Noise2Params       ("Noise2Params   X: Scale Y: Speed Z: Intensity", vector)   = (1.0, 0.2, 0.2, 1.0)
        [HDR]_OuterColor    ("Outer flame Color", color)                                = (1.0, 1.0, 1.0, 1.0)
        [HDR]_InnerColor    ("Inner flame Color", color)                                = (1.0, 1.0, 1.0, 1.0)
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

            uniform sampler2D _Mask;
            uniform sampler2D _Noise;
            uniform half3 _Noise1Params;
            uniform half3 _Noise2Params;
            uniform half3 _OuterColor;
            uniform half3 _InnerColor;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv0 : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv0 = v.uv0;
                o.uv1 = v.uv0 * _Noise1Params.x - float2(0.0, frac(_Time.x * _Noise1Params.y));
                o.uv2 = v.uv0 * _Noise2Params.x - float2(0.0, frac(_Time.x * _Noise2Params.y));
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // TODO
                // Merge alpha mask (blue channel here) in alpha channel
                // Place a white to black gradient in the buttom
                // So the buttom part wont be distorted by multiplying this value
                half2 warpMask =  tex2D(_Mask, i.uv0).ba; // Texture compression cause distortion in each channel

                half var_Noise1 = tex2D(_Noise, i.uv1).r;
                half var_Noise2 = tex2D(_Noise, i.uv2).g;

                half noise = var_Noise1 * _Noise1Params.z + var_Noise2 * _Noise2Params.z;

                float2 warpUV = i.uv0 - float2(0.0, noise) * warpMask.r * warpMask.g;
                
                half3 var_Mask = tex2D(_Mask, warpUV);

                half3 finalRGB = _OuterColor * var_Mask.r + _InnerColor * var_Mask.g;
                half opacity = var_Mask.r + var_Mask.g;
                
                return fixed4(finalRGB, opacity);
            }
            ENDCG
        }
    }
}
