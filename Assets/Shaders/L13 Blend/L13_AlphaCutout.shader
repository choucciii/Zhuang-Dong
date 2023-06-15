Shader "ZhuangDong/L13/AlphaCutout"
{
    Properties
    {
        _MainTex ("Texture   RGB:BaseColor A:AC", 2D)   = "white" {}
        _Cutoff  ("CutoutThreshold", range(0, 1))       = 0.5
    }
    SubShader
    {
        Tags {
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

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            uniform sampler2D _MainTex; uniform half4 _MainTex_ST;
            uniform fixed _Cutoff;

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

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv0 = TRANSFORM_TEX(v.uv0, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 var_MainTex = tex2D(_MainTex, i.uv0);
                clip(var_MainTex.a - _Cutoff);
                return fixed4(var_MainTex.rgb, 1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
