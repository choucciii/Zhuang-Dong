Shader "ZhuangDong/L09/Cubemap" {
    Properties {
        _NormalMap ("NormalMap", 2D) = "bump" {}
        _Cubemap ("Cubemap", Cube) = "_Skybox" {}
        _CubemapMip ("CubemapMip", Range(0, 7)) = 0
        _AmbientOcclusion ("AmbientOcclusion", 2D) = "white" {}
        _FresnelPower ("FresnelPower", Range(0, 5)) = 0
        _EnvSpecInt ("EnvSpecInt", Range(0, 5)) = 0
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
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            uniform sampler2D _NormalMap;
            uniform samplerCUBE _Cubemap;
            uniform float _CubemapMip;
            uniform sampler2D _AmbientOcclusion;
            uniform float _FresnelPower;
            uniform float _EnvSpecInt;

            struct appdata {
                float4 vertex : POSITION;
                float2 uv0 : TEXCOORD0;
                float4 normal : NORMAL;
                float4 tangent : TANGENT;
            };

            struct v2f {
                float4 pos : SV_POSITION;
                float3 posWS : TEXCOORD0;
                float2 uv0 : TEXCOORD1;
                float3 nDirWS : TEXCOORD2;
                float3 tDirWS : TEXCOORD3;
                float3 bDirWS : TEXCOORD4;
            };

            v2f vert (appdata v) {
                v2f o = (v2f)0;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                o.uv0 = v.uv0;
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                o.tDirWS = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz);
                o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w);
                return o;
            }

            float4 frag (v2f i) : COLOR {
                float3 nDirTS = UnpackNormal(tex2D(_NormalMap, i.uv0)).rgb;
                float3x3 TBN = float3x3(i.tDirWS, i.bDirWS, i.nDirWS);
                float3 nDirWS = normalize(mul(nDirTS, TBN));
                float3 vDirWS = normalize(_WorldSpaceCameraPos.xyz - i.posWS.xyz);
                float3 vrDirWS = reflect(-vDirWS, nDirWS);

                float ndotv = dot(nDirWS, vDirWS);

                float3 cubemap = texCUBElod(_Cubemap, float4(vrDirWS, _CubemapMip));
                float3 ao = tex2D(_AmbientOcclusion, i.uv0).r;
                float fresnel = pow(1.0 - ndotv, _FresnelPower);
                float3 envSpecColor = cubemap * ao * fresnel * _EnvSpecInt;

                return float4(envSpecColor, 1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
