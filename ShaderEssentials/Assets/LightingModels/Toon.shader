Shader "CodeGoblin/Toon"
{
    Properties
    {
        _color ("Color", Color) = (1,1,1,1)
        _rampTexture ("Ramp Texture", 2D) = "white" {}
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf MattToon

        float4 _color;
        sampler2D _rampTexture;


        float4 LightingMattToon (SurfaceOutput s, half3 lightDir, half atten)
        {
            float diff = dot(s.Normal, lightDir);
            float h = diff * 0.5 + 0.5;
            float2 rh = h;
            float3 ramp = tex2D(_rampTexture, rh).rgb;

            float4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (ramp);
            c.a = s.Alpha;

            return c;
        }

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _color.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}