Shader "ZhuangDong/L05/OldSchool" {
    Properties {
        _MainColor ("MainColor", color) = (1.0, 1.0, 1.0, 1.0)
        _SpecularPower ("SpecularPower", range(1, 60)) = 30
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
            float3 _MainColor;
            float _SpecularPower;

            struct appdata {
                float4 vertex : POSITION;
                float4 normal : NORMAL;
            };

            struct v2f {
                float4 posCS : SV_POSITION;
                float4 posWS : TEXCOORD0;
                float3 nDirWS : TEXCOORD1;
            };

            v2f vert (appdata v) {
                v2f o; // = (v2f)0
                o.posCS = UnityObjectToClipPos(v.vertex);
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            float4 frag (v2f i) : COLOR {
                float3 nDir = normalize(i.nDirWS);
                float3 lDir = normalize(_WorldSpaceLightPos0.xyz);
                float3 vDir = normalize(_WorldSpaceCameraPos.xyz - i.posWS);
                float3 hDir = normalize(lDir + vDir);
                float3 rDir = reflect(-lDir, nDir);

                float nDotl = dot(nDir, lDir);
                float nDoth = dot(nDir, hDir);
                float vDotr = dot(vDir, rDir);

                float lambert = max(0, nDotl);
                float blinnPhong = pow(max(0, nDoth), _SpecularPower);
                float phong = pow(max(0, vDotr), _SpecularPower);
                float3 finalRGB = _MainColor * lambert + phong; // 注意矩阵乘法 移动显卡将float视为一维矩阵

                return float4(finalRGB, 1.0);
            }
            ENDCG
        }
    }
    //FallBack "Diffuse"
}
