Shader "ZhuangDong/L07/OldSchool+" {
    Properties {
        _BaseColor ("BaseColor", color) = (1.0, 1.0, 1.0, 1.0)

        _LightColor ("LightColor", color) = (1.0, 1.0, 1.0, 1.0)
        _SpecularInt ("SpecularInt", range(0, 1)) = 0.5
        _SpecularPower ("SpecularPower", range(1, 60)) = 30

        _EnvUpColor ("EnvUpColor", color) = (1.0, 1.0, 1.0, 1.0)
        _EnvSideColor ("EnvSideColor", color) = (1.0, 1.0, 1.0, 1.0)
        _EnvDownColor ("EnvDownColor", color) = (1.0, 1.0, 1.0, 1.0)
        _EnvLightInt ("EnvLightInt", range(0, 1)) = 1
        _Occlusion ("Occlusion", 2d) = "white" { }
    }
    SubShader
    {
        Tags {
            "RenderType"="Opaque"
        }
        Pass
        {
            Name "FORWARD"
            Tags {
                "LightMode" = "ForwardBase"
            }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            //uniform, attribute, varying
            float3 _BaseColor;
            
            float3 _LightColor;
            float _SpecularInt;
            float _SpecularPower;

            float3 _EnvUpColor;
            float3 _EnvSideColor;
            float3 _EnvDownColor;
            float _EnvLightInt;
            sampler2D _Occlusion;
            
            struct appdata {
                float4 vertex : POSITION;
                float4 normal : NORMAL;
                float2 uv0 : TEXCOORD0;
            };

            struct v2f {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWS : TEXCOORD1;
                float3 nDirWS : TEXCOORD2;
                LIGHTING_COORDS(3, 4)
            };

            v2f vert (appdata v) {
                v2f o; // = (v2f)0
                o.pos = UnityObjectToClipPos(v.vertex);
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                TRANSFER_VERTEX_TO_FRAGMENT(o);
                o.uv0 = v.uv0;
                return o;
            }

            float4 frag (v2f i) : COLOR {
                float3 nDir = normalize(i.nDirWS);
                float3 lDir = normalize(_WorldSpaceLightPos0.xyz);
                float3 rDir = reflect(-lDir, nDir);
                float3 vDir = normalize(_WorldSpaceCameraPos.xyz - i.posWS);
                float3 hDir = normalize(lDir + vDir);

                float upMask = max(0.0, nDir.g);
                float downMask = max(0.0, -nDir.g);
                float sideMask = 1 - upMask - downMask;

                

                float nDotl = dot(nDir, lDir);
                float vDotr = dot(vDir, rDir);
                float nDoth = dot(nDir, hDir);


                
                //DirColor
                float lambert = max(0, nDotl);
                float phong = pow(max(0, vDotr), _SpecularPower);
                float blinnPhong = pow(max(0, nDoth), _SpecularPower);
                float shadow = LIGHT_ATTENUATION(i);
                float3 dirColor = (_BaseColor * lambert + phong * _SpecularInt) * _LightColor * shadow;

                //EnvColor
                float3 envLightColor = _EnvUpColor * upMask + _EnvSideColor * sideMask + _EnvDownColor * downMask;
                float occlusion = tex2D(_Occlusion, i.uv0);
                float3 envColor = envLightColor * _EnvLightInt * _BaseColor * occlusion;
                

                
                float3 finalColor = dirColor + envColor;
                
                return float4(finalColor, 1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
