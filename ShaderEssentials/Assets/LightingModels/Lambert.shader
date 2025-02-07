Shader "CodeGoblin/Lambert"
{
    Properties
    {
        _color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

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