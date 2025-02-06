Shader "CodeGoblin/Roughness Test"

{
    Properties
    {
        _diffuse ("Diffuse", 2D) = "white" {}
        _normal ("Normal", 2D) = "bump" {}
        _bumpAmount("Normal Intensity", Range(0,10)) = 1
        _brightness("Brightness", Range(0,10)) = 1
        _myCube ("Cube Map", CUBE) = "white" {}
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float2 uv_diffuse;
            float2 uv_normal;
            float3 worldRefl; INTERNAL_DATA
        };

        sampler2D _diffuse;
        sampler2D _normal;
        samplerCUBE _myCube;
        half _bumpAmount;
        half _emissiveAmount;

        void surf (Input IN, inout SurfaceOutput o)
        {
            //o.Albedo = tex2D(_diffuse, IN.uv_diffuse).rgb;
            o.Normal = UnpackNormal(tex2D(_normal, IN.uv_normal)) * 0.3; 
            o.Albedo = texCUBE (_myCube, WorldReflectionVector (IN, o.Normal)).rgb;

            //o.Normal *= float3(_bumpAmount, _bumpAmount, 1);

            //o.Emission = texCUBE(_myCube, WorldReflectionVector(IN, o.Normal)).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
