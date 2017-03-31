Shader "Chapter1/StandardDiffuse2" {
	// We define Properties in the properties block
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_AmbientColor ("Ambient Color", Color) = (1,1,1,1)
		_MySliderValue ("This is a Slider", Range(0,10)) = 2.5
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		// We need to declare the properties variable type inside of the
   		// CGPROGRAM so we can access its value from the properties block.
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		struct Input {
			float2 uv_MainTex;
		};

		float4 _AmbientColor;
		float _MySliderValue;
		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// We can then use the properties values in our shader
			fixed4 c = pow((_Color + _AmbientColor), _MySliderValue);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
