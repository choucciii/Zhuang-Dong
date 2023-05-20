// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33664,y:32597,varname:node_3138,prsc:2|emission-7667-OUT;n:type:ShaderForge.SFN_NormalVector,id:3801,x:31609,y:32715,prsc:2,pt:False;n:type:ShaderForge.SFN_ComponentMask,id:2662,x:31788,y:32715,varname:node_2662,prsc:2,cc1:1,cc2:-1,cc3:-1,cc4:-1|IN-3801-OUT;n:type:ShaderForge.SFN_Max,id:7489,x:32196,y:32600,varname:node_7489,prsc:2|A-2662-OUT,B-1529-OUT;n:type:ShaderForge.SFN_Vector1,id:1529,x:32003,y:32704,varname:node_1529,prsc:2,v1:0;n:type:ShaderForge.SFN_Multiply,id:6734,x:32199,y:32907,varname:node_6734,prsc:2|A-6665-OUT,B-2662-OUT;n:type:ShaderForge.SFN_Vector1,id:6665,x:32003,y:32812,varname:node_6665,prsc:2,v1:-1;n:type:ShaderForge.SFN_Max,id:2506,x:32413,y:32798,varname:node_2506,prsc:2|A-1529-OUT,B-6734-OUT;n:type:ShaderForge.SFN_Subtract,id:487,x:32413,y:32668,varname:node_487,prsc:2|A-1455-OUT,B-7489-OUT;n:type:ShaderForge.SFN_Subtract,id:8207,x:32622,y:32668,varname:node_8207,prsc:2|A-487-OUT,B-2506-OUT;n:type:ShaderForge.SFN_Vector1,id:1455,x:32003,y:32759,varname:node_1455,prsc:2,v1:1;n:type:ShaderForge.SFN_Color,id:4246,x:32196,y:32427,ptovrint:False,ptlb:EnvUpColor,ptin:_EnvUpColor,varname:node_4246,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:1459,x:32413,y:32538,varname:node_1459,prsc:2|A-4246-RGB,B-7489-OUT;n:type:ShaderForge.SFN_Color,id:791,x:32413,y:32952,ptovrint:False,ptlb:EnvDownColor,ptin:_EnvDownColor,varname:node_791,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:7906,x:32622,y:32798,varname:node_7906,prsc:2|A-2506-OUT,B-791-RGB;n:type:ShaderForge.SFN_Color,id:3361,x:32622,y:32508,ptovrint:False,ptlb:EnvSideColor,ptin:_EnvSideColor,varname:node_3361,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:919,x:32837,y:32567,varname:node_919,prsc:2|A-3361-RGB,B-8207-OUT;n:type:ShaderForge.SFN_Add,id:4957,x:33044,y:32675,varname:node_4957,prsc:2|A-919-OUT,B-1459-OUT;n:type:ShaderForge.SFN_Add,id:8829,x:33236,y:32675,varname:node_8829,prsc:2|A-4957-OUT,B-7906-OUT;n:type:ShaderForge.SFN_Tex2d,id:4056,x:33236,y:32829,ptovrint:False,ptlb:Occlusion,ptin:_Occlusion,varname:node_4056,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:1f2ff6f43dffdd847993d13e3f3a6943,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:7667,x:33430,y:32675,varname:node_7667,prsc:2|A-8829-OUT,B-4056-RGB;proporder:4056-4246-3361-791;pass:END;sub:END;*/

Shader "ZhuangDong/L07/3ColAmbient_SF" {
    Properties {
        _Occlusion ("Occlusion", 2D) = "white" {}
        _EnvUpColor ("EnvUpColor", Color) = (0.5,0.5,0.5,1)
        _EnvSideColor ("EnvSideColor", Color) = (0.5,0.5,0.5,1)
        _EnvDownColor ("EnvDownColor", Color) = (0.5,0.5,0.5,1)
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
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _Occlusion; uniform float4 _Occlusion_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _EnvUpColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _EnvDownColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _EnvSideColor)
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
                float3 normalDir : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float4 _EnvSideColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvSideColor );
                float node_2662 = i.normalDir.g;
                float node_1529 = 0.0;
                float node_7489 = max(node_2662,node_1529);
                float node_2506 = max(node_1529,((-1.0)*node_2662));
                float4 _EnvUpColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvUpColor );
                float4 _EnvDownColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvDownColor );
                float4 _Occlusion_var = tex2D(_Occlusion,TRANSFORM_TEX(i.uv0, _Occlusion));
                float3 emissive = ((((_EnvSideColor_var.rgb*((1.0-node_7489)-node_2506))+(_EnvUpColor_var.rgb*node_7489))+(node_2506*_EnvDownColor_var.rgb))*_Occlusion_var.rgb);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
