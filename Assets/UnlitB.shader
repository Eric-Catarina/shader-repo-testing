Shader "Unlit/UnlitB"
{
    Properties
    {
        _Color1 ("Background Color", Color) = (0, 0, 0.6, 1)
        _Color2 ("Stripe Color", Color) = (1, 0, 0, 1)
        _StripeWidth ("Stripe Width", Range(0.01, 1.0)) = 0.2
        _Curve ("Stripe Falloff", Range(0.05, 3)) = 1.0
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        CGPROGRAM
        #pragma surface surf Unlit noforwardadd

        sampler2D _MainTex;
        float _StripeWidth;
        float _Curve;
        fixed4 _Color1;
        fixed4 _Color2;

        struct Input
        {
            float2 uv_MainTex;
        };

        inline fixed4 LightingUnlit(SurfaceOutput s, fixed3 lightDir, fixed atten)
        {
            return fixed4(s.Albedo, 1);
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            float2 uv = IN.uv_MainTex;
            float dist = abs(uv.x - uv.y);
            float stripe = 1.0 - smoothstep(0.0, _StripeWidth, dist);
            stripe = pow(stripe, _Curve);

            o.Albedo = lerp(_Color1.rgb, _Color2.rgb, stripe);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
