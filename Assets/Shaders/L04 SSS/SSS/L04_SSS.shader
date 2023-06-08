// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32984,y:32640,varname:node_3138,prsc:2|emission-9661-RGB;n:type:ShaderForge.SFN_LightVector,id:6905,x:31981,y:32797,varname:node_6905,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:1044,x:31981,y:32615,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:2902,x:32185,y:32705,varname:node_2902,prsc:2,dt:0|A-1044-OUT,B-6905-OUT;n:type:ShaderForge.SFN_RemapRange,id:7318,x:32372,y:32705,varname:node_7318,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-2902-OUT;n:type:ShaderForge.SFN_Slider,id:7422,x:32215,y:32928,ptovrint:False,ptlb:SSSPower,ptin:_SSSPower,varname:node_7422,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.1130435,max:1;n:type:ShaderForge.SFN_Append,id:2863,x:32566,y:32760,varname:node_2863,prsc:2|A-7318-OUT,B-7422-OUT;n:type:ShaderForge.SFN_Tex2d,id:9661,x:32761,y:32760,ptovrint:False,ptlb:SSSLut,ptin:_SSSLut,varname:node_9661,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:9fccb1d83bb707f4daf315856c7bc4bf,ntxv:0,isnm:False|UVIN-2863-OUT;n:type:ShaderForge.SFN_Slider,id:8027,x:32830,y:33383,ptovrint:False,ptlb:SpecularPower_copy,ptin:_SpecularPower_copy,varname:_SpecularPower_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:1,max:10;n:type:ShaderForge.SFN_Power,id:8617,x:33201,y:33246,varname:node_8617,prsc:2|VAL-5338-OUT,EXP-8027-OUT;n:type:ShaderForge.SFN_Max,id:5338,x:32987,y:33178,varname:node_5338,prsc:2|B-4354-OUT;n:type:ShaderForge.SFN_Vector1,id:4354,x:32773,y:33285,varname:node_4354,prsc:2,v1:0;n:type:ShaderForge.SFN_Dot,id:7940,x:32773,y:33113,varname:node_7940,prsc:2,dt:0;n:type:ShaderForge.SFN_Slider,id:8519,x:32894,y:33447,ptovrint:False,ptlb:SpecularPower_copy_copy,ptin:_SpecularPower_copy_copy,varname:_SpecularPower_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:1,max:10;n:type:ShaderForge.SFN_Power,id:2209,x:33265,y:33310,varname:node_2209,prsc:2|VAL-2764-OUT,EXP-8519-OUT;n:type:ShaderForge.SFN_Max,id:2764,x:33051,y:33242,varname:node_2764,prsc:2|B-1263-OUT;n:type:ShaderForge.SFN_Vector1,id:1263,x:32837,y:33349,varname:node_1263,prsc:2,v1:0;n:type:ShaderForge.SFN_Dot,id:8163,x:32837,y:33177,varname:node_8163,prsc:2,dt:0;proporder:7422-9661;pass:END;sub:END;*/

Shader "ZhuangDong/L04/SSS" {
    Properties {
        _SSSPower ("SSSPower", Range(0, 1)) = 0.1130435
        _SSSLut ("SSSLut", 2D) = "white" {}
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
            uniform sampler2D _SSSLut; uniform float4 _SSSLut_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _SSSPower)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float _SSSPower_var = UNITY_ACCESS_INSTANCED_PROP( Props, _SSSPower );
                float2 node_2863 = float2((dot(i.normalDir,lightDirection)*0.5+0.5),_SSSPower_var);
                float4 _SSSLut_var = tex2D(_SSSLut,TRANSFORM_TEX(node_2863, _SSSLut));
                float3 emissive = _SSSLut_var.rgb;
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
            uniform sampler2D _SSSLut; uniform float4 _SSSLut_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _SSSPower)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
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
