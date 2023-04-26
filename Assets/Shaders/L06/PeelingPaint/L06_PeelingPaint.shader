// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33210,y:32504,varname:node_3138,prsc:2|emission-3141-OUT;n:type:ShaderForge.SFN_ViewReflectionVector,id:557,x:31833,y:32664,varname:node_557,prsc:2;n:type:ShaderForge.SFN_LightVector,id:7381,x:31833,y:32508,varname:node_7381,prsc:2;n:type:ShaderForge.SFN_Dot,id:2311,x:32056,y:32585,varname:node_2311,prsc:2,dt:0|A-7381-OUT,B-557-OUT;n:type:ShaderForge.SFN_Slider,id:4018,x:31922,y:32837,ptovrint:False,ptlb:SpecularPower_Metal,ptin:_SpecularPower_Metal,varname:node_4018,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:30,max:60;n:type:ShaderForge.SFN_Slider,id:1651,x:31922,y:32967,ptovrint:False,ptlb:SpecularPower_Paint,ptin:_SpecularPower_Paint,varname:_SpecularPower2,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:30,max:60;n:type:ShaderForge.SFN_NormalVector,id:2435,x:31833,y:32334,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:9770,x:32056,y:32395,varname:node_9770,prsc:2,dt:0|A-2435-OUT,B-7381-OUT;n:type:ShaderForge.SFN_Tex2d,id:6107,x:31882,y:33274,ptovrint:False,ptlb:NoiseMap,ptin:_NoiseMap,varname:node_6107,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:d365e3eb33f294241a94e2ef9a05700c,ntxv:0,isnm:False|UVIN-7444-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:7444,x:31674,y:33274,varname:node_7444,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Step,id:4980,x:32079,y:33274,cmnt:Desaturate 去色,varname:node_4980,prsc:2|A-6107-RGB,B-1762-OUT;n:type:ShaderForge.SFN_Slider,id:1762,x:31674,y:33496,ptovrint:False,ptlb:PaintRange,ptin:_PaintRange,varname:node_1762,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5,max:1;n:type:ShaderForge.SFN_Max,id:2553,x:32400,y:32435,varname:node_2553,prsc:2|A-9770-OUT,B-810-OUT;n:type:ShaderForge.SFN_Vector1,id:810,x:32188,y:32505,varname:node_810,prsc:2,v1:0;n:type:ShaderForge.SFN_Max,id:6984,x:32400,y:32568,varname:node_6984,prsc:2|A-810-OUT,B-2311-OUT;n:type:ShaderForge.SFN_Power,id:9418,x:32724,y:32634,varname:node_9418,prsc:2|VAL-6984-OUT,EXP-8772-OUT;n:type:ShaderForge.SFN_Lerp,id:8772,x:32400,y:32780,varname:node_8772,prsc:2|A-4018-OUT,B-1651-OUT,T-4980-OUT;n:type:ShaderForge.SFN_Multiply,id:7161,x:32724,y:32487,varname:node_7161,prsc:2|A-2217-OUT,B-2553-OUT;n:type:ShaderForge.SFN_Color,id:229,x:32079,y:33084,ptovrint:False,ptlb:PaintColor,ptin:_PaintColor,varname:node_229,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Color,id:2522,x:31922,y:33084,ptovrint:False,ptlb:MetalColor,ptin:_MetalColor,varname:node_2522,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Lerp,id:2217,x:32400,y:32987,varname:node_2217,prsc:2|A-2522-RGB,B-229-RGB,T-4980-OUT;n:type:ShaderForge.SFN_Add,id:3141,x:32957,y:32562,varname:node_3141,prsc:2|A-7161-OUT,B-9418-OUT;proporder:6107-1762-2522-229-4018-1651;pass:END;sub:END;*/

Shader "ZhuangDong/L06/PeelingPaint" {
    Properties {
        _NoiseMap ("NoiseMap", 2D) = "white" {}
        _PaintRange ("PaintRange", Range(0, 1)) = 0.5
        _MetalColor ("MetalColor", Color) = (0.5,0.5,0.5,1)
        _PaintColor ("PaintColor", Color) = (0.5,0.5,0.5,1)
        _SpecularPower_Metal ("SpecularPower_Metal", Range(1, 60)) = 30
        _SpecularPower_Paint ("SpecularPower_Paint", Range(1, 60)) = 30
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _NoiseMap; uniform float4 _NoiseMap_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _SpecularPower_Metal)
                UNITY_DEFINE_INSTANCED_PROP( float, _SpecularPower_Paint)
                UNITY_DEFINE_INSTANCED_PROP( float, _PaintRange)
                UNITY_DEFINE_INSTANCED_PROP( float4, _PaintColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _MetalColor)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float4 _MetalColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _MetalColor );
                float4 _PaintColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _PaintColor );
                float4 _NoiseMap_var = tex2D(_NoiseMap,TRANSFORM_TEX(i.uv0, _NoiseMap));
                float _PaintRange_var = UNITY_ACCESS_INSTANCED_PROP( Props, _PaintRange );
                float3 node_4980 = step(_NoiseMap_var.rgb,_PaintRange_var); // Desaturate 去色
                float node_810 = 0.0;
                float _SpecularPower_Metal_var = UNITY_ACCESS_INSTANCED_PROP( Props, _SpecularPower_Metal );
                float _SpecularPower_Paint_var = UNITY_ACCESS_INSTANCED_PROP( Props, _SpecularPower_Paint );
                float3 emissive = ((lerp(_MetalColor_var.rgb,_PaintColor_var.rgb,node_4980)*max(dot(i.normalDir,lightDirection),node_810))+pow(max(node_810,dot(lightDirection,viewReflectDirection)),lerp(float3(_SpecularPower_Metal_var,_SpecularPower_Metal_var,_SpecularPower_Metal_var),float3(_SpecularPower_Paint_var,_SpecularPower_Paint_var,_SpecularPower_Paint_var),node_4980)));
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma target 3.0
            uniform sampler2D _NoiseMap; uniform float4 _NoiseMap_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _SpecularPower_Metal)
                UNITY_DEFINE_INSTANCED_PROP( float, _SpecularPower_Paint)
                UNITY_DEFINE_INSTANCED_PROP( float, _PaintRange)
                UNITY_DEFINE_INSTANCED_PROP( float4, _PaintColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _MetalColor)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
////// Lighting:
                float3 finalColor = 0;
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
