Shader "CodeGoblin/Custom"
{
    Properties
    {
        _color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf MattLambert

        half4 LightingMattLambert (SurfaceOutput s, half3 lightDir, half atten)
        {
            half NdotL = dot (s.Normal, lightDir);
            half4 color;
            color.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
            color.a = s.Alpha;
            return color;
        }

        struct Input
        {
            float2 uv_MainTex;
        };

        float4 _color;

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _color.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}