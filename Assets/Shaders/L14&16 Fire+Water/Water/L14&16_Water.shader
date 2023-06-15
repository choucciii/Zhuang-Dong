Shader "ZhuangDong/L14&16/Water"
{
    Properties
    {
        _MainTex        ("Main Texture", 2d)                                                = "white" {}
        _FlowSpeed      ("MainTex FlowSpeed X: SpeedX Y: SpeedY", vector)                   = (1.0, 1.0, 0.5, 1.0)
        _WarpTex        ("Warp Texture", 2d)                                                = "gray" {}
        _Warp1Params    ("Warp1Params X: Scale Y: SpeedX Z: SpeedY W: Intensity", vector)   = (1.0, 1.0, 0.5, 1.0)
        _Warp2Params    ("Warp2Params X: Scale Y: SpeedX Z: SpeedY W: Intensity", vector)   = (2.0, 0.5, 0.5, 1.0)
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
            uniform half2 _FlowSpeed;
            uniform sampler2D _WarpTex;
            uniform half4 _Warp1Params;
            uniform half4 _Warp2Params;

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
                float2 uv2 : TEXCOORD2;
            };

            v2f vert (appdata v)
            {
                v2f o = (v2f)0;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv0 = TRANSFORM_TEX(v.uv0, _MainTex) - frac(_Time.x * _FlowSpeed);
                o.uv1 = v.uv0 * _Warp1Params.x - frac(_Time.x * _Warp1Params.yz);
                o.uv2 = v.uv0 * _Warp2Params.x - frac(_Time.x * _Warp2Params.yz);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                half3 var_Warp1 = tex2D(_WarpTex, i.uv1).rgb;
                half3 var_Warp2 = tex2D(_WarpTex, i.uv2).rgb;

                half2 warp = (var_Warp1.xy - 0.5) * _Warp1Params.w +
                             (var_Warp2.xy - 0.5) * _Warp2Params.w;

                float2 warpUV = i.uv0 + warp;
                half4 var_MainTex = tex2D(_MainTex, warpUV);

                return fixed4(var_MainTex.xyz, 1.0);
            }
            ENDCG
        }
    }
}
