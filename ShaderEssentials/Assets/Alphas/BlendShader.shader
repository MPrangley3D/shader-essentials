Shader "CodeGoblin/BlendShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _DecalTex ("Decal", 2D) = "white" {}
        [Toggle] _ShowDecal("Show Decal", Float) = 0
        _DecalColor ("Decal Color", Color) = (0, 0.0, 0.0, 0.0)
    }

    SubShader
    {
        Tags { "Queue"="Geometry" }

        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        sampler2D _DecalTex;
        float _ShowDecal;
        float4 _DecalColor;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 a = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 b = tex2D (_DecalTex, IN.uv_MainTex) * _ShowDecal;
            o.Albedo = b.r > 0.2 ? b.rgb * _DecalColor : a.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
