Shader "CodeGoblin/PanelMix"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "black" {}
    }

    SubShader
    {
        Tags {"Queue" = "Transparent"}
        Blend OneMinusDstColor OneMinusSrcColor
        Pass {SetTexture [_MainTex] {combine texture}}
    }
    FallBack "Diffuse"
}
