Shader "ZhuangDong/L23/CustomLightMap"
{
    Properties
    {
        [Header(Textures)]
            _MainTex            ("  MainTexture", 2D)                                                                               = "white" {}
            _MaskTex            ("  MaskTexture  R: Occlusion G: Roughness BA: Normal.xy", 2D)                                      = "gray" {}
            _Lightmap           ("  Lightmap  R: SkyLigOcc G: EmiInt B: GIInt A: Shadowmask", 2D)                                   = "white" {}
            _MetalDarken        ("  MetalDarken", Float)                                                                            = 0.0
        [Header(MainLight)]
            [Toggle]
            _MainLightOn        ("  MainLightOn", Float)                                                                            = 0.0
            [HDR]
            _MainLightCol       ("  MainLightColor", Color)                                                                         = (1.0, 1.0, 1.0, 1.0)
            [HDR]
            _HalfShadowCol      ("  HalfShadowColor", Color)                                                = (1.0, 1.0, 1.0, 1.0)
            _SpecParams         ("  SpecParams  X: NMetSpecPow Y: NMetSpecInt Z: MetSpecPow W: MetSpecInt ", Vector)                = (10.0, 1.0, 30.0, 1.0)
        [Header(MainLightGI)]
            [Toggle]
            _MainLightGIOn      ("  MainLightGIOn", Float)                                                                          = 0.0
            [HDR]
            _GICol              ("  GIColor", Color)                                                        = (1.0, 1.0, 1.0, 1.0)
            _GIPow              ("  GIPower", Float)                                                                                = 1.0
        [Header(SkyLight)]
            [Toggle]
            _SkyLightOn         ("  SkyLightOn", Float)                                                                             = 0.0
            _SkyCube            ("  SkyCubemap", Cube)                                                                              = "_Skybox" {}
            _SkyLightInt        ("  SkyLightIntensity", Float)                                                                      = 1.0
        [Header(EnvReflect)]
            [Toggle]
            _EnvReflectOn       ("  EnvReflectOn", Float)                                                                           = 0.0
            _EnvCube            ("  EnvCubemap", Cube)                                                                              = "_Skybox" {}
            _EnvReflectParams   ("  EnvReflectParams X: NMetCubeMip Y: NMetEnvRefInt Z: MetCubeMip Y: X: MetEnvRefInt", Vector)     = (7.0, 1.0, 1.0, 0.0)
            _FresnelPow         ("  FresnelPower", Float)                                                                           = 5.0
        [Header(Emission)]
            [Toggle]
            _EmissionOn         ("  EmissionOn", Float)                                                                             = 0.0
            [HDR]
            _EmiCol             ("  EmissiveColor", Color)                                                                          = (1.0, 1.0, 1.0, 1.0)
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
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            // Texture
            uniform sampler2D   _MainTex;
            uniform sampler2D   _MaskTex;
            uniform sampler2D   _Lightmap;
            uniform float       _MetalDarken;
            // MainLight
            uniform float       _MainLightOn;
            uniform float3      _MainLightCol;
            uniform float4      _HalfShadowCol;
            uniform float4      _SpecParams;
            // MainLightGI
            uniform float       _MainLightGIOn;
            uniform float3      _GICol;
            uniform float       _GIPow;
            // SkyLight
            uniform float       _SkyLightOn;
            uniform samplerCUBE _SkyCube;
            uniform float       _SkyLightInt;
            // EnvReflect
            uniform float       _EnvReflectOn;
            uniform samplerCUBE _EnvCube;
            uniform float4      _EnvReflectParams;
            uniform float       _FresnelPow;
            // EmitLight
            uniform float       _EmissionOn;
            uniform float3      _EmiCol;

            struct appdata
            {
                float4 vertex   : POSITION;
                float2 uv0      : TEXCOORD0;
                float2 uv1      : TEXCOORD1;
                float4 normal   : NORMAL;
                float4 tangent  : TANGENT;
            };

            struct v2f
            {
                float4 pos      : SV_POSITION;
                float4 uvs      : TEXCOORD0;
                float4 posWS    : TEXCOORD1; 
                float3 nDirWS   : TEXCOORD2;
                float3 tDirWS   : TEXCOORD3;
                float3 bDirWS   : TEXCOORD4;
            };

            v2f vert (appdata v)
            {
                v2f o = (v2f)0;
                    o.pos = UnityObjectToClipPos(v.vertex);
                    o.uvs = float4(v.uv0, v.uv1);
                    o.posWS = mul(unity_ObjectToWorld, v.vertex);
                    o.nDirWS = UnityObjectToWorldNormal(v.normal);
                    o.tDirWS = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz);
                    o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w);
                return o;
            }

            float3 DecodeNormal(float2 normalXY) {
                float2 nDirTSxy = normalXY * 2.0 - 1.0;
                float nDirTSz = sqrt(1.0 - nDirTSxy.x * nDirTSxy.x - nDirTSxy.y * nDirTSxy.y);
                return float3(nDirTSxy, nDirTSz);
            }

            float4 frag (v2f i) : SV_Target
            {
                // Sample textures
                float3 var_MainTex = tex2D(_MainTex, i.uvs.xy).rgb;
                float4 var_MaskTex = tex2D(_MaskTex, i.uvs.xy);
                float4 var_LightMap = tex2D(_Lightmap, i.uvs.zw);
                // Prepare vectors
                float3 nDirTS = DecodeNormal(var_MaskTex.zw);
                float3x3 TBN = float3x3(i.tDirWS, i.bDirWS, i.nDirWS);
                float3 nDirWS = normalize(mul(nDirTS, TBN));
                float3 vDirWS = normalize(_WorldSpaceCameraPos.xyz - i.posWS);
                float3 vrDirWS = reflect(-vDirWS, nDirWS);
                float3 lDirWS = _WorldSpaceLightPos0.xyz;
                // Calculate advanced vectors
                float nDotl = dot(nDirWS, lDirWS);
                float nDotv = dot(nDirWS, vDirWS);
                float vrDotl = dot(vrDirWS, lDirWS);
                // Extract surface data
                float occlusion = var_MaskTex.r;
                float roughness = var_MaskTex.g;
                float3 diffCol = var_MainTex * lerp(1.0, _MetalDarken, pow(roughness, 5.0));
                float specPow = max(1.0, lerp(_SpecParams.x, _SpecParams.z, roughness));
                float specInt = max(1.0, lerp(_SpecParams.y, _SpecParams.w, roughness));
                float reflectMip = clamp(lerp(_EnvReflectParams.x, _EnvReflectParams.z, roughness), 0.0, 7.0);
                float reflectInt = max(0.0, lerp(_EnvReflectParams.y, _EnvReflectParams.w, roughness));
                float fresnel = lerp(pow(1.0 - max(0.0, nDotv), _FresnelPow), 1.0, roughness);
                // Extract lighting data
                float skyLigOcc = var_LightMap.r;
                float emiInt = var_LightMap.g;
                float giInt = pow(var_LightMap.b, _GIPow);
                float shadowmask = var_LightMap.a;
                // Sample cubemap
                float3 var_SkyCube = texCUBElod(_SkyCube, float4(vrDirWS, 11.0)).rgb;
                float3 var_EnvCube = texCUBElod(_EnvCube, float4(vrDirWS, reflectMip)).rgb;
                // BRDFs
                    // MainLight
                        // Diffuse
                        float3 halfShadowCol = lerp(_HalfShadowCol, _MainLightCol, shadowmask);
                        float3 mainLigCol = lerp(_MainLightCol, halfShadowCol, _HalfShadowCol.a) * shadowmask;
                        float3 mainLigDiff = diffCol * mainLigCol * max(0.0, nDotl);
                        // Specular
                        float3 mainLigSpec = mainLigCol * pow(max(0.0, vrDotl), specPow) * specInt;
                        // Global Illumination
                        float3 mainLigGI = _GICol * occlusion * giInt;
                        // Add up
                        float3 mainLight = (mainLigDiff + mainLigSpec + mainLigGI * _MainLightGIOn) * _MainLightOn;
                    // OtherLights
                        // Diffuse
                        float3 skyLigDiff = diffCol * var_SkyCube * _SkyLightInt * skyLigOcc * occlusion;
                        float3 emiLigDiff = diffCol * _EmiCol * emiInt * occlusion;
                        // Specular
                        float3 envReflect = var_EnvCube * reflectInt * fresnel * occlusion;
                        // Add up
                        float3 otherLights = skyLigDiff * _SkyLightOn + emiLigDiff * _EmissionOn + envReflect * _EnvReflectOn;
                float3 finalRGB = mainLight + otherLights;
                return float4(finalRGB, 1.0);
            }
            ENDCG
        }
    }
}
