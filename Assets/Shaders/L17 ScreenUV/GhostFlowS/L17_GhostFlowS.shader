Shader "ZhuangDong/L17/GhostFlowS"
{
    Properties
    {
        _MainTex    ("Texture   RGB:BaseColor A:AC", 2d)    = "white" {}
        _Opacity    ("Opacity", range(0, 1))                = 0.5
        _ScreenTex  ("Screen Texture", 2d)                  = "white" {}
    }
    SubShader
    {
        Tags {
            "Queue"="Transparent"
            "RenderType"="TransparentCutout"
            "ForceNoShadowCasting"="True"
            "IgnoreProjector"="True"
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
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            uniform sampler2D _MainTex;
            uniform half _Opacity;
            uniform sampler2D _ScreenTex; uniform half4 _ScreenTex_ST;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                float2 screenUV : TEXCOORD1;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;

                float3 posVS = UnityObjectToViewPos(v.vertex).xyz;
                float oriDist = UnityObjectToViewPos(float3(0.0, 0.0, 0.0)).z;
                o.screenUV = posVS.xy / posVS.z * oriDist;
                o.screenUV = o.screenUV * _ScreenTex_ST.xy - frac(_Time.x * _ScreenTex_ST.zw);

                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half4 var_MainTex = tex2D(_MainTex, i.uv);
                half var_ScreenTex = tex2D(_ScreenTex, i.screenUV).r;

                half3 finalRGB = var_MainTex.rgb;
                half opacity = var_MainTex.a * _Opacity * var_ScreenTex;

                return half4(finalRGB * opacity, opacity);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
