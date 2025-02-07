Shader "CodeGoblin/Cutoff"
{
    Properties
    {
        _diffuse ("Diffuse", 2D) = "white" {}
        _normal ("Normal", 2D) = "bump" {}
        _bumpAmount("Normal Intensity", Range(0,10)) = 1
        _rimColor ("Rim Color", Color) = (0, 0.5, 0.5, 0.0)
        _rimCutoff ("Rim Cutoff", Range(0, 1)) = 0.1
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float3 viewDir;
            float3 worldPos;
            float2 uv_diffuse;
            float2 uv_normal;
        };

        sampler2D _diffuse;
        sampler2D _normal;
        float4 _rimColor;
        float _rimCutoff;
        half _bumpAmount;

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_diffuse, IN.uv_diffuse).rgb;
            o.Normal = UnpackNormal(tex2D(_normal, IN.uv_normal)) * 0.3; 
            o.Normal *= float3(_bumpAmount, _bumpAmount, 1);
            half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
            o.Emission = frac(IN.worldPos.y * 10 * 0.5) > _rimCutoff ?
                            rim * float3(0,1,0) : rim * float3(0,0,1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
