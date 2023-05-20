Shader "ZhuangDong/L07/3ColAmbient" {
    Properties {
        _Occlusion ("Occlusion", 2d) = "white" { }
        _EnvUpColor ("EnvUpColor", color) = (1.0, 1.0, 1.0, 1.0) // 低端手机OSautocast有问题
        _EnvSideColor ("EnvSideColor", color) = (1.0, 1.0, 1.0, 1.0)
        _EnvDownColor ("EnvDownColor", color) = (1.0, 1.0, 1.0, 1.0)
    }
    SubShader
    {
        Tags {
            "RenderType"="Opaque"
        }
        Pass
        {
            // Name "FORWARD"
            // Tags {
            //     "LightMode" = "ForwardBase"
            // }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            //#pragma multi_compile_fwdbase_fullshadows
            //#pragma target 3.0

            //uniform, attribute, varying
            sampler2D _Occlusion;
            float3 _EnvUpColor;
            float3 _EnvSideColor;
            float3 _EnvDownColor;

            struct appdata {
                float4 vertex : POSITION;
                float4 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f {
                float4 pos : SV_POSITION;
                float3 nDirWS : TEXCOORD0;
                float2 uv : TEXCOORD1;
            };

            v2f vert (appdata v) {
                v2f o; // = (v2f)0
                o.pos = UnityObjectToClipPos(v.vertex);
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                o.uv = v.uv;
                return o;
            }

            float4 frag (v2f i) : COLOR {
                float3 nDir = normalize(i.nDirWS);

                float upMask = max(0.0, nDir.g);
                float downMask = max(0.0, -nDir.g);
                float sideMask = 1.0 - upMask - downMask;

                float3 envColor = _EnvUpColor * upMask + _EnvSideColor * sideMask + _EnvDownColor * downMask;
                float occlusion = tex2D(_Occlusion, i.uv);
                float3 finalColor = envColor * occlusion;

                return float4(finalColor, 1.0);
            }
            ENDCG
        }
    }
    //FallBack "Diffuse"
}
