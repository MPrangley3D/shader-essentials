Shader "CodeGoblin/NormalsSample
"
{
    Properties
    {
        _diffuse ("Diffuse", 2D) = "white" {}
        _emissive ("Emissive", 2D) = "white" {}
        _normal ("Normal", 2D) = "bump" {}
        _bumpAmount("Normal Intensity", Range(0,10)) = 1
        _emissiveAmount("Emissive Intensity", Range(0,10)) = 1
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float2 uv_diffuse;
            float2 uv_emissive;
            float2 uv_normal;
        };

        sampler2D _diffuse;
        sampler2D _emissive;
        sampler2D _normal;
        half _bumpAmount;
        half _emissiveAmount;

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_diffuse, IN.uv_diffuse).rgb;
            o.Emission = tex2D(_emissive, IN.uv_emissive).rgb;
            o.Emission *= _emissiveAmount;
            o.Normal = UnpackNormal(tex2D(_normal, IN.uv_normal));
            o.Normal *= float3(_bumpAmount, _bumpAmount, 1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
