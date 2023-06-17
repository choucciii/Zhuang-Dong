Shader "ZhuangDong/L21/Dissolving"
{
    Properties
    {
        [Header(Textures)]
            _MainTex        ("MainTexture   RGB: BaseColor A: AO", 2D)                                  = "white" {}
            [Normal]
            _NormMap        ("NormalMap", 2D)                                                           = "bump" {}
            _SpecTex        ("SpecTexture   RGB: SpecCol A: SpecPow", 2D)                               = "gray" {}
            _EmisTex        ("EmissiveTexure", 2D)                                                      = "black" {}
            _Cubemap        ("Cubemap", Cube)                                                           = "_Skybox" {}
        [Header(Diffuse)]
            _MainCol        ("MainColor", Color)                                                        = (0.5, 0.5, 0.5, 1.0)
            _EnvTopCol      ("EnvTopColor", Color)                                                      = (1.0, 1.0, 1.0, 1.0)
            _EnvSideCol     ("EnvSideColor", Color)                                                     = (0.5, 0.5, 0.5, 1.0)
            _EnvButCol      ("EnvButColor", Color)                                                      = (0.0, 0.0, 0.0, 1.0)
            _EnvDiffInt     ("EnvDiffIntensity", Range(0, 1))                                           = 0.2
        [Header(Specular)]
            [PowerSlider(2)]
            _SpecPow        ("SpecularPower", Range(1, 90))                                             = 30
            _EnvSpecInt     ("EnvSpecIntensity", Range(0, 5))                                           = 0.2
            _FresnelPow     ("FresnelPower", Range(0, 5))                                               = 1.0
            _CubemapMip     ("CubemapMip", Range(1, 7))                                                 = 1.0
        [Header(Emission)]
            _EmisInt        ("EmissiveIntensity", Range(1, 10))                                         = 1.0
        [Header(Dissolve)]
            _EffectMap      ("EffectMap", 2D)                                                           = "gray" {}
            _NoiseMap       ("NoiseMap", 2D)                                                            = "gray" {}
            [HDR]
            _EffectCol      ("EffectColor", color)                                                      = (0.0, 0.0, 0.0, 0.0)
            _EffectParams   ("EffectParams   X: Density Y: Speed Z: Randomness W: DisolveInt", vector)  = (0.03, 3.0, 0.3, 2.5)
    }
    SubShader
    {
        Tags {
            "Queue"="Transparent"
            "RenderType"="Transparent"
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
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "../L11 cginc/MyCginc.cginc"
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
            // Dissolve
            uniform sampler2D _EffectMap;
            uniform sampler2D _NoiseMap;
            uniform float3 _EffectCol;
            uniform float4 _EffectParams;

            struct appdata
            {
                float4 vertex   : POSITION;
                float2 uv0      : TEXCOORD0;
                float2 uv1      : TEXCOORD1;
                float3 normal   : NORMAL;
                float4 tangent  : TANGENT;
                float4 color    : COLOR;
            };

            struct v2f
            {
                float4 pos          : SV_POSITION;
                float2 uv0          : TEXCOORD0;
                float2 uv1          : TEXCOORD1;
                float4 posWS        : TEXCOORD2;
                float3 nDirWS       : TEXCOORD3; 
                float3 tDirWS       : TEXCOORD4;
                float3 bDirWS       : TEXCOORD5;
                float4 effectMask   : TEXCOORD6;
                LIGHTING_COORDS(7, 8)
            };

            float4 Dissolve(float noise, float mask, float3 normal, inout float3 vertex) {
                // Sawtooth wave
                float baseMask = abs(frac(vertex.y * _EffectParams.x - _Time.x * _EffectParams.y) - 0.5) * 2.0;
                // Trapezoidal wave
                baseMask = min(1.0, baseMask * 2.0); // nb
                // Add noise
                baseMask += (noise - 0.5) * _EffectParams.z;
                baseMask = saturate(baseMask);
                // SmoothStep get different gradient masks
                float4 effectMask = float4(0.0, 0.0, 0.0, 0.0);
                effectMask.r = smoothstep(0.0, 0.9, baseMask);
                effectMask.g = smoothstep(0.2, 0.7, baseMask);
                effectMask.b = smoothstep(0.4, 0.5, baseMask);
                
                effectMask.w = mask;

                vertex.xz += normal.xz * (1.0 - effectMask.y) * _EffectParams.w * mask;

                return effectMask;
            }

            v2f vert (appdata v)
            {
                float noise = tex2Dlod(_NoiseMap, float4(v.uv1, 0.0, 0.0)).r; // To sample texture in vert, use tex2Dlod
                v2f o = (v2f)0;
                    o.effectMask = Dissolve(noise, v.color.r, v.normal.xyz, v.vertex.xyz);
                    o.pos = UnityObjectToClipPos(v.vertex);
                    o.uv0 = v.uv0;
                    o.uv1 = v.uv1;
                    o.posWS = mul(unity_ObjectToWorld, v.vertex);
                    o.nDirWS = UnityObjectToWorldNormal(v.normal);
                    o.tDirWS = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz);
                    o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w);
                    TRANSFER_VERTEX_TO_FRAGMENT(o);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target // Color
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
                // Sample textures
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

                    // Dissolve
                    // R: MeshMask G: FaceRandomMask B: FaceGradientMask
                    float3 _EffectMap_var = tex2D(_EffectMap, i.uv1).rgb;
                    // Calculate opacity
                    float midOpacity = saturate(floor(min(0.999999, _EffectMap_var.g) + i.effectMask.g));
                    float wideOpacity = saturate(floor(min(0.999999, _EffectMap_var.b) + i.effectMask.b));
                    float opacity = lerp(1.0, min(midOpacity, wideOpacity), i.effectMask.w); // Why min?
                    // Emission
                    float meshEmisInt = (i.effectMask.b - i.effectMask.r) * _EffectMap_var.r;
                    meshEmisInt *= meshEmisInt;
                    emission += _EffectCol * meshEmisInt * i.effectMask.w;

                    // Final Blend
                    float3 finalRGB = dirLighting + envLighting + emission;
                // Final Result
                return float4(finalRGB * opacity, opacity);
            }
            ENDCG
        }
    }
}
