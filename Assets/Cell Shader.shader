Shader "Unlit/Cell Shader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _Threshold ("Threshold", Range(0,1)) = 0.5
        _LightColor ("Light Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
                float3 normal : TEXCOORD1;
                float3 lightDir : TEXCOORD2;
            };

            sampler2D _MainTex;
            float4 _Color;
            float _Threshold;
            float4 _LightColor;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;

                // Transform normal to world space
                float3 worldNormal = normalize(mul(v.normal, (float3x3)unity_WorldToObject));
                
                // Get light direction
                float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                float3 lightDir = normalize(_WorldSpaceLightPos0.xyz - worldPos);
                
                o.lightDir = lightDir;
                o.normal = worldNormal;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // Sample the texture
                fixed4 tex = tex2D(_MainTex, i.uv) * _Color;
                
                // Calculate diffuse lighting
                float NdotL = max(0, dot(i.normal, i.lightDir));
                
                // Apply cel shading effect
                if (NdotL > _Threshold)
                    NdotL = 1.0;
                else
                    NdotL = 0.5;

                fixed4 result = tex * NdotL * _LightColor;
                return result;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
