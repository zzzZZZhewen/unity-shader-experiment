﻿Shader "CookbookShaders/Chapter06/Multiply" {
	Properties
	{
		_Color ("Color", Color) = (1,0,0,1)
		_MainTex("Base (RGB) Trans (A)", 2D) = "white" {}
	}
		SubShader{
			Pass{
			CGPROGRAM

	#pragma vertex vert             
	#pragma fragment frag

			half4 _Color;
	sampler2D _MainTex;

	struct vertInput {
		float4 pos : POSITION;
		float2 texcoord : TEXCOORD0;
	};

	struct vertOutput {
		float4 pos : SV_POSITION;
		float2 texcoord : TEXCOORD0;
	};

	vertOutput vert(vertInput input) {
		vertOutput o;
		o.pos = mul(UNITY_MATRIX_MVP, input.pos);
		o.texcoord = input.texcoord;
		return o;
	}

	half4 frag(vertOutput output) : COLOR{
		half4 mainColour = tex2D(_MainTex, output.texcoord);
		return mainColour * _Color;
	}
		ENDCG
	}
	}
}