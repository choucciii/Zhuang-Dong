// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33269,y:32470,varname:node_3138,prsc:2|emission-8503-OUT,olwid-7544-OUT,olcol-6555-RGB;n:type:ShaderForge.SFN_NormalVector,id:6354,x:32101,y:32644,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:8343,x:32101,y:32807,varname:node_8343,prsc:2;n:type:ShaderForge.SFN_Dot,id:2075,x:32346,y:32672,varname:node_2075,prsc:2,dt:0|A-6354-OUT,B-8343-OUT;n:type:ShaderForge.SFN_ScreenPos,id:7335,x:31906,y:32379,varname:node_7335,prsc:2,sctp:1;n:type:ShaderForge.SFN_Depth,id:1451,x:31906,y:32561,varname:node_1451,prsc:2;n:type:ShaderForge.SFN_Multiply,id:1616,x:32156,y:32456,varname:node_1616,prsc:2|A-7335-UVOUT,B-1451-OUT;n:type:ShaderForge.SFN_Tex2d,id:272,x:32330,y:32456,ptovrint:False,ptlb:Pattern,ptin:_Pattern,varname:node_272,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:c34c5fbd9dfbc30448090c06b069b0a0,ntxv:0,isnm:False|UVIN-1616-OUT;n:type:ShaderForge.SFN_Step,id:7039,x:32578,y:32553,varname:node_7039,prsc:2|A-272-R,B-2075-OUT;n:type:ShaderForge.SFN_Color,id:6230,x:32525,y:32154,ptovrint:False,ptlb:ShadowColor,ptin:_ShadowColor,varname:node_6230,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Color,id:5097,x:32525,y:32337,ptovrint:False,ptlb:HighlightColor,ptin:_HighlightColor,varname:node_5097,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Lerp,id:9702,x:32836,y:32439,varname:node_9702,prsc:2|A-6230-RGB,B-5097-RGB,T-7039-OUT;n:type:ShaderForge.SFN_Color,id:8744,x:32346,y:32860,ptovrint:False,ptlb:DiffuseColor,ptin:_DiffuseColor,varname:node_8744,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:6785,x:32631,y:32723,varname:node_6785,prsc:2|A-2075-OUT,B-8744-RGB;n:type:ShaderForge.SFN_Add,id:8503,x:33053,y:32517,varname:node_8503,prsc:2|A-9702-OUT,B-6785-OUT;n:type:ShaderForge.SFN_Slider,id:7544,x:32915,y:32731,ptovrint:False,ptlb:OutlineWidth,ptin:_OutlineWidth,varname:node_7544,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:0.05;n:type:ShaderForge.SFN_Color,id:6555,x:32915,y:32838,ptovrint:False,ptlb:OutlineColor,ptin:_OutlineColor,varname:node_6555,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Slider,id:4179,x:33022,y:33575,ptovrint:False,ptlb:SpecularPower_copy,ptin:_SpecularPower_copy,varname:_SpecularPower_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:1,max:10;n:type:ShaderForge.SFN_Power,id:6095,x:33393,y:33438,varname:node_6095,prsc:2|VAL-3466-OUT,EXP-4179-OUT;n:type:ShaderForge.SFN_Max,id:3466,x:33179,y:33370,varname:node_3466,prsc:2|B-539-OUT;n:type:ShaderForge.SFN_Vector1,id:539,x:32965,y:33477,varname:node_539,prsc:2,v1:0;n:type:ShaderForge.SFN_Dot,id:8289,x:32965,y:33305,varname:node_8289,prsc:2,dt:0;n:type:ShaderForge.SFN_Slider,id:3512,x:33086,y:33639,ptovrint:False,ptlb:SpecularPower_copy_copy,ptin:_SpecularPower_copy_copy,varname:_SpecularPower_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:1,max:10;n:type:ShaderForge.SFN_Power,id:1352,x:33457,y:33502,varname:node_1352,prsc:2|VAL-6489-OUT,EXP-3512-OUT;n:type:ShaderForge.SFN_Max,id:6489,x:33243,y:33434,varname:node_6489,prsc:2|B-6229-OUT;n:type:ShaderForge.SFN_Vector1,id:6229,x:33029,y:33541,varname:node_6229,prsc:2,v1:0;n:type:ShaderForge.SFN_Dot,id:9991,x:33029,y:33369,varname:node_9991,prsc:2,dt:0;proporder:272-8744-5097-6230-7544-6555;pass:END;sub:END;*/

Shader "ZhuangDong/L02/ShadowLines" {
    Properties {
        _Pattern ("Pattern", 2D) = "white" {}
        _DiffuseColor ("DiffuseColor", Color) = (0.5,0.5,0.5,1)
        _HighlightColor ("HighlightColor", Color) = (0.5,0.5,0.5,1)
        _ShadowColor ("ShadowColor", Color) = (0.5,0.5,0.5,1)
        _OutlineWidth ("OutlineWidth", Range(0, 0.05)) = 0
        _OutlineColor ("OutlineColor", Color) = (0.5,0.5,0.5,1)
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma target 3.0
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _OutlineWidth)
                UNITY_DEFINE_INSTANCED_PROP( float4, _OutlineColor)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                float _OutlineWidth_var = UNITY_ACCESS_INSTANCED_PROP( Props, _OutlineWidth );
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*_OutlineWidth_var,1) );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float4 _OutlineColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _OutlineColor );
                return fixed4(_OutlineColor_var.rgb,0);
            }
            ENDCG
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
            uniform sampler2D _Pattern; uniform float4 _Pattern_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _ShadowColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _HighlightColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _DiffuseColor)
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
                float4 projPos : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float4 _ShadowColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _ShadowColor );
                float4 _HighlightColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _HighlightColor );
                float2 node_1616 = (float2((sceneUVs.x * 2 - 1)*(_ScreenParams.r/_ScreenParams.g), sceneUVs.y * 2 - 1).rg*partZ);
                float4 _Pattern_var = tex2D(_Pattern,TRANSFORM_TEX(node_1616, _Pattern));
                float node_2075 = dot(i.normalDir,lightDirection);
                float4 _DiffuseColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _DiffuseColor );
                float3 emissive = (lerp(_ShadowColor_var.rgb,_HighlightColor_var.rgb,step(_Pattern_var.r,node_2075))+(node_2075*_DiffuseColor_var.rgb));
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
            uniform sampler2D _Pattern; uniform float4 _Pattern_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _ShadowColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _HighlightColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _DiffuseColor)
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
                float4 projPos : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
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
