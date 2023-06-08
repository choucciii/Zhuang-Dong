Shader "ZhuangDong/L12/Dota2"
{
    Properties
    {
        [Header(Textures)]
            _MainTex    ("MainTexture   RGB: BaseColor A: Opacity", 2d)         = "white" {}
            _MaskTex    ("R: SpecInt G: RimInt B: SpecTint A: SpecPow", 2d)     = "black" {}
            _NormMap    ("NormalMap", 2d)                                       = "bump" {}
            _MetalMask  ("MetallicMask", 2d)                                    = "black" {}
            _EmiMask    ("EmissionMask", 2d)                                    = "black" {}
            _DiffWarp   ("DiffuseWarpTex", 2d)                                  = "gray" {}
            _FresWarp   ("FresnelWarpTex", 2d)                                  = "gray" {}
            _Cubemap    ("Cubemap", cube)                                       = "_Skybox" {}
        [Header(DirDiff)]
            _LightCol   ("LightColor", color)                                   = (1.0, 1.0, 1.0, 1.0)
        [Header(DirSpec)]
            [PowerSlider(2)]
            _SpecPow    ("SpecularPower", range(1.0, 30.0))                     = 5.0
            _DirSpecInt ("DirLightSpecularIntensity", range(0.0, 10.0))         = 5.0
        [Header(EnvDiff)]
            _EnvCol     ("EnvLightColor", color)                                = (1.0, 1.0, 1.0, 1.0)
        [Header(EnvSpec)]
            _EnvSpecInt ("EnvLightSpecularIntensity", range(0.0, 30.0))         = 5.0
        [Header(RimLight)]
            [HDR]
            _RimCol     ("RimLightColor", color)                                = (1.0, 1.0, 1.0, 1.0)
        [Header(Emission)]
            _EmiInt     ("EmissionIntensity", range(0.0, 10.0))                 = 1.0 // EmissiveColor
        [HideInInspector]
            _Cutoff     ("AlphaCutoutThreshold", range(0, 1))                   = 0.5
        [HideInInspector]
            _Color      ("Main Color", Color)                                   = (1.0, 1.0, 1.0, 1.0)
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
                "LightMode"="ForwardBase"
            }
            
            Cull Off

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
            uniform sampler2D _MaskTex;
            uniform sampler2D _NormMap;
            uniform sampler2D _MetalMask;
            uniform sampler2D _EmiMask;
            uniform sampler2D _DiffWarp;
            uniform sampler2D _FresWarp;
            uniform samplerCUBE _Cubemap;
            // Dir
            uniform half3 _LightCol;
            uniform half _SpecPow;
            uniform half _DirSpecInt;
            // Env
            uniform half3 _EnvCol;
            uniform half _EnvSpecInt;
            // Rim
            uniform half3 _RimCol;
            // Emi
            uniform half _EmiInt;
            //
            uniform half _Cutoff;

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
                v2f o = (v2f)0;
                    o.pos = UnityObjectToClipPos(v.vertex);
                    o.uv0 = v.uv0;
                    o.posWS = mul(unity_ObjectToWorld, v.vertex);
                    o.nDirWS = UnityObjectToWorldNormal(v.normal);
                    o.tDirWS = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz);
                    o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w);
                    TRANSFER_VERTEX_TO_FRAGMENT(o);
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                // Prepare vectors
                half3 nDirTS = UnpackNormal(tex2D(_NormMap, i.uv0)).rgb;
                half3x3 TBN = half3x3(i.tDirWS, i.bDirWS, i.nDirWS);
                half3 nDirWS = normalize(mul(nDirTS, TBN));
                half3 vDirWS = normalize(_WorldSpaceCameraPos.xyz - i.posWS.xyz);
                half3 vrDirWS = reflect(-vDirWS, nDirWS);
                half3 lDirWS = _WorldSpaceLightPos0.xyz;
                // Calculate advanced vectors
                half nDotl = dot(nDirWS, lDirWS);
                half lDotvr = dot(lDirWS, vrDirWS);
                half nDotv = dot(nDirWS, vDirWS);
                // Sample textures
                // TODO Macro
                half4 var_MainTex = tex2D(_MainTex, i.uv0);
                half4 var_MaskTex = tex2D(_MaskTex, i.uv0);
                half metallic = tex2D(_MetalMask, i.uv0).r;
                half emiInt = tex2D(_EmiMask, i.uv0).r;
                half3 var_FresWarp = tex2D(_FresWarp, nDotv);
                half3 envCube = texCUBElod(_Cubemap, float4(vrDirWS, lerp(8.0, 0.0, var_MaskTex.a))).rgb;
                // Extract data from merged textures
                half3 baseCol = var_MainTex.rgb;
                half opacity = var_MainTex.a;
                half specInt = var_MaskTex.r;
                half rimInt = var_MaskTex.g;
                half specTint = var_MaskTex.b;
                half specPow = var_MaskTex.a;
                half shadow = LIGHT_ATTENUATION(i);
                // BRDFs
                    // Colors
                    half3 diffCol = lerp(baseCol, half3(0.0, 0.0, 0.0), metallic);
                    half3 specCol = lerp(baseCol, half3(0.3, 0.3, 0.3), specTint);
                    // Fresnel
                    half3 fresnel = lerp(var_FresWarp, 0.0, metallic);
                    half fresCol = fresnel.r;
                    half fresRim = fresnel.g;
                    half fresSpec = fresnel.b;
                    // DirDiff
                    half halflambert = nDotl * 0.5 + 0.5;
                    half3 var_DiffWarp = tex2D(_DiffWarp, halflambert);
                    half3 dirDiff = diffCol * var_DiffWarp * _LightCol;
                    // DirSpec
                    half phong = pow(max(0.0, lDotvr), specPow * _SpecPow); // +1 ?
                    half lambert = max(0.0, nDotl);
                    half spec = phong * lambert;
                    spec = max(spec, fresSpec);
                    spec = spec * _DirSpecInt;
                    half3 dirSpec = specCol * spec * _LightCol;
                    // EnvDiff
                    half3 envDiff = diffCol * _EnvCol;
                    // EnvSpec
                    half reflectInt = max(fresSpec, metallic) * specInt;
                    half3 envSpec = specCol * reflectInt * envCube * _EnvSpecInt;
                    // RimLight
                    half3 rimLight = _RimCol * fresRim * rimInt * max(0.0, nDirWS.g);
                    // Emission
                    half3 emission = diffCol * emiInt * _EmiInt;
                    // Result
                    half3 finalRGB = (dirDiff + dirSpec) * shadow + envDiff + envSpec + rimLight + emission; // Clamp
                // AC
                clip(opacity - _Cutoff);
                return float4(finalRGB, 1.0);
            }
            ENDCG
        }
    }
    FallBack "Legacy Shaders/Transparent/Cutout/VertexLit"
}
