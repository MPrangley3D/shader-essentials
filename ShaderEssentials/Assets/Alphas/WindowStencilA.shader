Shader "Custom/WindowStencilA"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)

        // Stencil Code Values
        _SRef("Stencil Ref", Float) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)] _SComp("Stencil Comp", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)] _SOp("Stencil Op", Float) = 2

    }
    SubShader
    {
        Tags { "Queue"="Geometry-1" }

        ZWrite off
        ColorMask 0

        Stencil
        {
            Ref[_SRef]
            Comp[_SComp]
            Pass[_SOp]
        }

        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _Diffuse;

        struct Input
        {
            float2 uv_Diffuse;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D (_Diffuse, IN.uv_Diffuse).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
