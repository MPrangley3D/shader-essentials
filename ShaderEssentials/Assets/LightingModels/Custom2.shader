Shader "CodeGoblin/CustomBlinn"
{
    Properties
    {
        _color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf MattBlinn

        half4 LightingMattBlinn (SurfaceOutput s, half3 lightDir, half viewDir, half atten)
        {
            half3 h = normalize (lightDir + viewDir);
            half diff = max (0,dot (s.Normal, lightDir));

            float nh = max (0, dot (s.Normal, h));
            float spec = pow (nh, 48.0);

            half4 color;
            color.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten;
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