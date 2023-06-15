Shader "ZhuangDong/L17/GhostWarpS"
{
    Properties
    {
        _MainTex        ("Main Texture", 2d)                = "gray" {}
        _Opacity        ("Opacity", range(0, 1))            = 0.5
        _WarpMidVal     ("Warp Mid Value", range(0, 1))     = 0.5
        _WarpInt        ("Warp Intensity", range(0, 3))     = 0.2
    }
    SubShader
    {
        Tags {
            "Queue"="Transparent"
            "RenderType"="TransparentCutout"
            "ForceNoShadowCasting"="True"
            "IgnoreProjector"="True"
        }

        GrabPass {
            "_BGTex"
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
            uniform half _WarpMidVal;
            uniform half _WarpInt;
            uniform sampler2D _BGTex;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                float4 grabPos : TEXCOORD1;
            };

            v2f vert (appdata v)
            {
                v2f o = (v2f)0;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.grabPos = ComputeGrabScreenPos(o.pos);
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half4 var_MainTex = tex2D(_MainTex, i.uv);
                i.grabPos.xy += (var_MainTex.b - _WarpMidVal) * _WarpInt * _Opacity;

                half3 var_BGTex = tex2Dproj(_BGTex, i.grabPos);

                half3 finalRGB = var_MainTex.rgb * var_BGTex;
                half opacity = var_MainTex.a * _Opacity;

                return fixed4(finalRGB * opacity, opacity);
            }
            ENDCG
        }
    }
}
