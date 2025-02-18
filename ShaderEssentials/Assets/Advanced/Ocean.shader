Shader "CodeGoblin/_Advanced/Ocean"
{
    Properties 
    {
    // Panning textures
    _MainTex("Diffuse", 2D) = "white" {}
    _FoamTex("Foam", 2D) = "white" {}
    _ScrollX("Speed",Range(-5,5)) = 0
    _ScrollY("Speed",Range(-5,5)) = 0

    // Waves
    _Tint("Colour Tint", Color) = (1,1,1,1)
    _Freq("Frequency", Range(0,5)) = 3
    _Speed("Speed",Range(0,100)) = 10
    _Amp("Amplitude",Range(0,1)) = 0.5
    }

    SubShader 
    {
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert 
      
        // Panning textures
        sampler2D _MainTex;
        sampler2D _FoamTex;
        float _ScrollX;
        float _ScrollY;

        // Waves
        float4 _Tint;
        float _Freq;
        float _Amp;
        float _Speed;

        struct Input 
        {
            float2 uv_MainTex;
            float3 vertColor;
        };

        struct appdata 
        {
            float4 vertex: POSITION;
            float3 normal: NORMAL;
            float4 texcoord: TEXCOORD0;
            float4 texcoord1: TEXCOORD1;
            float4 texcoord2: TEXCOORD2;
        };

        void vert (inout appdata v, out Input o) 
        {
            UNITY_INITIALIZE_OUTPUT(Input,o);
            float t = _Time * _Speed;
            float waveHeight = sin(t + v.vertex.x * _Freq) * _Amp + sin(t*2 + v.vertex.x * _Freq*2) * _Amp;
            v.vertex.y = v.vertex.y + waveHeight;
            v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z));
            o.vertColor = waveHeight + 2;
        }

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