Shader "CodeGoblin/_Advanced/Ocean"
{
    Properties 
    {
      _MainTex("Diffuse", 2D) = "white" {}
      _FoamTex("Foam", 2D) = "white" {}
      _ScrollX("Speed",Range(-5,5)) = 0
      _ScrollY("Speed",Range(-5,5)) = 0
    }
    SubShader 
    {
      CGPROGRAM
      #pragma surface surf Lambert
      
      sampler2D _MainTex;
      sampler2D _FoamTex;
      float _ScrollX;
      float _ScrollY;

      struct Input 
      {
          float2 uv_MainTex;
      };

      void surf (Input IN, inout SurfaceOutput o) 
      {
			_ScrollX *= _Time;
			_ScrollY *= _Time;
			float3 water = (tex2D (_MainTex, IN.uv_MainTex + float2(_ScrollX, _ScrollY))).rgb;
			float3 foam = (tex2D (_FoamTex, IN.uv_MainTex + float2(_ScrollX/2.0, _ScrollY/2.0))).rgb;
			o.Albedo = (water + foam)/2.0;
      }
      ENDCG
    } 
    Fallback "Diffuse"
}