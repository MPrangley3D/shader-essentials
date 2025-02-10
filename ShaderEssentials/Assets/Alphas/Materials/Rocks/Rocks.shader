Shader "CodeGoblin/Rocks"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Normal ("Normal", 2D) = "bump" {}
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        sampler2D _Normal;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_Normal;
        };

        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Normal = UnpackNormal(tex2D(_Normal, IN.uv_Normal));
        }
        ENDCG
    }
    FallBack "Diffuse"
}
