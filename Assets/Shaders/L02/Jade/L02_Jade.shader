// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:6306,x:33040,y:33127,varname:node_6306,prsc:2|emission-799-OUT;n:type:ShaderForge.SFN_NormalVector,id:5338,x:31279,y:32485,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:2474,x:31279,y:32662,varname:node_2474,prsc:2;n:type:ShaderForge.SFN_Dot,id:2528,x:31503,y:32572,varname:node_2528,prsc:2,dt:0|A-5338-OUT,B-2474-OUT;n:type:ShaderForge.SFN_Multiply,id:1167,x:31683,y:32572,varname:node_1167,prsc:2|A-2528-OUT,B-7522-OUT;n:type:ShaderForge.SFN_Vector1,id:7522,x:31478,y:32738,varname:node_7522,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Add,id:6372,x:31879,y:32572,varname:node_6372,prsc:2|A-1167-OUT,B-7522-OUT;n:type:ShaderForge.SFN_Vector4Property,id:7371,x:30939,y:32881,ptovrint:False,ptlb:HighlightOffset1,ptin:_HighlightOffset1,varname:node_7371,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0,v2:0,v3:0,v4:0;n:type:ShaderForge.SFN_Tex2d,id:4875,x:32250,y:32572,ptovrint:False,ptlb:RampTex,ptin:_RampTex,varname:node_4875,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:8da07e2944d0b7242bdfa50fe235a7d7,ntxv:0,isnm:False|UVIN-3510-OUT;n:type:ShaderForge.SFN_Append,id:3510,x:32071,y:32572,varname:node_3510,prsc:2|A-6372-OUT,B-7522-OUT;n:type:ShaderForge.SFN_Add,id:885,x:31178,y:32907,varname:node_885,prsc:2|A-7371-XYZ,B-3280-OUT;n:type:ShaderForge.SFN_LightVector,id:3280,x:30939,y:33040,varname:node_3280,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:3310,x:31385,y:33091,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:1659,x:31600,y:33015,varname:node_1659,prsc:2,dt:0|A-5820-OUT,B-3310-OUT;n:type:ShaderForge.SFN_Step,id:4682,x:31811,y:32904,varname:node_4682,prsc:2|A-9703-OUT,B-1659-OUT;n:type:ShaderForge.SFN_Slider,id:9703,x:31443,y:32879,ptovrint:False,ptlb:HighlightRange1,ptin:_HighlightRange1,varname:node_9703,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0.6,cur:0.6,max:1;n:type:ShaderForge.SFN_Normalize,id:5820,x:31385,y:32960,varname:node_5820,prsc:2|IN-885-OUT;n:type:ShaderForge.SFN_Vector4Property,id:5565,x:30942,y:33284,ptovrint:False,ptlb:HighlightOffset2,ptin:_HighlightOffset2,varname:_HighlightOffset2,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0,v2:0,v3:0,v4:0;n:type:ShaderForge.SFN_Add,id:6712,x:31181,y:33310,varname:node_6712,prsc:2|A-5565-XYZ,B-6224-OUT;n:type:ShaderForge.SFN_LightVector,id:6224,x:30942,y:33442,varname:node_6224,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:1600,x:31388,y:33494,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:5388,x:31603,y:33418,varname:node_5388,prsc:2,dt:0|A-6480-OUT,B-1600-OUT;n:type:ShaderForge.SFN_Step,id:8739,x:31807,y:33302,varname:node_8739,prsc:2|A-41-OUT,B-5388-OUT;n:type:ShaderForge.SFN_Slider,id:41,x:31446,y:33281,ptovrint:False,ptlb:HighlightRange2,ptin:_HighlightRange2,varname:_HighlightRange2,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0.6,cur:0.6,max:1;n:type:ShaderForge.SFN_Normalize,id:6480,x:31388,y:33362,varname:node_6480,prsc:2|IN-6712-OUT;n:type:ShaderForge.SFN_Max,id:6128,x:32040,y:33216,varname:node_6128,prsc:2|A-4682-OUT,B-8739-OUT;n:type:ShaderForge.SFN_Color,id:4586,x:32136,y:33040,ptovrint:False,ptlb:HighlightColor,ptin:_HighlightColor,varname:node_4586,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Lerp,id:1561,x:32475,y:33004,varname:node_1561,prsc:2|A-4875-RGB,B-4586-RGB,T-6128-OUT;n:type:ShaderForge.SFN_Fresnel,id:7459,x:32026,y:33548,varname:node_7459,prsc:2|EXP-274-OUT;n:type:ShaderForge.SFN_ValueProperty,id:274,x:31807,y:33548,ptovrint:False,ptlb:FresnelExp,ptin:_FresnelExp,varname:node_274,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3;n:type:ShaderForge.SFN_Multiply,id:3935,x:32245,y:33579,varname:node_3935,prsc:2|A-7459-OUT,B-5136-RGB;n:type:ShaderForge.SFN_Color,id:5136,x:32026,y:33718,ptovrint:False,ptlb:FresnelColor,ptin:_FresnelColor,varname:node_5136,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Blend,id:799,x:32715,y:33203,varname:node_799,prsc:2,blmd:6,clmp:True|SRC-1561-OUT,DST-3935-OUT;n:type:ShaderForge.SFN_Slider,id:6456,x:32894,y:33447,ptovrint:False,ptlb:SpecularPower_copy,ptin:_SpecularPower_copy,varname:_SpecularPower_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:1,max:10;n:type:ShaderForge.SFN_Power,id:8483,x:33265,y:33310,varname:node_8483,prsc:2|VAL-7567-OUT,EXP-6456-OUT;n:type:ShaderForge.SFN_Max,id:7567,x:33051,y:33242,varname:node_7567,prsc:2|B-1802-OUT;n:type:ShaderForge.SFN_Vector1,id:1802,x:32837,y:33349,varname:node_1802,prsc:2,v1:0;n:type:ShaderForge.SFN_Dot,id:5916,x:32837,y:33177,varname:node_5916,prsc:2,dt:0;n:type:ShaderForge.SFN_Slider,id:6489,x:32958,y:33511,ptovrint:False,ptlb:SpecularPower_copy_copy,ptin:_SpecularPower_copy_copy,varname:_SpecularPower_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:1,max:10;n:type:ShaderForge.SFN_Power,id:3870,x:33329,y:33374,varname:node_3870,prsc:2|VAL-3797-OUT,EXP-6489-OUT;n:type:ShaderForge.SFN_Max,id:3797,x:33115,y:33306,varname:node_3797,prsc:2|B-2077-OUT;n:type:ShaderForge.SFN_Vector1,id:2077,x:32901,y:33413,varname:node_2077,prsc:2,v1:0;n:type:ShaderForge.SFN_Dot,id:6374,x:32901,y:33241,varname:node_6374,prsc:2,dt:0;proporder:4875-7371-9703-5565-41-4586-274-5136;pass:END;sub:END;*/

Shader "ZhuangDong/L02/Jade" {
    Properties {
        _RampTex ("RampTex", 2D) = "white" {}
        _HighlightOffset1 ("HighlightOffset1", Vector) = (0,0,0,0)
        _HighlightRange1 ("HighlightRange1", Range(0.6, 1)) = 0.6
        _HighlightOffset2 ("HighlightOffset2", Vector) = (0,0,0,0)
        _HighlightRange2 ("HighlightRange2", Range(0.6, 1)) = 0.6
        _HighlightColor ("HighlightColor", Color) = (0.5,0.5,0.5,1)
        _FresnelExp ("FresnelExp", Float ) = 3
        _FresnelColor ("FresnelColor", Color) = (0.5,0.5,0.5,1)
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        LOD 100
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
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform sampler2D _RampTex; uniform float4 _RampTex_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _HighlightOffset1)
                UNITY_DEFINE_INSTANCED_PROP( float, _HighlightRange1)
                UNITY_DEFINE_INSTANCED_PROP( float4, _HighlightOffset2)
                UNITY_DEFINE_INSTANCED_PROP( float, _HighlightRange2)
                UNITY_DEFINE_INSTANCED_PROP( float4, _HighlightColor)
                UNITY_DEFINE_INSTANCED_PROP( float, _FresnelExp)
                UNITY_DEFINE_INSTANCED_PROP( float4, _FresnelColor)
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
                UNITY_FOG_COORDS(4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float node_7522 = 0.5;
                float2 node_3510 = float2(((dot(i.normalDir,lightDirection)*node_7522)+node_7522),node_7522);
                float4 _RampTex_var = tex2D(_RampTex,TRANSFORM_TEX(node_3510, _RampTex));
                float4 _HighlightColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _HighlightColor );
                float _HighlightRange1_var = UNITY_ACCESS_INSTANCED_PROP( Props, _HighlightRange1 );
                float4 _HighlightOffset1_var = UNITY_ACCESS_INSTANCED_PROP( Props, _HighlightOffset1 );
                float _HighlightRange2_var = UNITY_ACCESS_INSTANCED_PROP( Props, _HighlightRange2 );
                float4 _HighlightOffset2_var = UNITY_ACCESS_INSTANCED_PROP( Props, _HighlightOffset2 );
                float _FresnelExp_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FresnelExp );
                float4 _FresnelColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FresnelColor );
                float3 emissive = saturate((1.0-(1.0-lerp(_RampTex_var.rgb,_HighlightColor_var.rgb,max(step(_HighlightRange1_var,dot(normalize((_HighlightOffset1_var.rgb+lightDirection)),i.normalDir)),step(_HighlightRange2_var,dot(normalize((_HighlightOffset2_var.rgb+lightDirection)),i.normalDir)))))*(1.0-(pow(1.0-max(0,dot(normalDirection, viewDirection)),_FresnelExp_var)*_FresnelColor_var.rgb))));
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
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
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform sampler2D _RampTex; uniform float4 _RampTex_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _HighlightOffset1)
                UNITY_DEFINE_INSTANCED_PROP( float, _HighlightRange1)
                UNITY_DEFINE_INSTANCED_PROP( float4, _HighlightOffset2)
                UNITY_DEFINE_INSTANCED_PROP( float, _HighlightRange2)
                UNITY_DEFINE_INSTANCED_PROP( float4, _HighlightColor)
                UNITY_DEFINE_INSTANCED_PROP( float, _FresnelExp)
                UNITY_DEFINE_INSTANCED_PROP( float4, _FresnelColor)
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
                UNITY_FOG_COORDS(4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
////// Lighting:
                float3 finalColor = 0;
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
