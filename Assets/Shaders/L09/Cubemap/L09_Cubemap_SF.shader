// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32828,y:32876,varname:node_3138,prsc:2|emission-6956-OUT;n:type:ShaderForge.SFN_ViewVector,id:6005,x:31378,y:32742,varname:node_6005,prsc:2;n:type:ShaderForge.SFN_OneMinus,id:8433,x:31566,y:32742,varname:node_8433,prsc:2|IN-6005-OUT;n:type:ShaderForge.SFN_Tex2d,id:8258,x:31378,y:32908,ptovrint:False,ptlb:NormalMap,ptin:_NormalMap,varname:node_8258,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:6761b335a4355d74aaea7ba88ea83813,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Transform,id:904,x:31566,y:32908,varname:node_904,prsc:2,tffrom:2,tfto:0|IN-8258-RGB;n:type:ShaderForge.SFN_Reflect,id:6713,x:31787,y:32806,varname:node_6713,prsc:2|A-8433-OUT,B-904-XYZ;n:type:ShaderForge.SFN_Cubemap,id:3456,x:32126,y:32865,ptovrint:False,ptlb:Cubemap,ptin:_Cubemap,varname:node_3456,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,cube:48d5c0a19c7865b48a79a732173223c0,pvfc:0|DIR-6713-OUT,MIP-8807-OUT;n:type:ShaderForge.SFN_Slider,id:8807,x:31787,y:32967,ptovrint:False,ptlb:CubemapMip,ptin:_CubemapMip,varname:node_8807,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:7;n:type:ShaderForge.SFN_Slider,id:6661,x:31787,y:33147,ptovrint:False,ptlb:FresnelPower,ptin:_FresnelPower,varname:node_6661,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:2.576244,max:5;n:type:ShaderForge.SFN_Fresnel,id:6914,x:32126,y:33081,varname:node_6914,prsc:2|NRM-904-XYZ,EXP-6661-OUT;n:type:ShaderForge.SFN_Multiply,id:7270,x:32377,y:32971,varname:node_7270,prsc:2|A-3456-RGB,B-6914-OUT;n:type:ShaderForge.SFN_Slider,id:2570,x:32245,y:33198,ptovrint:False,ptlb:EnvSpecInt,ptin:_EnvSpecInt,varname:node_2570,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:5;n:type:ShaderForge.SFN_Multiply,id:6956,x:32607,y:33053,varname:node_6956,prsc:2|A-7270-OUT,B-2570-OUT;proporder:8258-3456-8807-6661-2570;pass:END;sub:END;*/

Shader "ZhuangDong/L09/Cubemap_SF" {
    Properties {
        _NormalMap ("NormalMap", 2D) = "bump" {}
        _Cubemap ("Cubemap", Cube) = "_Skybox" {}
        _CubemapMip ("CubemapMip", Range(0, 7)) = 0
        _FresnelPower ("FresnelPower", Range(0, 5)) = 2.576244
        _EnvSpecInt ("EnvSpecInt", Range(0, 5)) = 0
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
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform samplerCUBE _Cubemap;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _CubemapMip)
                UNITY_DEFINE_INSTANCED_PROP( float, _FresnelPower)
                UNITY_DEFINE_INSTANCED_PROP( float, _EnvSpecInt)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float3 _NormalMap_var = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(i.uv0, _NormalMap)));
                float3 node_904 = mul( _NormalMap_var.rgb, tangentTransform ).xyz;
                float _CubemapMip_var = UNITY_ACCESS_INSTANCED_PROP( Props, _CubemapMip );
                float _FresnelPower_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FresnelPower );
                float _EnvSpecInt_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvSpecInt );
                float3 emissive = ((texCUBElod(_Cubemap,float4(reflect((1.0 - viewDirection),node_904.rgb),_CubemapMip_var)).rgb*pow(1.0-max(0,dot(node_904.rgb, viewDirection)),_FresnelPower_var))*_EnvSpecInt_var);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
