Shader "ZhuangDong/L19/Translation"
{
    Properties
    {
        _MainTex    ("Texture   RGB:BaseColor A:AC", 2D)    = "white" {}
        _Opacity    ("Opacity", range(0, 1))                = 0.5
        _MoveRange  ("MoveRange", range(0.0, 3.0))          = 1.0
        _MoveSpeed  ("MoveSpeed", range(0.0, 3.0))          = 1.0
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

            uniform sampler2D _MainTex; uniform half4 _MainTex_ST;
            uniform fixed _Opacity;
            uniform half _MoveRange;
            uniform half _MoveSpeed;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv0 : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };

            #define TWO_PI 6.283185

            void Translation(inout float3 vertex) {
                vertex.y += _MoveRange * sin(frac(_Time.y * _MoveSpeed) * TWO_PI);
            }

            v2f vert (appdata v)
            {
                v2f o;
                Translation(v.vertex.xyz);
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv0 = TRANSFORM_TEX(v.uv0, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 var_MainTex = tex2D(_MainTex, i.uv0);
                fixed3 finalRGB = var_MainTex.rgb;
                fixed opacity = var_MainTex.a * _Opacity;
                return fixed4(finalRGB * opacity, opacity);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
