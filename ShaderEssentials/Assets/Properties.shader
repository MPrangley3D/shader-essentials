Shader "CodeGoblin/PropertiesSample"
{
    Properties
    {
        _myColor ("Example Color", Color) = (1,1,1,1)
        _myRange ("Example Range", Range(0,5)) = 0
        _myTex ("Example Texture", 2D) = "white" {}
        _myEmis ("Example Emissive", 2D) = "black" {}
        _myCube ("Example Cubemap", CUBE) = "" {}
        _myFloat ("Example Float", Float) = 0.5
        _myVector ("Example Vector", Vector) = (0.5, 1, 1, 1)
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float2 uv_myTex;
            float2 uv_myEmis;
            float3 worldRefl;
        };

        fixed4 _myColor;
        half _myRange;
        sampler2D _myTex;
        sampler2D _myEmis;
        samplerCUBE _myCube;
        float _myFloat;
        float4 _myVector;

        void surf (Input IN, inout SurfaceOutput o)
        {
            //note below how to create a colour on the fly with code
            //float4 green = float4(0,1,0,1);
            //o.Albedo = (tex2D(_myTex, IN.uv_myTex) * green).rgb;
            o.Albedo = (tex2D(_myTex, IN.uv_myTex) * _myRange).rgb * _myColor;
            o.Albedo.g = .1;
            o.Emission = texCUBE (_myCube, IN.worldRefl).rgb * (tex2D(_myEmis, IN.uv_myEmis)).rgb;
            //o.Emission = (tex2D(_myEmis, IN.uv_myEmis)).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
