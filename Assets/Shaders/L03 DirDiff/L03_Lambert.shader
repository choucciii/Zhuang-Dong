Shader "ZhuangDong/L03/Lambert" {
    Properties {
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

            struct appdata {
                float4 vertex : POSITION;
                float4 normal : NORMAL;
            };

            struct v2f {
                float4 pos : SV_POSITION;
                float3 nDirWS : TEXCOORD0;
            };

            v2f vert (appdata v) {
                v2f o; // = (v2f)0
                o.pos = UnityObjectToClipPos(v.vertex);
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            float4 frag (v2f i) : COLOR {
                float3 nDir = i.nDirWS;
                float3 lDir = normalize(_WorldSpaceLightPos0.xyz); // Directional light's direction and point light's position
                float nDotl = dot(nDir, lDir);
                float lambert = max(0, nDotl);
                return float4(lambert, lambert, lambert, 1.0);
            }
            ENDCG
        }
    }
    //FallBack "Diffuse"
}
