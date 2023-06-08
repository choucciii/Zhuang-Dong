Shader "ZhuangDong/L15/GhostFlow"
{
    Properties
    {
        _MainTex    ("Texture   RGB: BaseColor A: AC", 2d)    = "white" {}
        _Opacity    ("Opacity", range(0, 1))                = 0.5
        _NoiseTex   ("Noise Texture", 2d)                    = "gray" {}
        _NoiseInt   ("Noise Intensity", range(0, 5))         = 1.0
        _FlowSpeed  ("Flow Speed", range(-10, 10))           = 5.0
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
            uniform sampler2D _NoiseTex; uniform half4 _NoiseTex_ST;
            uniform half _NoiseInt;
            uniform half _FlowSpeed;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv0 : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
            };

            v2f vert (appdata v)
            {
                v2f o = (v2f)0;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv0 = v.uv0;
                o.uv1 = TRANSFORM_TEX(v.uv0, _NoiseTex);
                o.uv1.y += frac(-_Time.x) * _FlowSpeed;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 var_MainTex = tex2D(_MainTex, i.uv0);
                fixed var_NoiseTex = tex2D(_NoiseTex, i.uv1);

                fixed3 finalRGB = var_MainTex.rgb;
                half noise = max(0.0, lerp(1.0, var_NoiseTex * 2, _NoiseInt));
                fixed opacity = var_MainTex.a * _Opacity * noise;

                return fixed4(finalRGB * opacity, opacity);
            }
            ENDCG
        }
    }
}
