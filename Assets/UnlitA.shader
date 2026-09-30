Shader "Unlit/UnlitA"
{
    Properties
    {
        _Curve ("Curve", Range(0.05, 3)) = 1.0

        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        CGPROGRAM
        #pragma surface surf Unlit noforwardadd

        sampler2D _MainTex;
        float _Curve;

        struct Input
        {
            float2 uv_MainTex;
        };

        // Ignora luz — comportamento tipo Unlit
        inline fixed4 LightingUnlit(SurfaceOutput s, fixed3 lightDir, fixed atten)
        {
            return fixed4(s.Albedo, 1);
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            float xIndex = 1.0 - IN.uv_MainTex.x;
            // usando potência, da pra controlar o branco pra ele ficar mais acizentado x=0.56 e antes era 0.75, portanto fica mais escuro
            // coloquei o Curve em 2.55
            xIndex = pow(xIndex, _Curve);
            o.Albedo = float3(xIndex, xIndex, xIndex);
        }
        ENDCG
    }
    FallBack "Diffuse"
}