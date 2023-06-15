Shader "ZhuangDong/L18/Sequence"
{
    Properties
    {
        _MainTex    ("Texture   RGB:BaseColor A:AC", 2D)    = "white" {}
        _Opacity    ("Opacity", range(0, 1))                = 0.5
        _Sequence   ("Sequence", 2d)                        = "gray" {}
        _RowCount   ("RowCount", int)                       = 1
        _ColCount   ("ColumnCount", int)                    = 1
        _Speed      ("Speed", range(-10, 10))               = 3
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
            Name "FORWARD_AB"
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
                o.uv0 = v.uv0;
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

        Pass {
            Name "FORWARD_AD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend One One

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            uniform sampler2D _Sequence; uniform float4 _Sequence_ST;
            uniform half _RowCount;
            uniform half _ColCount;
            uniform half _Speed;

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
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
                v.vertex.xyz += v.normal * 0.01;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv0 = TRANSFORM_TEX(v.uv0, _Sequence);
                float id = floor(_Time.z * _Speed);
                float idV = floor(id / _ColCount);
                float idU = id % _ColCount; // fmod
                float stepU = 1.0 / _ColCount;
                float stepV = 1.0 / _RowCount; // float number division cost a lot, avoid these
                                               // TODO pre-calculate and pass as properties
                                               // VFX shader performance is important because of overdraw
                float2 initUV = o.uv0 * float2(stepU, stepV) + float2(0.0, stepV * (_RowCount - 1));
                o.uv0 = initUV + float2(idU * stepU, idV * -stepV);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 var_Sequence = tex2D(_Sequence, i.uv0);
                fixed3 finalRGB = var_Sequence.rgb;
                fixed opacity = var_Sequence.a;
                return fixed4(finalRGB * opacity, opacity);
            }
            ENDCG
        }
    }
}
