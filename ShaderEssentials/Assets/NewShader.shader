Shader "CodeGoblin/HelloShader"
{
    Properties
    {
        _myColor ("Example Color", Color) = (1,1,1,1)
        _myEmission ("Example Emission", Color) = (1,1,1,1)
        _myNormal ("Example Normal", Color) = (1,1,1,1)
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert fullforwardshadows
        #pragma target 3.0

        struct Input
        {
            float2 uvMainTex;
        };

        sampler2D _MainTex;
        fixed4 _myColor;
        fixed4 _myEmission;
        fixed4 _myNormal;

        void surf (Input IN, inout SurfaceOutput o)
        {
           //fixed4 c = tex2D (_MainTex, IN.uvMainTex) * _myColor;
           //o.Albedo = c.rgb;
           o.Albedo = _myColor.rgb;
           o.Emission = _myEmission.rgb;
           o.Normal = _myNormal.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
