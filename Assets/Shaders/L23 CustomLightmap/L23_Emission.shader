Shader "ZhuangDong/L23/Emission" {
    Properties {
        _MainTex    ("MainTex", 2D)             = "white" {}
        [HDR]
        _EmiCol    ("EmissiveColor", Color)     = (1.0, 1.0, 1.0, 1.0)
    }
    SubShader {
        Tags {
            "Queue"="Transparent"
            "RenderType"="Transparent"
            "ForceNoShadowCasting"="True"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend One OneMinusSrcAlpha

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            uniform sampler2D _MainTex;
            uniform float3 _EmiCol;
            
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            v2f vert (appdata v)
            {
                v2f o = (v2f)0;
                    o.pos = UnityObjectToClipPos(v.vertex);
                    o.uv = v.uv;
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                float4 var_MainTex = tex2D(_MainTex, i.uv).r;
                float3 finalRGB = var_MainTex.rgb * _EmiCol;
                float opacity = var_MainTex.a;
                return half4(finalRGB * opacity, opacity);
            }
            ENDCG
        }
    }
}
