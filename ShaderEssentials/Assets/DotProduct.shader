Shader "CodeGoblin/DotProduct"
{
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float3 viewDir;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Calculate dot product of view direction & surface normal
            half dotp = dot(IN.viewDir, o.Normal);
            // Color R channel based on Dot product
            // EG when Dot PRoduct is facing user (closer to 1) Albedo is white (1,1,1)
            // When Dot product is more perpendicular, Albedo is (0,1,1) EG Teal
            o.Albedo = float3(dotp,1,1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
