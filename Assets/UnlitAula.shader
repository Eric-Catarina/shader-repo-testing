Shader "Unlit/UnlitB"
{
    Properties
    {
        _Color1 ("Color", Color) = (1, 1, 1, 1)
        _Color2 ("Background Color", Color) = (0, 0, 0.6, 1)
        _Color3 ("Stripe Color", Color) = (1, 0, 0, 1)
        _StripeWidth ("Stripe Width", Range(0.01, 1.0)) = 0.2
        _Curve ("Stripe Falloff", Range(0.05, 3)) = 1.0
        _MainTex ("Texture", 2D) = "white" {}
        _Alpha ("Opacity", Range(0, 1)) = 1
        _Slider ("Slider", Range(0, 1)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 100

        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha

        CGPROGRAM
        #pragma surface surf Unlit alpha:fade noforwardadd

        sampler2D _MainTex;
        float _StripeWidth;
        float _Curve;
        fixed4 _Color1;
        fixed4 _Color2;
        fixed4 _Color3;
        fixed _Alpha;
        float _Slider;

        struct Input
        {
            float2 uv_MainTex;
        };

        inline fixed4 LightingUnlit(SurfaceOutput s, fixed3 lightDir, fixed atten)
        {
            return fixed4(s.Albedo, s.Alpha);
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            if (IN.uv_MainTex.x < 0.3) {
                o.Albedo = _Color1.rgb;
            }
            if (IN.uv_MainTex.x > 0.3 && IN.uv_MainTex.x < 0.7) {
                float2 texUV = IN.uv_MainTex;
                texUV.x = (IN.uv_MainTex.x - 0.3) / (0.7 - 0.3); // 0..1 na faixa
                fixed4 tex = tex2D(_MainTex, texUV);
                o.Albedo = lerp(fixed3(1, 1, 1), tex.rgb, tex.a);            
            }
            if (IN.uv_MainTex.x > 0.7 ) {
                o.Albedo = _Color3.rgb;
            }


    o.Alpha = _Alpha; // ou 1 se quiser sempre opaco


        }
        ENDCG
    }
    FallBack "Transparent/Diffuse"
}
