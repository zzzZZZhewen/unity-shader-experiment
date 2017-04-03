Shader "Chapter2/Slihouette" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_DotProduct("Rim effect", Range(-1,1)) = 0.25
	}
	SubShader {
		Tags { 
			"Queue" = "Transparent" 
			"IgnoreProjector" = "True" 
			"RenderType" = "Transparent"
 		}
		// LOD 200
		//Cull Off
		// so that the back of the model won't be removed (culled)
		CGPROGRAM
		// This shader is not trying to simulate a realistic material, 
		// so there is no need to use the PBR lighting model. 
		// The Lambertian re ectance, which is very cheap, is used instead. 
		// Additionally, we should disable any lighting with nolighting 
		// and signal to Cg that this is a Transparent Shader using alpha:fade:
		#pragma surface surf Lambert alpha:fade nolighting

		sampler2D _MainTex;

		//
		struct Input {
			float2 uv_MainTex; 
			float3 worldNormal; 
			float3 viewDir;
		};

		fixed4 _Color;
		float _DotProduct;

		// this shader is using the Lambertian reflectance as its lighting function, 
		// the name of the surface output structure should be changed accordingly to 
		// SurfaeOutput instead of SurfaceOutputStandard:
		void surf (Input IN, inout SurfaceOutput o) {
			float4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color; 
			o.Albedo = c.rgb;
			float border = 1 - (abs(dot(IN.viewDir, IN.worldNormal)));
			float alpha = (border * (1 - _DotProduct) + _DotProduct);
         	o.Alpha = c.a * alpha;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
