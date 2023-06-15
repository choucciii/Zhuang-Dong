Shader "ZhuangDong/L18/PolarCoord"
{
    Properties
    {
        _MainTex        ("Texture   RGB:BaseColor A:AC", 2D)    = "white" {}
        _Opacity        ("Opacity", range(0, 1))                = 0.5
        [HDR] _Color    ("Color", color)                        = (1.0, 1.0, 1.0, 1.0)
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
            uniform fixed _Opacity;
            uniform half3 _Color;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv0 : TEXCOORD0;
                float4 color : COLOR;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 color : COLOR;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv0 = v.uv0;
                o.color = v.color;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                i.uv0 = i.uv0 - 0.5;
                float theta = atan2(i.uv0.y, i.uv0.x); 
                theta = theta / 3.1415926 * 0.5 + 0.5;
                float r = length(i.uv0) + frac(_Time.x * 3.0);
                i.uv0 = float2(theta, r);

                fixed4 var_MainTex = tex2D(_MainTex, i.uv0);
                fixed3 finalRGB = var_MainTex.rgb * _Color;
                fixed opacity = var_MainTex.a * _Opacity * i.color.r;
                return fixed4(finalRGB * opacity, opacity);
            }
            ENDCG
        }
    }
}
