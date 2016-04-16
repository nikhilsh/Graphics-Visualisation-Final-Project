
Shader "FluidSim/Impluse" 
{
	SubShader 
	{
    	Pass 
    	{
			ZTest Always
			Blend SrcAlpha OneMinusSrcAlpha 

			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			
			uniform float2 _Point;
			uniform float _Radius;
			uniform float3 _FillColor;
			
			struct v2f 
			{
				float4  pos : SV_POSITION;
				float2  uv : TEXCOORD0;
			};
			
			v2f vert(appdata_base v)
			{
				v2f OUT;
				OUT.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				OUT.uv = v.texcoord.xy;
				return OUT;
			}
			
			float4 frag(v2f IN) : COLOR
			{
			    float d = distance(_Point, IN.uv);
			    
			    float4 result = float4(0,0,0,0);
			    
			    if(d < _Radius) 
			    {
			        float a = (_Radius - d) * 0.5;
        			a = min(a, 1.0);
			        result = float4(_FillColor, a);
			    } 
			  
			  	return result;
			}
			
			ENDCG

    	}
	}
}