﻿Shader "ZhuangDong/L10/OldSchoolPro"
{
    Properties
    {
        [Header(Textures)]
            _MainTex    ("MainTexture   RGB: BaseColor A: AO", 2D)          = "white" {}
            _NormMap    ("NormalMap", 2D)                                   = "bump" {}
            _SpecTex    ("SpecTexture   RGB: SpecCol A: SpecPow", 2D)       = "gray" {}
            _EmisTex    ("EmissiveTexure", 2D)                              = "black" {}
            _Cubemap    ("Cubemap", Cube)                                   = "_Skybox" {}
        [Header(Diffuse)]
            _MainCol    ("MainColor", Color)                                = (0.5, 0.5, 0.5, 1.0)
            _EnvTopCol  ("EnvTopColor", Color)                              = (1.0, 1.0, 1.0, 1.0)
            _EnvSideCol ("EnvSideColor", Color)                             = (0.5, 0.5, 0.5, 1.0)
            _EnvButCol  ("EnvButColor", Color)                              = (0.0, 0.0, 0.0, 1.0)
            _EnvDiffInt ("EnvDiffIntensity", Range(0, 1))                   = 0.2
        [Header(Specular)]
            [PowerSlider(2)] _SpecPow    ("SpecularPower", Range(1, 90))    = 30
            _EnvSpecInt ("EnvSpecIntensity", Range(0, 5))                   = 0.2
            _FresnelPow ("FresnelPower", Range(0, 5))                       = 1.0
            _CubemapMip ("CubemapMip", Range(1, 7))                         = 1.0
        [Header(Emission)]
            _EmisInt    ("EmissiveIntensity", Range(1, 10))                 = 1.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
              
        Pass
        {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            // Textures
            uniform sampler2D _MainTex;
            uniform sampler2D _NormMap;
            uniform sampler2D _SpecTex;
            uniform sampler2D _EmisTex;
            uniform samplerCUBE _Cubemap;
            // Diffuse
            uniform float3 _MainCol;
            uniform float3 _EnvTopCol;
            uniform float3 _EnvSideCol;
            uniform float3 _EnvButCol;
            uniform float _EnvDiffInt;
            // Specular
            uniform float _SpecPow;
            uniform float _EnvSpecInt;
            uniform float _FresnelPow;
            uniform float _CubemapMip;
            // Emission
            uniform float _EmisInt;

            struct appdata
            {
                float4 vertex   : POSITION;
                float2 uv0       : TEXCOORD0;
                float3 normal   : NORMAL;
                float4 tangent  : TANGENT;
            };

            struct v2f
            {
                float4 pos      : SV_POSITION;
                float2 uv0       : TEXCOORD0;
                float4 posWS    : TEXCOORD1;
                float3 nDirWS   : TEXCOORD2;
                float3 tDirWS   : TEXCOORD3;
                float3 bDirWS   : TEXCOORD4;
                LIGHTING_COORDS(5, 6)
            };

            v2f vert (appdata v)
            {
                v2f o;
                    o.pos = UnityObjectToClipPos(v.vertex);
                    o.uv0 = v.uv0;
                    o.posWS = mul(unity_ObjectToWorld, v.vertex);
                    o.nDirWS = UnityObjectToWorldNormal(v.normal);
                    o.tDirWS = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz);
                    o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w);
                    TRANSFER_VERTEX_TO_FRAGMENT(o);
                return o;
            }

            float3 TriColAmbient(float3 normal, float3 topCol, float3 sideCol, float3 butCol) {
                float topMask = max(0.0, normal.g);
                float butMask = max(0.0, -normal.g);
                float sideMask = 1 - topMask - butMask;
                float3 envCol = topCol * topMask +
                                sideCol * sideMask +
                                butCol * butMask;
                return envCol;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // Prepare vectors
                float3 nDirTS = UnpackNormal(tex2D(_NormMap, i.uv0)).rgb;
                float3x3 TBN = float3x3(i.tDirWS, i.bDirWS, i.nDirWS);
                float3 nDirWS = normalize(mul(nDirTS, TBN));
                float3 vDirWS = normalize(_WorldSpaceCameraPos.xyz - i.posWS.xyz);
                float3 vrDirWS = reflect(-vDirWS, nDirWS);
                float3 lDirWS = _WorldSpaceLightPos0.xyz;
                float3 lrDirWS = reflect(-lDirWS, nDirWS);
                // Calculate advanced vectors
                float nDotl = dot(nDirWS, lDirWS);
                float vDotr = dot(vDirWS, lrDirWS);
                float nDotv = dot(nDirWS, vDirWS);
                // Sample Textures
                float4 var_MainTex = tex2D(_MainTex, i.uv0);
                float4 var_SpecTex = tex2D(_SpecTex, i.uv0);
                float3 var_EmisTex = tex2D(_EmisTex, i.uv0).rgb;
                float3 var_Cubemap = texCUBElod(_Cubemap, float4(vrDirWS, lerp(_CubemapMip, 0.0, var_SpecTex.a))).rgb;
                // BRDFs
                    // Directional Light Diffuse
                    float3 baseCol = var_MainTex.rgb * _MainCol;
                    float lambert = max(0.0, nDotl);
                    // Directional Light Specular
                    float specCol = var_SpecTex.rgb;
                    float specPow = lerp(1.0, _SpecPow, var_SpecTex.a);
                    float phong = pow(max(0.0, vDotr), specPow);
                    // Directional Light Result
                    float shadow = LIGHT_ATTENUATION(i);
                    float3 dirLighting = (baseCol * lambert + specCol * phong) * _LightColor0 * shadow;

                    // Environmental Light Diffuse
                    // float topMask = max(0.0, nDirWS.g);
                    // float butMask = max(0.0, -nDirWS.g);
                    // float sideMask = 1 - topMask - butMask;
                    // float3 envCol = _EnvTopCol * topMask +
                    //                 _EnvSideCol * sideMask +
                    //                 _EnvButCol * butMask;
                    float3 envCol = TriColAmbient(nDirWS, _EnvTopCol, _EnvSideCol, _EnvButCol);
                    float3 envDiff = baseCol * envCol * _EnvDiffInt;
                    // Environmental Light Specular
                    float fresnel = pow(1.0 - nDotv, _FresnelPow);
                    float3 envSpec = var_Cubemap * fresnel * _EnvSpecInt;
                    // Environmental Light Result
                    float occlusion = var_MainTex.a;
                    float3 envLighting = (envDiff + envSpec) * occlusion;

                    // Emission
                    float emisInt = _EmisInt * (sin(frac(_Time.z)) * 0.5 + 0.5);
                    float3 emission = var_EmisTex * emisInt;

                    // Final Blend
                    float3 finalRGB = dirLighting + envLighting + emission;
                // Final Result
                return float4(finalRGB, 1.0);
            }
            ENDCG
        }
    }
}
