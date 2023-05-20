Shader "ZhuangDong/L07/Shadow" {
    Properties {
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
                "LightMode" = "ForwardBase"
            }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            //#pragma target 3.0

            //uniform, attribute, varying

            struct appdata {
                float4 vertex : POSITION;
            };

            struct v2f {
                float4 pos : SV_POSITION;
                LIGHTING_COORDS(0, 1)
            };

            v2f vert (appdata v) {
                v2f o; // = (v2f)0
                o.pos = UnityObjectToClipPos(v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o);
                return o;
            }

            float4 frag (v2f i) : COLOR {
                float shadow = LIGHT_ATTENUATION(i);
                return float4(shadow, shadow, shadow, 1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
