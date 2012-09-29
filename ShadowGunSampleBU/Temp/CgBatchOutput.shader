Shader "Transparent/Refractive"
{
	Properties
	{
		_MainTex ("Base (RGB), Alpha (A)", 2D) = "white" {}
		_BumpMap ("Normal Map (RGB)", 2D) = "bump" {}
		_Mask ("Specularity (R), Shininess (G), Refraction (B)", 2D) = "black" {}
		_Color ("Color Tint", Color) = (1,1,1,1)
		_Specular ("Specular Color", Color) = (0,0,0,0)
		_Focus ("Focus", Range(-100.0, 100.0)) = -100.0
		_Shininess ("Shininess", Range(0.01, 1.0)) = 0.2
	}

	Category
	{
		Tags
		{
			"Queue" = "Transparent+1"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
		}

		SubShader
		{
			LOD 500

			GrabPass
			{
				Name "BASE"
				Tags { "LightMode" = "Always" }
			}

			Cull Off
			ZWrite Off
			ZTest LEqual
			Blend SrcAlpha OneMinusSrcAlpha
			AlphaTest Greater 0

				Alphatest Greater 0 ZWrite Off ColorMask RGB
	
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }
		Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
// Vertex combos: 3
//   opengl - ALU: 15 to 84
//   d3d9 - ALU: 16 to 87
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [_MainTex_ST]
"!!ARBvp1.0
# 53 ALU
PARAM c[24] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[13].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MOV R0.w, c[0].y;
MUL R1, R0.xyzz, R0.yzzx;
DP4 R2.z, R0, c[18];
DP4 R2.y, R0, c[17];
DP4 R2.x, R0, c[16];
MUL R0.w, R2, R2;
MAD R0.w, R0.x, R0.x, -R0;
DP4 R0.z, R1, c[21];
DP4 R0.y, R1, c[20];
DP4 R0.x, R1, c[19];
ADD R0.xyz, R2, R0;
MUL R1.xyz, R0.w, c[22];
ADD result.texcoord[4].xyz, R0, R1;
MOV R1.w, c[0].y;
MOV R1.xyz, c[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[13].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[15];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP3 result.texcoord[5].y, R1, R2;
DP3 result.texcoord[3].y, R3, R1;
DP4 R1.xy, vertex.position, c[4];
DP4 R1.z, vertex.position, c[1];
MOV R0.w, R1.y;
DP4 R0.z, vertex.position, c[3];
MOV R0.x, R1.z;
DP3 result.texcoord[5].z, vertex.normal, R2;
DP3 result.texcoord[5].x, vertex.attrib[14], R2;
DP4 R2.xy, vertex.position, c[2];
MOV R0.y, R2;
MOV result.position, R0;
MOV R1.w, R2.x;
MOV result.texcoord[1], R0;
ADD R0.xy, R1.x, R1.zwzw;
DP3 result.texcoord[3].z, vertex.normal, R3;
DP3 result.texcoord[3].x, R3, vertex.attrib[14];
MOV result.color, vertex.color;
MOV result.texcoord[2].zw, R0;
MUL result.texcoord[2].xy, R0, c[0].x;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
END
# 53 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Vector 22 [_MainTex_ST]
"vs_2_0
; 56 ALU
def c23, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
mul r1.xyz, v2, c12.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mov r0.w, c23.y
mul r1, r0.xyzz, r0.yzzx
dp4 r2.z, r0, c17
dp4 r2.y, r0, c16
dp4 r2.x, r0, c15
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp4 r0.z, r1, c20
dp4 r0.y, r1, c19
dp4 r0.x, r1, c18
mul r1.xyz, r0.w, c21
add r0.xyz, r2, r0
add oT4.xyz, r0, r1
mov r0.w, c23.y
mov r0.xyz, c13
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c12.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r1, c8
dp4 r4.x, c14, r1
mov r0, c10
dp4 r4.z, c14, r0
mov r0, c9
dp4 r4.y, c14, r0
dp4 r1.zw, v0, c3
dp4 r1.x, v0, c0
mov r0.w, r1
dp4 r0.z, v0, c2
mov r0.x, r1
dp3 oT3.y, r4, r2
dp3 oT5.y, r2, r3
dp4 r2.xy, v0, c1
mov r0.y, r2
mov oPos, r0
mov r1.y, -r2.x
mov oT1, r0
add r0.xy, r1.z, r1
dp3 oT3.z, v2, r4
dp3 oT3.x, r4, v1
dp3 oT5.z, v2, r3
dp3 oT5.x, v1, r3
mov oD0, v4
mov oT2.zw, r0
mul oT2.xy, r0, c23.x
mad oT0.xy, v3, c22, c22.zwzw
"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Vector 22 [_MainTex_ST]
"agal_vs
c23 0.5 1.0 0.0 0.0
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaamaaaappabaaaaaa mul r1.xyz, a1, c12.w
bcaaaaaaacaaaiacabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r2.w, r1.xyzz, c5
bcaaaaaaaaaaabacabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r0.x, r1.xyzz, c4
bcaaaaaaaaaaaeacabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r0.z, r1.xyzz, c6
aaaaaaaaaaaaacacacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r2.w
aaaaaaaaaaaaaiacbhaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c23.y
adaaaaaaabaaapacaaaaaakeacaaaaaaaaaaaacjacaaaaaa mul r1, r0.xyzz, r0.yzzx
bdaaaaaaacaaaeacaaaaaaoeacaaaaaabbaaaaoeabaaaaaa dp4 r2.z, r0, c17
bdaaaaaaacaaacacaaaaaaoeacaaaaaabaaaaaoeabaaaaaa dp4 r2.y, r0, c16
bdaaaaaaacaaabacaaaaaaoeacaaaaaaapaaaaoeabaaaaaa dp4 r2.x, r0, c15
adaaaaaaaaaaaiacacaaaappacaaaaaaacaaaappacaaaaaa mul r0.w, r2.w, r2.w
adaaaaaaadaaaiacaaaaaaaaacaaaaaaaaaaaaaaacaaaaaa mul r3.w, r0.x, r0.x
acaaaaaaaaaaaiacadaaaappacaaaaaaaaaaaappacaaaaaa sub r0.w, r3.w, r0.w
bdaaaaaaaaaaaeacabaaaaoeacaaaaaabeaaaaoeabaaaaaa dp4 r0.z, r1, c20
bdaaaaaaaaaaacacabaaaaoeacaaaaaabdaaaaoeabaaaaaa dp4 r0.y, r1, c19
bdaaaaaaaaaaabacabaaaaoeacaaaaaabcaaaaoeabaaaaaa dp4 r0.x, r1, c18
adaaaaaaabaaahacaaaaaappacaaaaaabfaaaaoeabaaaaaa mul r1.xyz, r0.w, c21
abaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaaeaaahaeaaaaaakeacaaaaaaabaaaakeacaaaaaa add v4.xyz, r0.xyzz, r1.xyzz
aaaaaaaaaaaaaiacbhaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c23.y
aaaaaaaaaaaaahacanaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c13
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r1.z, r0, c10
bdaaaaaaabaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r1.y, r0, c9
bdaaaaaaabaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r1.x, r0, c8
adaaaaaaaeaaahacabaaaakeacaaaaaaamaaaappabaaaaaa mul r4.xyz, r1.xyzz, c12.w
acaaaaaaadaaahacaeaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r4.xyzz, a0
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaaaaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r0.yzxx
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaafaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r5.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacafaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r5.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaabaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c8
bdaaaaaaaeaaabacaoaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.x, c14, r1
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaaeaaaeacaoaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c14, r0
aaaaaaaaaaaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c9
bdaaaaaaaeaaacacaoaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.y, c14, r0
bdaaaaaaabaaamacaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 r1.zw, a0, c3
bdaaaaaaabaaabacaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 r1.x, a0, c0
aaaaaaaaaaaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r1.w
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r0.z, a0, c2
aaaaaaaaaaaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r1.x
bcaaaaaaadaaacaeaeaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v3.y, r4.xyzz, r2.xyzz
bcaaaaaaafaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v5.y, r2.xyzz, r3.xyzz
bdaaaaaaacaaadacaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 r2.xy, a0, c1
aaaaaaaaaaaaacacacaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r2.y
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
bfaaaaaaabaaacacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.y, r2.x
aaaaaaaaabaaapaeaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov v1, r0
abaaaaaaaaaaadacabaaaakkacaaaaaaabaaaafeacaaaaaa add r0.xy, r1.z, r1.xyyy
bcaaaaaaadaaaeaeabaaaaoeaaaaaaaaaeaaaakeacaaaaaa dp3 v3.z, a1, r4.xyzz
bcaaaaaaadaaabaeaeaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v3.x, r4.xyzz, a5
bcaaaaaaafaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v5.z, a1, r3.xyzz
bcaaaaaaafaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v5.x, a5, r3.xyzz
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
aaaaaaaaacaaamaeaaaaaaopacaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, r0.wwzw
adaaaaaaacaaadaeaaaaaafeacaaaaaabhaaaaaaabaaaaaa mul v2.xy, r0.xyyy, c23.x
adaaaaaaafaaadacadaaaaoeaaaaaaaabgaaaaoeabaaaaaa mul r5.xy, a3, c22
abaaaaaaaaaaadaeafaaaafeacaaaaaabgaaaaooabaaaaaa add v0.xy, r5.xyyy, c22.zwzw
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
aaaaaaaaafaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v5.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
"!!ARBvp1.0
# 15 ALU
PARAM c[16] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R1.y, R0;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.color, vertex.color;
MOV result.texcoord[1], R1;
MOV result.texcoord[2].zw, R1;
MUL result.texcoord[2].xy, R0, c[0].x;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[14], c[14].zwzw;
END
# 15 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
"vs_2_0
; 16 ALU
def c14, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov r1.y, r0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0
add r0.xy, r0.z, r0
mov oPos, r1
mov oD0, v5
mov oT1, r1
mov oT2.zw, r1
mul oT2.xy, r0, c14.x
mad oT0.xy, v3, c13, c13.zwzw
mad oT3.xy, v4, c12, c12.zwzw
"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
"agal_vs
c14 0.5 0.0 0.0 0.0
[bc]
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 r0.z, a0, c3
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 r0.x, a0, c0
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 r0.y, a0, c1
aaaaaaaaabaaacacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r1.y, r0.y
aaaaaaaaabaaaiacaaaaaakkacaaaaaaaaaaaaaaaaaaaaaa mov r1.w, r0.z
bdaaaaaaabaaaeacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r1.z, a0, c2
aaaaaaaaabaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r0.x
bfaaaaaaaaaaacacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r0.y, r0.y
abaaaaaaaaaaadacaaaaaakkacaaaaaaaaaaaafeacaaaaaa add r0.xy, r0.z, r0.xyyy
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
aaaaaaaaabaaapaeabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov v1, r1
aaaaaaaaacaaamaeabaaaaopacaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, r1.wwzw
adaaaaaaacaaadaeaaaaaafeacaaaaaaaoaaaaaaabaaaaaa mul v2.xy, r0.xyyy, c14.x
adaaaaaaaaaaadacadaaaaoeaaaaaaaaanaaaaoeabaaaaaa mul r0.xy, a3, c13
abaaaaaaaaaaadaeaaaaaafeacaaaaaaanaaaaooabaaaaaa add v0.xy, r0.xyyy, c13.zwzw
adaaaaaaaaaaadacaeaaaaoeaaaaaaaaamaaaaoeabaaaaaa mul r0.xy, a4, c12
abaaaaaaadaaadaeaaaaaafeacaaaaaaamaaaaooabaaaaaa add v3.xy, r0.xyyy, c12.zwzw
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaadaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.zw, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Vector 31 [_MainTex_ST]
"!!ARBvp1.0
# 84 ALU
PARAM c[32] = { { 0.5, 1, 0 },
		state.matrix.mvp,
		program.local[5..31] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[13].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[17];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[16];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].y;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[18];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[19];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].y;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].z;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[21];
MAD R1.xyz, R0.x, c[20], R1;
MAD R0.xyz, R0.z, c[22], R1;
MAD R1.xyz, R0.w, c[23], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R3.z, R0, c[29];
DP4 R3.y, R0, c[28];
DP4 R3.x, R0, c[27];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[30];
MOV R1.w, c[0].y;
DP4 R2.z, R4, c[26];
DP4 R2.y, R4, c[25];
DP4 R2.x, R4, c[24];
ADD R2.xyz, R2, R3;
ADD R0.xyz, R2, R0;
ADD result.texcoord[4].xyz, R0, R1;
MOV R1.xyz, c[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[13].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1, c[15];
MUL R0.xyz, R0, vertex.attrib[14].w;
DP4 R3.z, R1, c[11];
DP4 R3.y, R1, c[10];
DP4 R3.x, R1, c[9];
DP4 R1.zw, vertex.position, c[4];
DP3 result.texcoord[5].y, R0, R2;
DP3 result.texcoord[3].y, R3, R0;
DP4 R1.x, vertex.position, c[1];
MOV R0.w, R1;
DP4 R0.z, vertex.position, c[3];
MOV R0.x, R1;
DP3 result.texcoord[5].z, vertex.normal, R2;
DP3 result.texcoord[5].x, vertex.attrib[14], R2;
DP4 R2.xy, vertex.position, c[2];
MOV R0.y, R2;
MOV result.position, R0;
MOV R1.y, R2.x;
MOV result.texcoord[1], R0;
ADD R0.xy, R1.z, R1;
DP3 result.texcoord[3].z, vertex.normal, R3;
DP3 result.texcoord[3].x, R3, vertex.attrib[14];
MOV result.color, vertex.color;
MOV result.texcoord[2].zw, R0;
MUL result.texcoord[2].xy, R0, c[0].x;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[31], c[31].zwzw;
END
# 84 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 18 [unity_4LightAtten0]
Vector 19 [unity_LightColor0]
Vector 20 [unity_LightColor1]
Vector 21 [unity_LightColor2]
Vector 22 [unity_LightColor3]
Vector 23 [unity_SHAr]
Vector 24 [unity_SHAg]
Vector 25 [unity_SHAb]
Vector 26 [unity_SHBr]
Vector 27 [unity_SHBg]
Vector 28 [unity_SHBb]
Vector 29 [unity_SHC]
Vector 30 [_MainTex_ST]
"vs_2_0
; 87 ALU
def c31, 0.50000000, 1.00000000, 0.00000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
mul r3.xyz, v2, c12.w
dp4 r0.x, v0, c5
add r1, -r0.x, c16
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c15
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c31.y
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c17
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c18
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c31.y
dp4 r2.z, r4, c25
dp4 r2.y, r4, c24
dp4 r2.x, r4, c23
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c31.z
mul r0, r0, r1
mul r1.xyz, r0.y, c20
mad r1.xyz, r0.x, c19, r1
mad r0.xyz, r0.z, c21, r1
mad r1.xyz, r0.w, c22, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c28
dp4 r3.y, r0, c27
dp4 r3.x, r0, c26
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c29
add r2.xyz, r2, r3
add r0.xyz, r2, r0
add oT4.xyz, r0, r1
mov r1.w, c31.y
mov r1.xyz, c13
dp4 r0.z, r1, c10
dp4 r0.y, r1, c9
dp4 r0.x, r1, c8
mad r3.xyz, r0, c12.w, -v0
mov r1.xyz, v1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r1.yzxw
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r1, c9
dp4 r4.y, c14, r1
mov r0, c10
dp4 r4.z, c14, r0
mov r0, c8
dp4 r4.x, c14, r0
dp4 r1.zw, v0, c3
dp4 r1.x, v0, c0
mov r0.w, r1
dp4 r0.z, v0, c2
mov r0.x, r1
dp3 oT3.y, r4, r2
dp3 oT5.y, r2, r3
dp4 r2.xy, v0, c1
mov r0.y, r2
mov oPos, r0
mov r1.y, -r2.x
mov oT1, r0
add r0.xy, r1.z, r1
dp3 oT3.z, v2, r4
dp3 oT3.x, r4, v1
dp3 oT5.z, v2, r3
dp3 oT5.x, v1, r3
mov oD0, v4
mov oT2.zw, r0
mul oT2.xy, r0, c31.x
mad oT0.xy, v3, c30, c30.zwzw
"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 18 [unity_4LightAtten0]
Vector 19 [unity_LightColor0]
Vector 20 [unity_LightColor1]
Vector 21 [unity_LightColor2]
Vector 22 [unity_LightColor3]
Vector 23 [unity_SHAr]
Vector 24 [unity_SHAg]
Vector 25 [unity_SHAb]
Vector 26 [unity_SHBr]
Vector 27 [unity_SHBg]
Vector 28 [unity_SHBb]
Vector 29 [unity_SHC]
Vector 30 [_MainTex_ST]
"agal_vs
c31 0.5 1.0 0.0 0.0
[bc]
adaaaaaaadaaahacabaaaaoeaaaaaaaaamaaaappabaaaaaa mul r3.xyz, a1, c12.w
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.x, a0, c5
bfaaaaaaabaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.x, r0.x
abaaaaaaabaaapacabaaaaaaacaaaaaabaaaaaoeabaaaaaa add r1, r1.x, c16
bcaaaaaaadaaaiacadaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r3.w, r3.xyzz, c5
bcaaaaaaaeaaabacadaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r4.x, r3.xyzz, c4
bcaaaaaaadaaabacadaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r3.x, r3.xyzz, c6
adaaaaaaacaaapacadaaaappacaaaaaaabaaaaoeacaaaaaa mul r2, r3.w, r1
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bfaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r0.x, r0.x
abaaaaaaaaaaapacaaaaaaaaacaaaaaaapaaaaoeabaaaaaa add r0, r0.x, c15
adaaaaaaabaaapacabaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r1, r1, r1
aaaaaaaaaeaaaeacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r4.z, r3.x
adaaaaaaafaaapacaeaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r5, r4.x, r0
abaaaaaaacaaapacafaaaaoeacaaaaaaacaaaaoeacaaaaaa add r2, r5, r2
aaaaaaaaaeaaaiacbpaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r4.w, c31.y
bdaaaaaaaeaaacacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r4.y, a0, c6
adaaaaaaafaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r5, r0, r0
abaaaaaaabaaapacafaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r5, r1
bfaaaaaaaaaaacacaeaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r0.y, r4.y
abaaaaaaaaaaapacaaaaaaffacaaaaaabbaaaaoeabaaaaaa add r0, r0.y, c17
adaaaaaaafaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r5, r0, r0
abaaaaaaabaaapacafaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r5, r1
adaaaaaaaaaaapacadaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r0, r3.x, r0
abaaaaaaaaaaapacaaaaaaoeacaaaaaaacaaaaoeacaaaaaa add r0, r0, r2
adaaaaaaacaaapacabaaaaoeacaaaaaabcaaaaoeabaaaaaa mul r2, r1, c18
aaaaaaaaaeaaacacadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r4.y, r3.w
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
akaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rsq r1.y, r1.y
akaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r1.w, r1.w
akaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rsq r1.z, r1.z
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
abaaaaaaabaaapacacaaaaoeacaaaaaabpaaaaffabaaaaaa add r1, r2, c31.y
bdaaaaaaacaaaeacaeaaaaoeacaaaaaabjaaaaoeabaaaaaa dp4 r2.z, r4, c25
bdaaaaaaacaaacacaeaaaaoeacaaaaaabiaaaaoeabaaaaaa dp4 r2.y, r4, c24
bdaaaaaaacaaabacaeaaaaoeacaaaaaabhaaaaoeabaaaaaa dp4 r2.x, r4, c23
afaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r1.x, r1.x
afaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rcp r1.y, r1.y
afaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rcp r1.w, r1.w
afaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rcp r1.z, r1.z
ahaaaaaaaaaaapacaaaaaaoeacaaaaaabpaaaakkabaaaaaa max r0, r0, c31.z
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
adaaaaaaabaaahacaaaaaaffacaaaaaabeaaaaoeabaaaaaa mul r1.xyz, r0.y, c20
adaaaaaaafaaahacaaaaaaaaacaaaaaabdaaaaoeabaaaaaa mul r5.xyz, r0.x, c19
abaaaaaaabaaahacafaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r5.xyzz, r1.xyzz
adaaaaaaaaaaahacaaaaaakkacaaaaaabfaaaaoeabaaaaaa mul r0.xyz, r0.z, c21
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaahacaaaaaappacaaaaaabgaaaaoeabaaaaaa mul r1.xyz, r0.w, c22
abaaaaaaabaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r1.xyz, r1.xyzz, r0.xyzz
adaaaaaaaaaaapacaeaaaakeacaaaaaaaeaaaacjacaaaaaa mul r0, r4.xyzz, r4.yzzx
adaaaaaaabaaaiacadaaaappacaaaaaaadaaaappacaaaaaa mul r1.w, r3.w, r3.w
bdaaaaaaadaaaeacaaaaaaoeacaaaaaabmaaaaoeabaaaaaa dp4 r3.z, r0, c28
bdaaaaaaadaaacacaaaaaaoeacaaaaaablaaaaoeabaaaaaa dp4 r3.y, r0, c27
bdaaaaaaadaaabacaaaaaaoeacaaaaaabkaaaaoeabaaaaaa dp4 r3.x, r0, c26
adaaaaaaafaaaiacaeaaaaaaacaaaaaaaeaaaaaaacaaaaaa mul r5.w, r4.x, r4.x
acaaaaaaabaaaiacafaaaappacaaaaaaabaaaappacaaaaaa sub r1.w, r5.w, r1.w
adaaaaaaaaaaahacabaaaappacaaaaaabnaaaaoeabaaaaaa mul r0.xyz, r1.w, c29
abaaaaaaacaaahacacaaaakeacaaaaaaadaaaakeacaaaaaa add r2.xyz, r2.xyzz, r3.xyzz
abaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaaeaaahaeaaaaaakeacaaaaaaabaaaakeacaaaaaa add v4.xyz, r0.xyzz, r1.xyzz
aaaaaaaaabaaaiacbpaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r1.w, c31.y
aaaaaaaaabaaahacanaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, c13
bdaaaaaaaaaaaeacabaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r0.z, r1, c10
bdaaaaaaaaaaacacabaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r0.y, r1, c9
bdaaaaaaaaaaabacabaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r0.x, r1, c8
adaaaaaaafaaahacaaaaaakeacaaaaaaamaaaappabaaaaaa mul r5.xyz, r0.xyzz, c12.w
acaaaaaaadaaahacafaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r5.xyzz, a0
aaaaaaaaabaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, a5
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaabaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r1.yzxx
adaaaaaaafaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r5.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacafaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r5.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaabaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c9
bdaaaaaaaeaaacacaoaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.y, c14, r1
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaaeaaaeacaoaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c14, r0
aaaaaaaaaaaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c8
bdaaaaaaaeaaabacaoaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.x, c14, r0
bdaaaaaaabaaamacaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 r1.zw, a0, c3
bdaaaaaaabaaabacaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 r1.x, a0, c0
aaaaaaaaaaaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r1.w
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r0.z, a0, c2
aaaaaaaaaaaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r1.x
bcaaaaaaadaaacaeaeaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v3.y, r4.xyzz, r2.xyzz
bcaaaaaaafaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v5.y, r2.xyzz, r3.xyzz
bdaaaaaaacaaadacaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 r2.xy, a0, c1
aaaaaaaaaaaaacacacaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r2.y
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
bfaaaaaaabaaacacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.y, r2.x
aaaaaaaaabaaapaeaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov v1, r0
abaaaaaaaaaaadacabaaaakkacaaaaaaabaaaafeacaaaaaa add r0.xy, r1.z, r1.xyyy
bcaaaaaaadaaaeaeabaaaaoeaaaaaaaaaeaaaakeacaaaaaa dp3 v3.z, a1, r4.xyzz
bcaaaaaaadaaabaeaeaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v3.x, r4.xyzz, a5
bcaaaaaaafaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v5.z, a1, r3.xyzz
bcaaaaaaafaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v5.x, a5, r3.xyzz
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
aaaaaaaaacaaamaeaaaaaaopacaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, r0.wwzw
adaaaaaaacaaadaeaaaaaafeacaaaaaabpaaaaaaabaaaaaa mul v2.xy, r0.xyyy, c31.x
adaaaaaaafaaadacadaaaaoeaaaaaaaaboaaaaoeabaaaaaa mul r5.xy, a3, c30
abaaaaaaaaaaadaeafaaaafeacaaaaaaboaaaaooabaaaaaa add v0.xy, r5.xyyy, c30.zwzw
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
aaaaaaaaafaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v5.w, c0
"
}

}
Program "fp" {
// Fragment combos: 2
//   opengl - ALU: 19 to 42, TEX: 4 to 5
//   d3d9 - ALU: 16 to 42, TEX: 4 to 5
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Vector 3 [_GrabTexture_TexelSize]
Float 4 [_Focus]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 42 ALU, 4 TEX
PARAM c[8] = { program.local[0..5],
		{ 2, 1, 0, 250 },
		{ 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.yw, fragment.texcoord[0], texture[1], 2D;
MAD R3.xy, R0.wyzw, c[6].x, -c[6].y;
MUL R0.xy, R3, c[3];
MUL R0.xy, R0, c[4].x;
MAD R1.xy, R0, fragment.texcoord[2].z, fragment.texcoord[2];
MOV R1.z, fragment.texcoord[2].w;
MUL R1.w, R3.y, R3.y;
MAD R1.w, -R3.x, R3.x, -R1;
ADD R1.w, R1, c[6].y;
RSQ R1.w, R1.w;
RCP R3.z, R1.w;
DP3 R1.w, R3, R3;
RSQ R1.w, R1.w;
MUL R3.xyz, R1.w, R3;
DP3 R1.w, R3, fragment.texcoord[3];
MUL R3.xyz, R1.w, R3;
DP3 R2.w, fragment.texcoord[5], fragment.texcoord[5];
RSQ R2.w, R2.w;
MAD R4.xyz, -R3, c[6].x, fragment.texcoord[3];
MUL R3.xyz, R2.w, fragment.texcoord[5];
DP3 R3.x, -R3, R4;
MOV R2.w, c[7].x;
TXP R2.xyz, R1.xyzz, texture[3], 2D;
TEX R1.xyz, fragment.texcoord[0], texture[2], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1.y, R1, c[5].x;
MAD R2.w, R1.y, c[6], R2;
MAX R1.y, R3.x, c[6].z;
POW R1.y, R1.y, R2.w;
MUL R1.x, R1, R1.y;
MUL R2.xyz, R2, c[1];
MUL R3.xyz, fragment.color.primary, R0;
MAD R0.xyz, -fragment.color.primary, R0, R2;
MUL R2.xyz, R1.x, c[2];
MAD R0.xyz, R1.z, R0, R3;
MAX R1.x, R1.w, c[6].z;
MAD R1.xyz, R0, R1.x, R2;
MUL R2.xyz, R0, fragment.texcoord[4];
MUL R1.xyz, R1, c[0];
MUL R0.x, fragment.color.primary.w, c[1].w;
MAD result.color.xyz, R1, c[6].x, R2;
MUL result.color.w, R0.x, R0;
END
# 42 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Vector 3 [_GrabTexture_TexelSize]
Float 4 [_Focus]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
"ps_2_0
; 42 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c6, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c7, 250.00000000, 4.00000000, 0, 0
dcl t0.xy
dcl v0
dcl t2
dcl t3.xyz
dcl t4.xyz
dcl t5.xyz
texld r0, t0, s1
texld r3, t0, s0
texld r5, t0, s2
mov r0.x, r0.w
mad_pp r1.xy, r0, c6.x, c6.y
mul_pp r0.xy, r1, c3
mul_pp r0.xy, r0, c4.x
mad r0.xy, r0, t2.z, t2
mov r0.zw, t2
texldp r4, r0, s3
mul_pp r0.x, r1.y, r1.y
mad_pp r0.x, -r1, r1, -r0
add_pp r0.x, r0, c6.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
dp3_pp r0.x, r1, r1
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r1
dp3_pp r0.x, r1, t3
mul_pp r1.xyz, r0.x, r1
mad_pp r6.xyz, -r1, c6.x, t3
dp3_pp r1.x, t5, t5
rsq_pp r2.x, r1.x
mul_pp r2.xyz, r2.x, t5
dp3_pp r2.x, -r2, r6
mul_pp r1.x, r5.y, c5
mad_pp r1.x, r1, c7, c7.y
max_pp r2.x, r2, c6.w
pow_pp r6.x, r2.x, r1.x
mul_pp r2.xyz, r4, c1
mov_pp r1.x, r6.x
mul_pp r1.x, r5, r1
mul_pp r1.xyz, r1.x, c2
mul r4.xyz, v0, r3
mad r2.xyz, -v0, r3, r2
mad r2.xyz, r5.z, r2, r4
max_pp r0.x, r0, c6.w
mad_pp r0.xyz, r2, r0.x, r1
mul_pp r1.xyz, r0, c0
mul_pp r2.xyz, r2, t4
mul r0.x, v0.w, c1.w
mad_pp r1.xyz, r1, c6.x, r2
mul r1.w, r0.x, r3
mov_pp oC0, r1
"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Vector 3 [_GrabTexture_TexelSize]
Float 4 [_Focus]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
"agal_ps
c6 2.0 -1.0 1.0 0.0
c7 250.0 4.0 0.0 0.0
[bc]
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r0, v0, s1 <2d wrap linear point>
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
ciaaaaaaafaaapacaaaaaaoeaeaaaaaaacaaaaaaafaababb tex r5, v0, s2 <2d wrap linear point>
aaaaaaaaaaaaabacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r0.w
adaaaaaaabaaadacaaaaaafeacaaaaaaagaaaaaaabaaaaaa mul r1.xy, r0.xyyy, c6.x
abaaaaaaabaaadacabaaaafeacaaaaaaagaaaaffabaaaaaa add r1.xy, r1.xyyy, c6.y
adaaaaaaaaaaadacabaaaafeacaaaaaaadaaaaoeabaaaaaa mul r0.xy, r1.xyyy, c3
adaaaaaaaaaaadacaaaaaafeacaaaaaaaeaaaaaaabaaaaaa mul r0.xy, r0.xyyy, c4.x
adaaaaaaaaaaadacaaaaaafeacaaaaaaacaaaakkaeaaaaaa mul r0.xy, r0.xyyy, v2.z
abaaaaaaaaaaadacaaaaaafeacaaaaaaacaaaaoeaeaaaaaa add r0.xy, r0.xyyy, v2
aaaaaaaaaaaaamacacaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r0.zw, v2
aeaaaaaaacaaapacaaaaaaoeacaaaaaaaaaaaappacaaaaaa div r2, r0, r0.w
ciaaaaaaaeaaapacacaaaafeacaaaaaaadaaaaaaafaababb tex r4, r2.xyyy, s3 <2d wrap linear point>
adaaaaaaaaaaabacabaaaaffacaaaaaaabaaaaffacaaaaaa mul r0.x, r1.y, r1.y
bfaaaaaaacaaaiacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r2.w, r1.x
adaaaaaaacaaaiacacaaaappacaaaaaaabaaaaaaacaaaaaa mul r2.w, r2.w, r1.x
acaaaaaaaaaaabacacaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r2.w, r0.x
abaaaaaaaaaaabacaaaaaaaaacaaaaaaagaaaakkabaaaaaa add r0.x, r0.x, c6.z
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
afaaaaaaabaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r1.z, r0.x
bcaaaaaaaaaaabacabaaaakeacaaaaaaabaaaakeacaaaaaa dp3 r0.x, r1.xyzz, r1.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaabaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.x, r1.xyzz
bcaaaaaaaaaaabacabaaaakeacaaaaaaadaaaaoeaeaaaaaa dp3 r0.x, r1.xyzz, v3
adaaaaaaabaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.x, r1.xyzz
bfaaaaaaagaaahacabaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r6.xyz, r1.xyzz
adaaaaaaagaaahacagaaaakeacaaaaaaagaaaaaaabaaaaaa mul r6.xyz, r6.xyzz, c6.x
abaaaaaaagaaahacagaaaakeacaaaaaaadaaaaoeaeaaaaaa add r6.xyz, r6.xyzz, v3
bcaaaaaaabaaabacafaaaaoeaeaaaaaaafaaaaoeaeaaaaaa dp3 r1.x, v5, v5
akaaaaaaacaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r2.x, r1.x
adaaaaaaacaaahacacaaaaaaacaaaaaaafaaaaoeaeaaaaaa mul r2.xyz, r2.x, v5
bfaaaaaaahaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r7.xyz, r2.xyzz
bcaaaaaaacaaabacahaaaakeacaaaaaaagaaaakeacaaaaaa dp3 r2.x, r7.xyzz, r6.xyzz
adaaaaaaabaaabacafaaaaffacaaaaaaafaaaaoeabaaaaaa mul r1.x, r5.y, c5
adaaaaaaabaaabacabaaaaaaacaaaaaaahaaaaoeabaaaaaa mul r1.x, r1.x, c7
abaaaaaaabaaabacabaaaaaaacaaaaaaahaaaaffabaaaaaa add r1.x, r1.x, c7.y
ahaaaaaaacaaabacacaaaaaaacaaaaaaagaaaappabaaaaaa max r2.x, r2.x, c6.w
alaaaaaaagaaapacacaaaaaaacaaaaaaabaaaaaaacaaaaaa pow r6, r2.x, r1.x
adaaaaaaacaaahacaeaaaakeacaaaaaaabaaaaoeabaaaaaa mul r2.xyz, r4.xyzz, c1
aaaaaaaaabaaabacagaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r6.x
adaaaaaaabaaabacafaaaaaaacaaaaaaabaaaaaaacaaaaaa mul r1.x, r5.x, r1.x
adaaaaaaabaaahacabaaaaaaacaaaaaaacaaaaoeabaaaaaa mul r1.xyz, r1.x, c2
adaaaaaaaeaaahacahaaaaoeaeaaaaaaadaaaakeacaaaaaa mul r4.xyz, v7, r3.xyzz
bfaaaaaaahaaahacahaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa neg r7.xyz, v7
adaaaaaaahaaahacahaaaakeacaaaaaaadaaaakeacaaaaaa mul r7.xyz, r7.xyzz, r3.xyzz
abaaaaaaacaaahacahaaaakeacaaaaaaacaaaakeacaaaaaa add r2.xyz, r7.xyzz, r2.xyzz
adaaaaaaacaaahacafaaaakkacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r5.z, r2.xyzz
abaaaaaaacaaahacacaaaakeacaaaaaaaeaaaakeacaaaaaa add r2.xyz, r2.xyzz, r4.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaagaaaappabaaaaaa max r0.x, r0.x, c6.w
adaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r0.xyz, r2.xyzz, r0.x
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaahacaaaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r0.xyzz, c0
adaaaaaaacaaahacacaaaakeacaaaaaaaeaaaaoeaeaaaaaa mul r2.xyz, r2.xyzz, v4
adaaaaaaaaaaabacahaaaappaeaaaaaaabaaaappabaaaaaa mul r0.x, v7.w, c1.w
adaaaaaaabaaahacabaaaakeacaaaaaaagaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c6.x
abaaaaaaabaaahacabaaaakeacaaaaaaacaaaakeacaaaaaa add r1.xyz, r1.xyzz, r2.xyzz
adaaaaaaabaaaiacaaaaaaaaacaaaaaaadaaaappacaaaaaa mul r1.w, r0.x, r3.w
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
Vector 1 [_GrabTexture_TexelSize]
Float 2 [_Focus]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
SetTexture 4 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 19 ALU, 5 TEX
PARAM c[4] = { program.local[0..2],
		{ 2, 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0.yw, fragment.texcoord[0], texture[1], 2D;
TEX R1, fragment.texcoord[3], texture[4], 2D;
TEX R3.z, fragment.texcoord[0], texture[2], 2D;
MAD R0.xy, R0.wyzw, c[3].x, -c[3].y;
MUL R0.xy, R0, c[1];
MUL R0.xy, R0, c[2].x;
MAD R2.xy, R0, fragment.texcoord[2].z, fragment.texcoord[2];
MOV R2.z, fragment.texcoord[2].w;
MUL R1.xyz, R1.w, R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TXP R2.xyz, R2.xyzz, texture[3], 2D;
MUL R3.xyw, fragment.color.primary.xyzz, R0.xyzz;
MUL R2.xyz, R2, c[0];
MAD R0.xyz, -fragment.color.primary, R0, R2;
MAD R0.xyz, R3.z, R0, R3.xyww;
MUL R1.xyz, R1, R0;
MUL R0.x, fragment.color.primary.w, c[0].w;
MUL result.color.xyz, R1, c[3].z;
MUL result.color.w, R0.x, R0;
END
# 19 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
Vector 1 [_GrabTexture_TexelSize]
Float 2 [_Focus]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
SetTexture 4 [unity_Lightmap] 2D
"ps_2_0
; 16 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c3, 2.00000000, -1.00000000, 8.00000000, 0
dcl t0.xy
dcl v0
dcl t2
dcl t3.xy
texld r0, t0, s1
texld r3, t0, s2
texld r1, t0, s0
mov r0.x, r0.w
mad_pp r0.xy, r0, c3.x, c3.y
mul_pp r0.xy, r0, c1
mul_pp r0.xy, r0, c2.x
mov r0.zw, t2
mad r0.xy, r0, t2.z, t2
texldp r2, r0, s3
texld r0, t3, s4
mul_pp r2.xyz, r2, c0
mad r2.xyz, -v0, r1, r2
mul r1.xyz, v0, r1
mad r1.xyz, r3.z, r2, r1
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1
mul r1.x, v0.w, c0.w
mul_pp r0.xyz, r0, c3.z
mul r0.w, r1.x, r1
mov_pp oC0, r0
"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
Vector 1 [_GrabTexture_TexelSize]
Float 2 [_Focus]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
SetTexture 4 [unity_Lightmap] 2D
"agal_ps
c3 2.0 -1.0 8.0 0.0
[bc]
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r0, v0, s1 <2d wrap linear point>
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaacaaaaaaafaababb tex r3, v0, s2 <2d wrap linear point>
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r1, v0, s0 <2d wrap linear point>
aaaaaaaaaaaaabacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r0.w
adaaaaaaaaaaadacaaaaaafeacaaaaaaadaaaaaaabaaaaaa mul r0.xy, r0.xyyy, c3.x
abaaaaaaaaaaadacaaaaaafeacaaaaaaadaaaaffabaaaaaa add r0.xy, r0.xyyy, c3.y
adaaaaaaaaaaadacaaaaaafeacaaaaaaabaaaaoeabaaaaaa mul r0.xy, r0.xyyy, c1
adaaaaaaaaaaadacaaaaaafeacaaaaaaacaaaaaaabaaaaaa mul r0.xy, r0.xyyy, c2.x
aaaaaaaaaaaaamacacaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r0.zw, v2
adaaaaaaaaaaadacaaaaaafeacaaaaaaacaaaakkaeaaaaaa mul r0.xy, r0.xyyy, v2.z
abaaaaaaaaaaadacaaaaaafeacaaaaaaacaaaaoeaeaaaaaa add r0.xy, r0.xyyy, v2
aeaaaaaaacaaapacaaaaaaoeacaaaaaaaaaaaappacaaaaaa div r2, r0, r0.w
ciaaaaaaacaaapacacaaaafeacaaaaaaadaaaaaaafaababb tex r2, r2.xyyy, s3 <2d wrap linear point>
ciaaaaaaaaaaapacadaaaaoeaeaaaaaaaeaaaaaaafaababb tex r0, v3, s4 <2d wrap linear point>
adaaaaaaacaaahacacaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r2.xyz, r2.xyzz, c0
bfaaaaaaadaaalacahaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa neg r3.xyw, v7
adaaaaaaadaaalacadaaaapeacaaaaaaabaaaakeacaaaaaa mul r3.xyw, r3.xyww, r1.xyzz
abaaaaaaacaaahacadaaaapeacaaaaaaacaaaakeacaaaaaa add r2.xyz, r3.xyww, r2.xyzz
adaaaaaaabaaahacahaaaaoeaeaaaaaaabaaaakeacaaaaaa mul r1.xyz, v7, r1.xyzz
adaaaaaaacaaahacadaaaakkacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r3.z, r2.xyzz
abaaaaaaabaaahacacaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r2.xyzz, r1.xyzz
adaaaaaaaaaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r0.w, r0.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaabacahaaaappaeaaaaaaaaaaaappabaaaaaa mul r1.x, v7.w, c0.w
adaaaaaaaaaaahacaaaaaakeacaaaaaaadaaaakkabaaaaaa mul r0.xyz, r0.xyzz, c3.z
adaaaaaaaaaaaiacabaaaaaaacaaaaaaabaaaappacaaaaaa mul r0.w, r1.x, r1.w
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

}
	}
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardAdd" }
		ZWrite Off Blend One One Fog { Color (0,0,0,0) }
		Blend SrcAlpha One
Program "vp" {
// Vertex combos: 5
//   opengl - ALU: 35 to 44
//   d3d9 - ALU: 38 to 47
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 20 [_MainTex_ST]
"!!ARBvp1.0
# 43 ALU
PARAM c[21] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.w, c[0].y;
MOV R1.xyz, c[18];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP3 result.texcoord[4].y, R1, R2;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP3 result.texcoord[3].y, R0, R1;
DP4 R1.xy, vertex.position, c[4];
MOV R0.w, R1.y;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[3];
DP4 R1.z, vertex.position, c[1];
MOV R0.x, R1.z;
MOV result.texcoord[2].zw, R0;
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
DP4 R2.xy, vertex.position, c[2];
MOV R0.y, R2;
MOV R1.w, R2.x;
ADD R1.xy, R1.x, R1.zwzw;
MOV result.position, R0;
MOV result.texcoord[1], R0;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MOV result.color, vertex.color;
DP4 result.texcoord[5].z, R0, c[15];
DP4 result.texcoord[5].y, R0, c[14];
DP4 result.texcoord[5].x, R0, c[13];
MUL result.texcoord[2].xy, R1, c[0].x;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
END
# 43 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
"vs_2_0
; 46 ALU
def c20, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
mov r0.w, c20.y
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r1, c8
dp4 r4.x, c18, r1
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mad r0.xyz, r4, c16.w, -v0
dp4 r1.z, v0, c2
dp3 oT3.y, r0, r2
dp3 oT4.y, r2, r3
dp4 r2.xy, v0, c1
mov r1.y, r2
dp3 oT3.z, v2, r0
dp3 oT3.x, r0, v1
dp4 r0.xy, v0, c3
mov r1.w, r0.y
dp4 r0.z, v0, c0
mov r1.x, r0.z
mov r0.w, -r2.x
add r0.xy, r0.x, r0.zwzw
mov oPos, r1
mov oT1, r1
mov oT2.zw, r1
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
dp3 oT4.z, v2, r3
dp3 oT4.x, v1, r3
mov oD0, v4
dp4 oT5.z, r1, c14
dp4 oT5.y, r1, c13
dp4 oT5.x, r1, c12
mul oT2.xy, r0, c20.x
mad oT0.xy, v3, c19, c19.zwzw
"
}

SubProgram "flash " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
"agal_vs
c20 0.5 1.0 0.0 0.0
[bc]
aaaaaaaaaaaaaiacbeaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c20.y
aaaaaaaaaaaaahacbbaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c17
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r1.z, r0, c10
bdaaaaaaabaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r1.y, r0, c9
bdaaaaaaabaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r1.x, r0, c8
adaaaaaaacaaahacabaaaakeacaaaaaabaaaaappabaaaaaa mul r2.xyz, r1.xyzz, c16.w
acaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r2.xyzz, a0
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaaaaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r0.yzxx
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaaeaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r4.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacaeaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r4.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaabaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c8
bdaaaaaaaeaaabacbcaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.x, c18, r1
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaaeaaaeacbcaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c18, r0
aaaaaaaaaaaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c9
bdaaaaaaaeaaacacbcaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.y, c18, r0
adaaaaaaaeaaahacaeaaaakeacaaaaaabaaaaappabaaaaaa mul r4.xyz, r4.xyzz, c16.w
acaaaaaaaaaaahacaeaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r0.xyz, r4.xyzz, a0
bdaaaaaaabaaaeacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r1.z, a0, c2
bcaaaaaaadaaacaeaaaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v3.y, r0.xyzz, r2.xyzz
bcaaaaaaaeaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v4.y, r2.xyzz, r3.xyzz
bdaaaaaaacaaadacaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 r2.xy, a0, c1
aaaaaaaaabaaacacacaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r1.y, r2.y
bcaaaaaaadaaaeaeabaaaaoeaaaaaaaaaaaaaakeacaaaaaa dp3 v3.z, a1, r0.xyzz
bcaaaaaaadaaabaeaaaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v3.x, r0.xyzz, a5
bdaaaaaaaaaaadacaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 r0.xy, a0, c3
aaaaaaaaabaaaiacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r1.w, r0.y
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 r0.z, a0, c0
aaaaaaaaabaaabacaaaaaakkacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r0.z
bfaaaaaaaaaaaiacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r0.w, r2.x
abaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaapoacaaaaaa add r0.xy, r0.x, r0.zwww
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
aaaaaaaaabaaapaeabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov v1, r1
aaaaaaaaacaaamaeabaaaaopacaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, r1.wwzw
bdaaaaaaabaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r1.w, a0, c7
bdaaaaaaabaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r1.z, a0, c6
bdaaaaaaabaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r1.x, a0, c4
bdaaaaaaabaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r1.y, a0, c5
bcaaaaaaaeaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v4.z, a1, r3.xyzz
bcaaaaaaaeaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v4.x, a5, r3.xyzz
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
bdaaaaaaafaaaeaeabaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 v5.z, r1, c14
bdaaaaaaafaaacaeabaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 v5.y, r1, c13
bdaaaaaaafaaabaeabaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 v5.x, r1, c12
adaaaaaaacaaadaeaaaaaafeacaaaaaabeaaaaaaabaaaaaa mul v2.xy, r0.xyyy, c20.x
adaaaaaaaaaaadacadaaaaoeaaaaaaaabdaaaaoeabaaaaaa mul r0.xy, a3, c19
abaaaaaaaaaaadaeaaaaaafeacaaaaaabdaaaaooabaaaaaa add v0.xy, r0.xyyy, c19.zwzw
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
aaaaaaaaafaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v5.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 9 [unity_Scale]
Vector 10 [_WorldSpaceCameraPos]
Vector 11 [_WorldSpaceLightPos0]
Matrix 5 [_World2Object]
Vector 12 [_MainTex_ST]
"!!ARBvp1.0
# 35 ALU
PARAM c[13] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..12] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.w, c[0].y;
MOV R1.xyz, c[10];
DP4 R2.z, R1, c[7];
DP4 R2.y, R1, c[6];
DP4 R2.x, R1, c[5];
MAD R2.xyz, R2, c[9].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[11];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[7];
DP4 R3.y, R0, c[6];
DP4 R3.x, R0, c[5];
DP3 result.texcoord[4].y, R1, R2;
DP3 result.texcoord[3].y, R3, R1;
DP4 R1.xy, vertex.position, c[4];
DP4 R1.z, vertex.position, c[1];
MOV R0.w, R1.y;
DP4 R0.z, vertex.position, c[3];
MOV R0.x, R1.z;
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
DP4 R2.xy, vertex.position, c[2];
MOV R0.y, R2;
MOV result.position, R0;
MOV R1.w, R2.x;
MOV result.texcoord[1], R0;
ADD R0.xy, R1.x, R1.zwzw;
DP3 result.texcoord[3].z, vertex.normal, R3;
DP3 result.texcoord[3].x, R3, vertex.attrib[14];
MOV result.color, vertex.color;
MOV result.texcoord[2].zw, R0;
MUL result.texcoord[2].xy, R0, c[0].x;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[12], c[12].zwzw;
END
# 35 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_Scale]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Matrix 4 [_World2Object]
Vector 11 [_MainTex_ST]
"vs_2_0
; 38 ALU
def c12, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
mov r0.w, c12.y
mov r0.xyz, c9
dp4 r1.z, r0, c6
dp4 r1.y, r0, c5
dp4 r1.x, r0, c4
mad r3.xyz, r1, c8.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r1, c4
dp4 r4.x, c10, r1
mov r0, c6
dp4 r4.z, c10, r0
mov r0, c5
dp4 r4.y, c10, r0
dp4 r1.zw, v0, c3
dp4 r1.x, v0, c0
mov r0.w, r1
dp4 r0.z, v0, c2
mov r0.x, r1
dp3 oT3.y, r4, r2
dp3 oT4.y, r2, r3
dp4 r2.xy, v0, c1
mov r0.y, r2
mov oPos, r0
mov r1.y, -r2.x
mov oT1, r0
add r0.xy, r1.z, r1
dp3 oT3.z, v2, r4
dp3 oT3.x, r4, v1
dp3 oT4.z, v2, r3
dp3 oT4.x, v1, r3
mov oD0, v4
mov oT2.zw, r0
mul oT2.xy, r0, c12.x
mad oT0.xy, v3, c11, c11.zwzw
"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_Scale]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Matrix 4 [_World2Object]
Vector 11 [_MainTex_ST]
"agal_vs
c12 0.5 1.0 0.0 0.0
[bc]
aaaaaaaaaaaaaiacamaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c12.y
aaaaaaaaaaaaahacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c9
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaagaaaaoeabaaaaaa dp4 r1.z, r0, c6
bdaaaaaaabaaacacaaaaaaoeacaaaaaaafaaaaoeabaaaaaa dp4 r1.y, r0, c5
bdaaaaaaabaaabacaaaaaaoeacaaaaaaaeaaaaoeabaaaaaa dp4 r1.x, r0, c4
adaaaaaaacaaahacabaaaakeacaaaaaaaiaaaappabaaaaaa mul r2.xyz, r1.xyzz, c8.w
acaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r2.xyzz, a0
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaaaaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r0.yzxx
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaaeaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r4.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacaeaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r4.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaabaaapacaeaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c4
bdaaaaaaaeaaabacakaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.x, c10, r1
aaaaaaaaaaaaapacagaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c6
bdaaaaaaaeaaaeacakaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c10, r0
aaaaaaaaaaaaapacafaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c5
bdaaaaaaaeaaacacakaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.y, c10, r0
bdaaaaaaabaaamacaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 r1.zw, a0, c3
bdaaaaaaabaaabacaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 r1.x, a0, c0
aaaaaaaaaaaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r1.w
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r0.z, a0, c2
aaaaaaaaaaaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r1.x
bcaaaaaaadaaacaeaeaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v3.y, r4.xyzz, r2.xyzz
bcaaaaaaaeaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v4.y, r2.xyzz, r3.xyzz
bdaaaaaaacaaadacaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 r2.xy, a0, c1
aaaaaaaaaaaaacacacaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r2.y
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
bfaaaaaaabaaacacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.y, r2.x
aaaaaaaaabaaapaeaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov v1, r0
abaaaaaaaaaaadacabaaaakkacaaaaaaabaaaafeacaaaaaa add r0.xy, r1.z, r1.xyyy
bcaaaaaaadaaaeaeabaaaaoeaaaaaaaaaeaaaakeacaaaaaa dp3 v3.z, a1, r4.xyzz
bcaaaaaaadaaabaeaeaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v3.x, r4.xyzz, a5
bcaaaaaaaeaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v4.z, a1, r3.xyzz
bcaaaaaaaeaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v4.x, a5, r3.xyzz
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
aaaaaaaaacaaamaeaaaaaaopacaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, r0.wwzw
adaaaaaaacaaadaeaaaaaafeacaaaaaaamaaaaaaabaaaaaa mul v2.xy, r0.xyyy, c12.x
adaaaaaaaaaaadacadaaaaoeaaaaaaaaalaaaaoeabaaaaaa mul r0.xy, a3, c11
abaaaaaaaaaaadaeaaaaaafeacaaaaaaalaaaaooabaaaaaa add v0.xy, r0.xyyy, c11.zwzw
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 20 [_MainTex_ST]
"!!ARBvp1.0
# 44 ALU
PARAM c[21] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.w, c[0].y;
MOV R1.xyz, c[18];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP3 result.texcoord[4].y, R1, R2;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP3 result.texcoord[3].y, R0, R1;
DP4 R1.xy, vertex.position, c[4];
MOV R0.w, R1.y;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[3];
DP4 R1.z, vertex.position, c[1];
MOV R0.x, R1.z;
MOV result.texcoord[2].zw, R0;
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
DP4 R2.xy, vertex.position, c[2];
MOV R0.y, R2;
MOV R1.w, R2.x;
ADD R1.xy, R1.x, R1.zwzw;
MOV result.position, R0;
MOV result.texcoord[1], R0;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MOV result.color, vertex.color;
DP4 result.texcoord[5].w, R0, c[16];
DP4 result.texcoord[5].z, R0, c[15];
DP4 result.texcoord[5].y, R0, c[14];
DP4 result.texcoord[5].x, R0, c[13];
MUL result.texcoord[2].xy, R1, c[0].x;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
END
# 44 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
"vs_2_0
; 47 ALU
def c20, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
mov r0.w, c20.y
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r1, c8
dp4 r4.x, c18, r1
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mad r0.xyz, r4, c16.w, -v0
dp4 r1.z, v0, c2
dp3 oT3.y, r0, r2
dp3 oT4.y, r2, r3
dp4 r2.xy, v0, c1
mov r1.y, r2
dp3 oT3.z, v2, r0
dp3 oT3.x, r0, v1
dp4 r0.xy, v0, c3
mov r1.w, r0.y
dp4 r0.z, v0, c0
mov r1.x, r0.z
mov r0.w, -r2.x
add r0.xy, r0.x, r0.zwzw
mov oPos, r1
mov oT1, r1
mov oT2.zw, r1
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
dp3 oT4.z, v2, r3
dp3 oT4.x, v1, r3
mov oD0, v4
dp4 oT5.w, r1, c15
dp4 oT5.z, r1, c14
dp4 oT5.y, r1, c13
dp4 oT5.x, r1, c12
mul oT2.xy, r0, c20.x
mad oT0.xy, v3, c19, c19.zwzw
"
}

SubProgram "flash " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
"agal_vs
c20 0.5 1.0 0.0 0.0
[bc]
aaaaaaaaaaaaaiacbeaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c20.y
aaaaaaaaaaaaahacbbaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c17
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r1.z, r0, c10
bdaaaaaaabaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r1.y, r0, c9
bdaaaaaaabaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r1.x, r0, c8
adaaaaaaacaaahacabaaaakeacaaaaaabaaaaappabaaaaaa mul r2.xyz, r1.xyzz, c16.w
acaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r2.xyzz, a0
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaaaaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r0.yzxx
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaaeaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r4.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacaeaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r4.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaabaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c8
bdaaaaaaaeaaabacbcaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.x, c18, r1
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaaeaaaeacbcaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c18, r0
aaaaaaaaaaaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c9
bdaaaaaaaeaaacacbcaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.y, c18, r0
adaaaaaaaeaaahacaeaaaakeacaaaaaabaaaaappabaaaaaa mul r4.xyz, r4.xyzz, c16.w
acaaaaaaaaaaahacaeaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r0.xyz, r4.xyzz, a0
bdaaaaaaabaaaeacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r1.z, a0, c2
bcaaaaaaadaaacaeaaaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v3.y, r0.xyzz, r2.xyzz
bcaaaaaaaeaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v4.y, r2.xyzz, r3.xyzz
bdaaaaaaacaaadacaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 r2.xy, a0, c1
aaaaaaaaabaaacacacaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r1.y, r2.y
bcaaaaaaadaaaeaeabaaaaoeaaaaaaaaaaaaaakeacaaaaaa dp3 v3.z, a1, r0.xyzz
bcaaaaaaadaaabaeaaaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v3.x, r0.xyzz, a5
bdaaaaaaaaaaadacaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 r0.xy, a0, c3
aaaaaaaaabaaaiacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r1.w, r0.y
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 r0.z, a0, c0
aaaaaaaaabaaabacaaaaaakkacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r0.z
bfaaaaaaaaaaaiacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r0.w, r2.x
abaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaapoacaaaaaa add r0.xy, r0.x, r0.zwww
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
aaaaaaaaabaaapaeabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov v1, r1
aaaaaaaaacaaamaeabaaaaopacaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, r1.wwzw
bdaaaaaaabaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r1.w, a0, c7
bdaaaaaaabaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r1.z, a0, c6
bdaaaaaaabaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r1.x, a0, c4
bdaaaaaaabaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r1.y, a0, c5
bcaaaaaaaeaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v4.z, a1, r3.xyzz
bcaaaaaaaeaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v4.x, a5, r3.xyzz
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
bdaaaaaaafaaaiaeabaaaaoeacaaaaaaapaaaaoeabaaaaaa dp4 v5.w, r1, c15
bdaaaaaaafaaaeaeabaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 v5.z, r1, c14
bdaaaaaaafaaacaeabaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 v5.y, r1, c13
bdaaaaaaafaaabaeabaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 v5.x, r1, c12
adaaaaaaacaaadaeaaaaaafeacaaaaaabeaaaaaaabaaaaaa mul v2.xy, r0.xyyy, c20.x
adaaaaaaaaaaadacadaaaaoeaaaaaaaabdaaaaoeabaaaaaa mul r0.xy, a3, c19
abaaaaaaaaaaadaeaaaaaafeacaaaaaabdaaaaooabaaaaaa add v0.xy, r0.xyyy, c19.zwzw
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 20 [_MainTex_ST]
"!!ARBvp1.0
# 43 ALU
PARAM c[21] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.w, c[0].y;
MOV R1.xyz, c[18];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP3 result.texcoord[4].y, R1, R2;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP3 result.texcoord[3].y, R0, R1;
DP4 R1.xy, vertex.position, c[4];
MOV R0.w, R1.y;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[3];
DP4 R1.z, vertex.position, c[1];
MOV R0.x, R1.z;
MOV result.texcoord[2].zw, R0;
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
DP4 R2.xy, vertex.position, c[2];
MOV R0.y, R2;
MOV R1.w, R2.x;
ADD R1.xy, R1.x, R1.zwzw;
MOV result.position, R0;
MOV result.texcoord[1], R0;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MOV result.color, vertex.color;
DP4 result.texcoord[5].z, R0, c[15];
DP4 result.texcoord[5].y, R0, c[14];
DP4 result.texcoord[5].x, R0, c[13];
MUL result.texcoord[2].xy, R1, c[0].x;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
END
# 43 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
"vs_2_0
; 46 ALU
def c20, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
mov r0.w, c20.y
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r1, c8
dp4 r4.x, c18, r1
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mad r0.xyz, r4, c16.w, -v0
dp4 r1.z, v0, c2
dp3 oT3.y, r0, r2
dp3 oT4.y, r2, r3
dp4 r2.xy, v0, c1
mov r1.y, r2
dp3 oT3.z, v2, r0
dp3 oT3.x, r0, v1
dp4 r0.xy, v0, c3
mov r1.w, r0.y
dp4 r0.z, v0, c0
mov r1.x, r0.z
mov r0.w, -r2.x
add r0.xy, r0.x, r0.zwzw
mov oPos, r1
mov oT1, r1
mov oT2.zw, r1
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
dp3 oT4.z, v2, r3
dp3 oT4.x, v1, r3
mov oD0, v4
dp4 oT5.z, r1, c14
dp4 oT5.y, r1, c13
dp4 oT5.x, r1, c12
mul oT2.xy, r0, c20.x
mad oT0.xy, v3, c19, c19.zwzw
"
}

SubProgram "flash " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
"agal_vs
c20 0.5 1.0 0.0 0.0
[bc]
aaaaaaaaaaaaaiacbeaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c20.y
aaaaaaaaaaaaahacbbaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c17
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r1.z, r0, c10
bdaaaaaaabaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r1.y, r0, c9
bdaaaaaaabaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r1.x, r0, c8
adaaaaaaacaaahacabaaaakeacaaaaaabaaaaappabaaaaaa mul r2.xyz, r1.xyzz, c16.w
acaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r2.xyzz, a0
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaaaaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r0.yzxx
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaaeaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r4.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacaeaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r4.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaabaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c8
bdaaaaaaaeaaabacbcaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.x, c18, r1
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaaeaaaeacbcaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c18, r0
aaaaaaaaaaaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c9
bdaaaaaaaeaaacacbcaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.y, c18, r0
adaaaaaaaeaaahacaeaaaakeacaaaaaabaaaaappabaaaaaa mul r4.xyz, r4.xyzz, c16.w
acaaaaaaaaaaahacaeaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r0.xyz, r4.xyzz, a0
bdaaaaaaabaaaeacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r1.z, a0, c2
bcaaaaaaadaaacaeaaaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v3.y, r0.xyzz, r2.xyzz
bcaaaaaaaeaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v4.y, r2.xyzz, r3.xyzz
bdaaaaaaacaaadacaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 r2.xy, a0, c1
aaaaaaaaabaaacacacaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r1.y, r2.y
bcaaaaaaadaaaeaeabaaaaoeaaaaaaaaaaaaaakeacaaaaaa dp3 v3.z, a1, r0.xyzz
bcaaaaaaadaaabaeaaaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v3.x, r0.xyzz, a5
bdaaaaaaaaaaadacaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 r0.xy, a0, c3
aaaaaaaaabaaaiacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r1.w, r0.y
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 r0.z, a0, c0
aaaaaaaaabaaabacaaaaaakkacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r0.z
bfaaaaaaaaaaaiacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r0.w, r2.x
abaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaapoacaaaaaa add r0.xy, r0.x, r0.zwww
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
aaaaaaaaabaaapaeabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov v1, r1
aaaaaaaaacaaamaeabaaaaopacaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, r1.wwzw
bdaaaaaaabaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r1.w, a0, c7
bdaaaaaaabaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r1.z, a0, c6
bdaaaaaaabaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r1.x, a0, c4
bdaaaaaaabaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r1.y, a0, c5
bcaaaaaaaeaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v4.z, a1, r3.xyzz
bcaaaaaaaeaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v4.x, a5, r3.xyzz
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
bdaaaaaaafaaaeaeabaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 v5.z, r1, c14
bdaaaaaaafaaacaeabaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 v5.y, r1, c13
bdaaaaaaafaaabaeabaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 v5.x, r1, c12
adaaaaaaacaaadaeaaaaaafeacaaaaaabeaaaaaaabaaaaaa mul v2.xy, r0.xyyy, c20.x
adaaaaaaaaaaadacadaaaaoeaaaaaaaabdaaaaoeabaaaaaa mul r0.xy, a3, c19
abaaaaaaaaaaadaeaaaaaafeacaaaaaabdaaaaooabaaaaaa add v0.xy, r0.xyyy, c19.zwzw
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
aaaaaaaaafaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v5.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 20 [_MainTex_ST]
"!!ARBvp1.0
# 41 ALU
PARAM c[21] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.w, c[0].y;
MOV R1.xyz, c[18];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R0.z, vertex.position, c[3];
DP3 result.texcoord[4].y, R1, R2;
DP3 result.texcoord[3].y, R3, R1;
DP4 R1.xy, vertex.position, c[4];
MOV R0.w, R1.y;
DP4 R1.z, vertex.position, c[1];
MOV R0.x, R1.z;
MOV result.texcoord[2].zw, R0;
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
DP4 R2.xy, vertex.position, c[2];
MOV R0.y, R2;
MOV R1.w, R2.x;
ADD R1.xy, R1.x, R1.zwzw;
MOV result.position, R0;
MOV result.texcoord[1], R0;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[3].z, vertex.normal, R3;
DP3 result.texcoord[3].x, R3, vertex.attrib[14];
MOV result.color, vertex.color;
DP4 result.texcoord[5].y, R0, c[14];
DP4 result.texcoord[5].x, R0, c[13];
MUL result.texcoord[2].xy, R1, c[0].x;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
END
# 41 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
"vs_2_0
; 44 ALU
def c20, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
mov r0.w, c20.y
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r1, c8
dp4 r4.x, c18, r1
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
dp4 r0.xy, v0, c3
dp4 r0.z, v0, c0
mov r1.w, r0.y
dp4 r1.z, v0, c2
mov r1.x, r0.z
mov oT2.zw, r1
dp3 oT3.y, r4, r2
dp3 oT4.y, r2, r3
dp4 r2.xy, v0, c1
mov r1.y, r2
mov r0.w, -r2.x
add r0.xy, r0.x, r0.zwzw
mov oPos, r1
mov oT1, r1
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
dp3 oT3.z, v2, r4
dp3 oT3.x, r4, v1
dp3 oT4.z, v2, r3
dp3 oT4.x, v1, r3
mov oD0, v4
dp4 oT5.y, r1, c13
dp4 oT5.x, r1, c12
mul oT2.xy, r0, c20.x
mad oT0.xy, v3, c19, c19.zwzw
"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
"agal_vs
c20 0.5 1.0 0.0 0.0
[bc]
aaaaaaaaaaaaaiacbeaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c20.y
aaaaaaaaaaaaahacbbaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c17
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r1.z, r0, c10
bdaaaaaaabaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r1.y, r0, c9
bdaaaaaaabaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r1.x, r0, c8
adaaaaaaacaaahacabaaaakeacaaaaaabaaaaappabaaaaaa mul r2.xyz, r1.xyzz, c16.w
acaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r2.xyzz, a0
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaaaaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r0.yzxx
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaaeaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r4.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacaeaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r4.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaabaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c8
bdaaaaaaaeaaabacbcaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.x, c18, r1
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaaeaaaeacbcaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c18, r0
aaaaaaaaaaaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c9
bdaaaaaaaeaaacacbcaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.y, c18, r0
bdaaaaaaaaaaadacaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 r0.xy, a0, c3
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 r0.z, a0, c0
aaaaaaaaabaaaiacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r1.w, r0.y
bdaaaaaaabaaaeacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r1.z, a0, c2
aaaaaaaaabaaabacaaaaaakkacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r0.z
aaaaaaaaacaaamaeabaaaaopacaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, r1.wwzw
bcaaaaaaadaaacaeaeaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v3.y, r4.xyzz, r2.xyzz
bcaaaaaaaeaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v4.y, r2.xyzz, r3.xyzz
bdaaaaaaacaaadacaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 r2.xy, a0, c1
aaaaaaaaabaaacacacaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r1.y, r2.y
bfaaaaaaaaaaaiacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r0.w, r2.x
abaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaapoacaaaaaa add r0.xy, r0.x, r0.zwww
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
aaaaaaaaabaaapaeabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov v1, r1
bdaaaaaaabaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r1.w, a0, c7
bdaaaaaaabaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r1.z, a0, c6
bdaaaaaaabaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r1.x, a0, c4
bdaaaaaaabaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r1.y, a0, c5
bcaaaaaaadaaaeaeabaaaaoeaaaaaaaaaeaaaakeacaaaaaa dp3 v3.z, a1, r4.xyzz
bcaaaaaaadaaabaeaeaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v3.x, r4.xyzz, a5
bcaaaaaaaeaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v4.z, a1, r3.xyzz
bcaaaaaaaeaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v4.x, a5, r3.xyzz
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
bdaaaaaaafaaacaeabaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 v5.y, r1, c13
bdaaaaaaafaaabaeabaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 v5.x, r1, c12
adaaaaaaacaaadaeaaaaaafeacaaaaaabeaaaaaaabaaaaaa mul v2.xy, r0.xyyy, c20.x
adaaaaaaaaaaadacadaaaaoeaaaaaaaabdaaaaoeabaaaaaa mul r0.xy, a3, c19
abaaaaaaaaaaadaeaaaaaafeacaaaaaabdaaaaooabaaaaaa add v0.xy, r0.xyyy, c19.zwzw
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
aaaaaaaaafaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v5.zw, c0
"
}

}
Program "fp" {
// Fragment combos: 5
//   opengl - ALU: 41 to 55, TEX: 4 to 6
//   d3d9 - ALU: 41 to 55, TEX: 4 to 6
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Vector 3 [_GrabTexture_TexelSize]
Float 4 [_Focus]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
SetTexture 4 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 50 ALU, 5 TEX
PARAM c[8] = { program.local[0..5],
		{ 2, 1, 0, 250 },
		{ 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.yw, fragment.texcoord[0], texture[1], 2D;
MAD R3.xy, R0.wyzw, c[6].x, -c[6].y;
MUL R0.xy, R3, c[3];
MUL R0.xy, R0, c[4].x;
MAD R1.xy, R0, fragment.texcoord[2].z, fragment.texcoord[2];
MOV R1.z, fragment.texcoord[2].w;
MUL R2.w, R3.y, R3.y;
MAD R2.w, -R3.x, R3.x, -R2;
DP3 R1.w, fragment.texcoord[5], fragment.texcoord[5];
DP3 R3.z, fragment.texcoord[3], fragment.texcoord[3];
RSQ R3.z, R3.z;
MUL R4.xyz, R3.z, fragment.texcoord[3];
DP3 R3.w, R4, R4;
RSQ R3.w, R3.w;
MUL R4.xyz, R3.w, R4;
ADD R2.w, R2, c[6].y;
RSQ R2.w, R2.w;
RCP R3.z, R2.w;
DP3 R2.w, R3, R3;
RSQ R2.w, R2.w;
MUL R3.xyz, R2.w, R3;
DP3 R2.w, R3, R4;
MUL R3.xyz, R2.w, R3;
DP3 R3.w, fragment.texcoord[4], fragment.texcoord[4];
MAD R4.xyz, -R3, c[6].x, R4;
RSQ R3.w, R3.w;
MUL R3.xyz, R3.w, fragment.texcoord[4];
DP3 R3.y, -R3, R4;
MOV R3.x, c[7];
TXP R2.xyz, R1.xyzz, texture[3], 2D;
TEX R1.xyz, fragment.texcoord[0], texture[2], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.w, R1.w, texture[4], 2D;
MUL R1.y, R1, c[5].x;
MAD R3.x, R1.y, c[6].w, R3;
MAX R1.y, R3, c[6].z;
POW R1.y, R1.y, R3.x;
MUL R2.xyz, R2, c[1];
MUL R3.xyz, fragment.color.primary, R0;
MAD R0.xyz, -fragment.color.primary, R0, R2;
MAD R0.xyz, R1.z, R0, R3;
MUL R1.x, R1, R1.y;
MUL R1.xyz, R1.x, c[2];
MAX R2.x, R2.w, c[6].z;
MAD R0.xyz, R0, R2.x, R1;
MUL R0.xyz, R0, c[0];
MUL R1.xyz, R1.w, R0;
MUL R0.x, fragment.color.primary.w, c[1].w;
MUL result.color.xyz, R1, c[6].x;
MUL result.color.w, R0.x, R0;
END
# 50 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Vector 3 [_GrabTexture_TexelSize]
Float 4 [_Focus]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
SetTexture 4 [_LightTexture0] 2D
"ps_2_0
; 50 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c6, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c7, 250.00000000, 4.00000000, 0, 0
dcl t0.xy
dcl v0
dcl t2
dcl t3.xyz
dcl t4.xyz
dcl t5.xyz
texld r0, t0, s1
texld r3, t0, s0
texld r5, t0, s2
mov r0.x, r0.w
mad_pp r2.xy, r0, c6.x, c6.y
mul_pp r0.xy, r2, c3
mul_pp r0.xy, r0, c4.x
mad r1.xy, r0, t2.z, t2
mov r1.zw, t2
dp3 r0.x, t5, t5
mov r0.xy, r0.x
texldp r4, r1, s3
texld r7, r0, s4
mul_pp r0.x, r2.y, r2.y
mad_pp r0.x, -r2, r2, -r0
dp3_pp r1.x, t3, t3
rsq_pp r1.x, r1.x
mul_pp r6.xyz, r1.x, t3
dp3_pp r1.x, r6, r6
add_pp r0.x, r0, c6.z
rsq_pp r0.x, r0.x
rcp_pp r2.z, r0.x
dp3_pp r0.x, r2, r2
rsq_pp r0.x, r0.x
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, r6
mul_pp r2.xyz, r0.x, r2
dp3_pp r0.x, r2, r1
mul_pp r2.xyz, r0.x, r2
mad_pp r6.xyz, -r2, c6.x, r1
dp3_pp r1.x, t4, t4
rsq_pp r2.x, r1.x
mul_pp r2.xyz, r2.x, t4
dp3_pp r2.x, -r2, r6
mul_pp r1.x, r5.y, c5
mad_pp r1.x, r1, c7, c7.y
max_pp r2.x, r2, c6.w
pow_pp r6.x, r2.x, r1.x
mul_pp r2.xyz, r4, c1
mov_pp r1.x, r6.x
mul_pp r1.x, r5, r1
mul_pp r1.xyz, r1.x, c2
mul r4.xyz, v0, r3
mad r2.xyz, -v0, r3, r2
mad r2.xyz, r5.z, r2, r4
max_pp r0.x, r0, c6.w
mad_pp r0.xyz, r2, r0.x, r1
mul_pp r0.xyz, r0, c0
mul_pp r1.xyz, r7.x, r0
mul r0.x, v0.w, c1.w
mul_pp r1.xyz, r1, c6.x
mul r1.w, r0.x, r3
mov_pp oC0, r1
"
}

SubProgram "flash " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Vector 3 [_GrabTexture_TexelSize]
Float 4 [_Focus]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
SetTexture 4 [_LightTexture0] 2D
"agal_ps
c6 2.0 -1.0 1.0 0.0
c7 250.0 4.0 0.0 0.0
[bc]
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r0, v0, s1 <2d wrap linear point>
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
ciaaaaaaafaaapacaaaaaaoeaeaaaaaaacaaaaaaafaababb tex r5, v0, s2 <2d wrap linear point>
aaaaaaaaaaaaabacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r0.w
adaaaaaaacaaadacaaaaaafeacaaaaaaagaaaaaaabaaaaaa mul r2.xy, r0.xyyy, c6.x
abaaaaaaacaaadacacaaaafeacaaaaaaagaaaaffabaaaaaa add r2.xy, r2.xyyy, c6.y
adaaaaaaaaaaadacacaaaafeacaaaaaaadaaaaoeabaaaaaa mul r0.xy, r2.xyyy, c3
adaaaaaaaaaaadacaaaaaafeacaaaaaaaeaaaaaaabaaaaaa mul r0.xy, r0.xyyy, c4.x
adaaaaaaabaaadacaaaaaafeacaaaaaaacaaaakkaeaaaaaa mul r1.xy, r0.xyyy, v2.z
abaaaaaaabaaadacabaaaafeacaaaaaaacaaaaoeaeaaaaaa add r1.xy, r1.xyyy, v2
aaaaaaaaabaaamacacaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r1.zw, v2
bcaaaaaaaaaaabacafaaaaoeaeaaaaaaafaaaaoeaeaaaaaa dp3 r0.x, v5, v5
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
aeaaaaaaaeaaapacabaaaaoeacaaaaaaabaaaappacaaaaaa div r4, r1, r1.w
ciaaaaaaaeaaapacaeaaaafeacaaaaaaadaaaaaaafaababb tex r4, r4.xyyy, s3 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaafeacaaaaaaaeaaaaaaafaababb tex r0, r0.xyyy, s4 <2d wrap linear point>
adaaaaaaaaaaabacacaaaaffacaaaaaaacaaaaffacaaaaaa mul r0.x, r2.y, r2.y
bfaaaaaaacaaaiacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r2.w, r2.x
adaaaaaaacaaaiacacaaaappacaaaaaaacaaaaaaacaaaaaa mul r2.w, r2.w, r2.x
acaaaaaaaaaaabacacaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r2.w, r0.x
bcaaaaaaabaaabacadaaaaoeaeaaaaaaadaaaaoeaeaaaaaa dp3 r1.x, v3, v3
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
adaaaaaaagaaahacabaaaaaaacaaaaaaadaaaaoeaeaaaaaa mul r6.xyz, r1.x, v3
bcaaaaaaabaaabacagaaaakeacaaaaaaagaaaakeacaaaaaa dp3 r1.x, r6.xyzz, r6.xyzz
abaaaaaaaaaaabacaaaaaaaaacaaaaaaagaaaakkabaaaaaa add r0.x, r0.x, c6.z
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
afaaaaaaacaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r2.z, r0.x
bcaaaaaaaaaaabacacaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r0.x, r2.xyzz, r2.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
adaaaaaaabaaahacabaaaaaaacaaaaaaagaaaakeacaaaaaa mul r1.xyz, r1.x, r6.xyzz
adaaaaaaacaaahacaaaaaaaaacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r0.x, r2.xyzz
bcaaaaaaaaaaabacacaaaakeacaaaaaaabaaaakeacaaaaaa dp3 r0.x, r2.xyzz, r1.xyzz
adaaaaaaacaaahacaaaaaaaaacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r0.x, r2.xyzz
bfaaaaaaagaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r6.xyz, r2.xyzz
adaaaaaaagaaahacagaaaakeacaaaaaaagaaaaaaabaaaaaa mul r6.xyz, r6.xyzz, c6.x
abaaaaaaagaaahacagaaaakeacaaaaaaabaaaakeacaaaaaa add r6.xyz, r6.xyzz, r1.xyzz
bcaaaaaaabaaabacaeaaaaoeaeaaaaaaaeaaaaoeaeaaaaaa dp3 r1.x, v4, v4
akaaaaaaacaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r2.x, r1.x
adaaaaaaacaaahacacaaaaaaacaaaaaaaeaaaaoeaeaaaaaa mul r2.xyz, r2.x, v4
bfaaaaaaahaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r7.xyz, r2.xyzz
bcaaaaaaacaaabacahaaaakeacaaaaaaagaaaakeacaaaaaa dp3 r2.x, r7.xyzz, r6.xyzz
adaaaaaaabaaabacafaaaaffacaaaaaaafaaaaoeabaaaaaa mul r1.x, r5.y, c5
adaaaaaaabaaabacabaaaaaaacaaaaaaahaaaaoeabaaaaaa mul r1.x, r1.x, c7
abaaaaaaabaaabacabaaaaaaacaaaaaaahaaaaffabaaaaaa add r1.x, r1.x, c7.y
ahaaaaaaacaaabacacaaaaaaacaaaaaaagaaaappabaaaaaa max r2.x, r2.x, c6.w
alaaaaaaagaaapacacaaaaaaacaaaaaaabaaaaaaacaaaaaa pow r6, r2.x, r1.x
adaaaaaaacaaahacaeaaaakeacaaaaaaabaaaaoeabaaaaaa mul r2.xyz, r4.xyzz, c1
aaaaaaaaabaaabacagaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r6.x
adaaaaaaabaaabacafaaaaaaacaaaaaaabaaaaaaacaaaaaa mul r1.x, r5.x, r1.x
adaaaaaaabaaahacabaaaaaaacaaaaaaacaaaaoeabaaaaaa mul r1.xyz, r1.x, c2
adaaaaaaaeaaahacahaaaaoeaeaaaaaaadaaaakeacaaaaaa mul r4.xyz, v7, r3.xyzz
bfaaaaaaahaaahacahaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa neg r7.xyz, v7
adaaaaaaahaaahacahaaaakeacaaaaaaadaaaakeacaaaaaa mul r7.xyz, r7.xyzz, r3.xyzz
abaaaaaaacaaahacahaaaakeacaaaaaaacaaaakeacaaaaaa add r2.xyz, r7.xyzz, r2.xyzz
adaaaaaaacaaahacafaaaakkacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r5.z, r2.xyzz
abaaaaaaacaaahacacaaaakeacaaaaaaaeaaaakeacaaaaaa add r2.xyz, r2.xyzz, r4.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaagaaaappabaaaaaa max r0.x, r0.x, c6.w
adaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r0.xyz, r2.xyzz, r0.x
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r0.xyz, r0.xyzz, c0
adaaaaaaabaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r1.xyz, r0.w, r0.xyzz
adaaaaaaaaaaabacahaaaappaeaaaaaaabaaaappabaaaaaa mul r0.x, v7.w, c1.w
adaaaaaaabaaahacabaaaakeacaaaaaaagaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c6.x
adaaaaaaabaaaiacaaaaaaaaacaaaaaaadaaaappacaaaaaa mul r1.w, r0.x, r3.w
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Vector 3 [_GrabTexture_TexelSize]
Float 4 [_Focus]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 41 ALU, 4 TEX
PARAM c[8] = { program.local[0..5],
		{ 2, 1, 0, 250 },
		{ 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.yw, fragment.texcoord[0], texture[1], 2D;
MAD R3.xy, R0.wyzw, c[6].x, -c[6].y;
MUL R0.xy, R3, c[3];
MUL R0.xy, R0, c[4].x;
MAD R1.xy, R0, fragment.texcoord[2].z, fragment.texcoord[2];
MOV R1.z, fragment.texcoord[2].w;
MUL R1.w, R3.y, R3.y;
MAD R1.w, -R3.x, R3.x, -R1;
ADD R1.w, R1, c[6].y;
RSQ R1.w, R1.w;
RCP R3.z, R1.w;
DP3 R1.w, R3, R3;
RSQ R1.w, R1.w;
MUL R3.xyz, R1.w, R3;
DP3 R1.w, R3, fragment.texcoord[3];
MUL R3.xyz, R1.w, R3;
DP3 R2.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R2.w, R2.w;
MAD R4.xyz, -R3, c[6].x, fragment.texcoord[3];
MUL R3.xyz, R2.w, fragment.texcoord[4];
DP3 R3.x, -R3, R4;
MOV R2.w, c[7].x;
TXP R2.xyz, R1.xyzz, texture[3], 2D;
TEX R1.xyz, fragment.texcoord[0], texture[2], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1.y, R1, c[5].x;
MAD R2.w, R1.y, c[6], R2;
MAX R1.y, R3.x, c[6].z;
POW R1.y, R1.y, R2.w;
MUL R1.x, R1, R1.y;
MUL R2.xyz, R2, c[1];
MUL R3.xyz, fragment.color.primary, R0;
MAD R0.xyz, -fragment.color.primary, R0, R2;
MUL R2.xyz, R1.x, c[2];
MAD R0.xyz, R1.z, R0, R3;
MAX R1.x, R1.w, c[6].z;
MAD R0.xyz, R0, R1.x, R2;
MUL R1.xyz, R0, c[0];
MUL R0.x, fragment.color.primary.w, c[1].w;
MUL result.color.xyz, R1, c[6].x;
MUL result.color.w, R0.x, R0;
END
# 41 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Vector 3 [_GrabTexture_TexelSize]
Float 4 [_Focus]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
"ps_2_0
; 41 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c6, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c7, 250.00000000, 4.00000000, 0, 0
dcl t0.xy
dcl v0
dcl t2
dcl t3.xyz
dcl t4.xyz
texld r0, t0, s1
texld r3, t0, s0
texld r5, t0, s2
mov r0.x, r0.w
mad_pp r1.xy, r0, c6.x, c6.y
mul_pp r0.xy, r1, c3
mul_pp r0.xy, r0, c4.x
mad r0.xy, r0, t2.z, t2
mov r0.zw, t2
texldp r4, r0, s3
mul_pp r0.x, r1.y, r1.y
mad_pp r0.x, -r1, r1, -r0
add_pp r0.x, r0, c6.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
dp3_pp r0.x, r1, r1
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r1
dp3_pp r0.x, r1, t3
mul_pp r1.xyz, r0.x, r1
mad_pp r6.xyz, -r1, c6.x, t3
dp3_pp r1.x, t4, t4
rsq_pp r2.x, r1.x
mul_pp r2.xyz, r2.x, t4
dp3_pp r2.x, -r2, r6
mul_pp r1.x, r5.y, c5
mad_pp r1.x, r1, c7, c7.y
max_pp r2.x, r2, c6.w
pow_pp r6.x, r2.x, r1.x
mul_pp r2.xyz, r4, c1
mov_pp r1.x, r6.x
mul_pp r1.x, r5, r1
mul_pp r1.xyz, r1.x, c2
mul r4.xyz, v0, r3
mad r2.xyz, -v0, r3, r2
mad r2.xyz, r5.z, r2, r4
max_pp r0.x, r0, c6.w
mad_pp r0.xyz, r2, r0.x, r1
mul_pp r1.xyz, r0, c0
mul r0.x, v0.w, c1.w
mul_pp r1.xyz, r1, c6.x
mul r1.w, r0.x, r3
mov_pp oC0, r1
"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Vector 3 [_GrabTexture_TexelSize]
Float 4 [_Focus]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
"agal_ps
c6 2.0 -1.0 1.0 0.0
c7 250.0 4.0 0.0 0.0
[bc]
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r0, v0, s1 <2d wrap linear point>
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
ciaaaaaaafaaapacaaaaaaoeaeaaaaaaacaaaaaaafaababb tex r5, v0, s2 <2d wrap linear point>
aaaaaaaaaaaaabacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r0.w
adaaaaaaabaaadacaaaaaafeacaaaaaaagaaaaaaabaaaaaa mul r1.xy, r0.xyyy, c6.x
abaaaaaaabaaadacabaaaafeacaaaaaaagaaaaffabaaaaaa add r1.xy, r1.xyyy, c6.y
adaaaaaaaaaaadacabaaaafeacaaaaaaadaaaaoeabaaaaaa mul r0.xy, r1.xyyy, c3
adaaaaaaaaaaadacaaaaaafeacaaaaaaaeaaaaaaabaaaaaa mul r0.xy, r0.xyyy, c4.x
adaaaaaaaaaaadacaaaaaafeacaaaaaaacaaaakkaeaaaaaa mul r0.xy, r0.xyyy, v2.z
abaaaaaaaaaaadacaaaaaafeacaaaaaaacaaaaoeaeaaaaaa add r0.xy, r0.xyyy, v2
aaaaaaaaaaaaamacacaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r0.zw, v2
aeaaaaaaacaaapacaaaaaaoeacaaaaaaaaaaaappacaaaaaa div r2, r0, r0.w
ciaaaaaaaeaaapacacaaaafeacaaaaaaadaaaaaaafaababb tex r4, r2.xyyy, s3 <2d wrap linear point>
adaaaaaaaaaaabacabaaaaffacaaaaaaabaaaaffacaaaaaa mul r0.x, r1.y, r1.y
bfaaaaaaacaaaiacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r2.w, r1.x
adaaaaaaacaaaiacacaaaappacaaaaaaabaaaaaaacaaaaaa mul r2.w, r2.w, r1.x
acaaaaaaaaaaabacacaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r2.w, r0.x
abaaaaaaaaaaabacaaaaaaaaacaaaaaaagaaaakkabaaaaaa add r0.x, r0.x, c6.z
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
afaaaaaaabaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r1.z, r0.x
bcaaaaaaaaaaabacabaaaakeacaaaaaaabaaaakeacaaaaaa dp3 r0.x, r1.xyzz, r1.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaabaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.x, r1.xyzz
bcaaaaaaaaaaabacabaaaakeacaaaaaaadaaaaoeaeaaaaaa dp3 r0.x, r1.xyzz, v3
adaaaaaaabaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.x, r1.xyzz
bfaaaaaaagaaahacabaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r6.xyz, r1.xyzz
adaaaaaaagaaahacagaaaakeacaaaaaaagaaaaaaabaaaaaa mul r6.xyz, r6.xyzz, c6.x
abaaaaaaagaaahacagaaaakeacaaaaaaadaaaaoeaeaaaaaa add r6.xyz, r6.xyzz, v3
bcaaaaaaabaaabacaeaaaaoeaeaaaaaaaeaaaaoeaeaaaaaa dp3 r1.x, v4, v4
akaaaaaaacaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r2.x, r1.x
adaaaaaaacaaahacacaaaaaaacaaaaaaaeaaaaoeaeaaaaaa mul r2.xyz, r2.x, v4
bfaaaaaaahaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r7.xyz, r2.xyzz
bcaaaaaaacaaabacahaaaakeacaaaaaaagaaaakeacaaaaaa dp3 r2.x, r7.xyzz, r6.xyzz
adaaaaaaabaaabacafaaaaffacaaaaaaafaaaaoeabaaaaaa mul r1.x, r5.y, c5
adaaaaaaabaaabacabaaaaaaacaaaaaaahaaaaoeabaaaaaa mul r1.x, r1.x, c7
abaaaaaaabaaabacabaaaaaaacaaaaaaahaaaaffabaaaaaa add r1.x, r1.x, c7.y
ahaaaaaaacaaabacacaaaaaaacaaaaaaagaaaappabaaaaaa max r2.x, r2.x, c6.w
alaaaaaaagaaapacacaaaaaaacaaaaaaabaaaaaaacaaaaaa pow r6, r2.x, r1.x
adaaaaaaacaaahacaeaaaakeacaaaaaaabaaaaoeabaaaaaa mul r2.xyz, r4.xyzz, c1
aaaaaaaaabaaabacagaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r6.x
adaaaaaaabaaabacafaaaaaaacaaaaaaabaaaaaaacaaaaaa mul r1.x, r5.x, r1.x
adaaaaaaabaaahacabaaaaaaacaaaaaaacaaaaoeabaaaaaa mul r1.xyz, r1.x, c2
adaaaaaaaeaaahacahaaaaoeaeaaaaaaadaaaakeacaaaaaa mul r4.xyz, v7, r3.xyzz
bfaaaaaaahaaahacahaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa neg r7.xyz, v7
adaaaaaaahaaahacahaaaakeacaaaaaaadaaaakeacaaaaaa mul r7.xyz, r7.xyzz, r3.xyzz
abaaaaaaacaaahacahaaaakeacaaaaaaacaaaakeacaaaaaa add r2.xyz, r7.xyzz, r2.xyzz
adaaaaaaacaaahacafaaaakkacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r5.z, r2.xyzz
abaaaaaaacaaahacacaaaakeacaaaaaaaeaaaakeacaaaaaa add r2.xyz, r2.xyzz, r4.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaagaaaappabaaaaaa max r0.x, r0.x, c6.w
adaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r0.xyz, r2.xyzz, r0.x
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaahacaaaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r0.xyzz, c0
adaaaaaaaaaaabacahaaaappaeaaaaaaabaaaappabaaaaaa mul r0.x, v7.w, c1.w
adaaaaaaabaaahacabaaaakeacaaaaaaagaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c6.x
adaaaaaaabaaaiacaaaaaaaaacaaaaaaadaaaappacaaaaaa mul r1.w, r0.x, r3.w
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Vector 3 [_GrabTexture_TexelSize]
Float 4 [_Focus]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
SetTexture 4 [_LightTexture0] 2D
SetTexture 5 [_LightTextureB0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 55 ALU, 6 TEX
PARAM c[8] = { program.local[0..5],
		{ 0, 0.5, 2, 1 },
		{ 250, 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.yw, fragment.texcoord[0], texture[1], 2D;
TEX R2, fragment.texcoord[0], texture[0], 2D;
MAD R3.xy, R0.wyzw, c[6].z, -c[6].w;
MUL R0.zw, R3.xyxy, c[3].xyxy;
RCP R0.x, fragment.texcoord[5].w;
DP3 R1.w, fragment.texcoord[5], fragment.texcoord[5];
MUL R0.zw, R0, c[4].x;
MAD R3.zw, fragment.texcoord[5].xyxy, R0.x, c[6].y;
MAD R0.xy, R0.zwzw, fragment.texcoord[2].z, fragment.texcoord[2];
MOV R0.z, fragment.texcoord[2].w;
TEX R0.w, R3.zwzw, texture[4], 2D;
TXP R1.xyz, R0.xyzz, texture[3], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[2], 2D;
TEX R1.w, R1.w, texture[5], 2D;
MUL R3.z, R3.y, R3.y;
MAD R3.z, -R3.x, R3.x, -R3;
DP3 R3.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R3.w, R3.w;
MUL R4.xyz, R3.w, fragment.texcoord[3];
DP3 R4.w, R4, R4;
RSQ R4.w, R4.w;
MUL R4.xyz, R4.w, R4;
ADD R3.z, R3, c[6].w;
RSQ R3.z, R3.z;
RCP R3.z, R3.z;
DP3 R3.w, R3, R3;
RSQ R3.w, R3.w;
MUL R3.xyz, R3.w, R3;
DP3 R3.w, R3, R4;
MUL R3.xyz, R3.w, R3;
MUL R1.xyz, R1, c[1];
MAD R3.xyz, -R3, c[6].z, R4;
DP3 R4.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R4.x, R4.w;
MUL R4.xyz, R4.x, fragment.texcoord[4];
DP3 R3.x, -R4, R3;
MUL R0.y, R0, c[5].x;
MAD R3.y, R0, c[7].x, c[7];
MAX R0.y, R3.x, c[6].x;
POW R0.y, R0.y, R3.y;
MUL R3.xyz, fragment.color.primary, R2;
MAD R1.xyz, -fragment.color.primary, R2, R1;
MAD R1.xyz, R0.z, R1, R3;
MUL R0.x, R0, R0.y;
MUL R0.xyz, R0.x, c[2];
MAX R2.x, R3.w, c[6];
MAD R0.xyz, R1, R2.x, R0;
MUL R1.xyz, R0, c[0];
SLT R0.x, c[6], fragment.texcoord[5].z;
MUL R0.x, R0, R0.w;
MUL R0.x, R0, R1.w;
MUL R1.xyz, R0.x, R1;
MUL R0.x, fragment.color.primary.w, c[1].w;
MUL result.color.xyz, R1, c[6].z;
MUL result.color.w, R0.x, R2;
END
# 55 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Vector 3 [_GrabTexture_TexelSize]
Float 4 [_Focus]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
SetTexture 4 [_LightTexture0] 2D
SetTexture 5 [_LightTextureB0] 2D
"ps_2_0
; 55 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c6, 0.00000000, 1.00000000, 0.50000000, 2.00000000
def c7, 2.00000000, -1.00000000, 250.00000000, 4.00000000
dcl t0.xy
dcl v0
dcl t2
dcl t3.xyz
dcl t4.xyz
dcl t5
texld r0, t0, s1
texld r5, t0, s2
mov r0.x, r0.w
mad_pp r2.xy, r0, c7.x, c7.y
mul_pp r0.xy, r2, c3
mul_pp r1.xy, r0, c4.x
mad r3.xy, r1, t2.z, t2
dp3 r0.x, t5, t5
mov r1.xy, r0.x
mov r3.zw, t2
rcp r0.x, t5.w
mad r0.xy, t5, r0.x, c6.z
texld r7, r1, s5
texldp r4, r3, s3
texld r0, r0, s4
texld r3, t0, s0
mul_pp r0.x, r2.y, r2.y
mad_pp r0.x, -r2, r2, -r0
dp3_pp r1.x, t3, t3
rsq_pp r1.x, r1.x
mul_pp r6.xyz, r1.x, t3
dp3_pp r1.x, r6, r6
add_pp r0.x, r0, c6.y
rsq_pp r0.x, r0.x
rcp_pp r2.z, r0.x
dp3_pp r0.x, r2, r2
rsq_pp r0.x, r0.x
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, r6
mul_pp r2.xyz, r0.x, r2
dp3_pp r0.x, r2, r1
mul_pp r2.xyz, r0.x, r2
mad_pp r6.xyz, -r2, c6.w, r1
dp3_pp r1.x, t4, t4
rsq_pp r2.x, r1.x
mul_pp r2.xyz, r2.x, t4
dp3_pp r2.x, -r2, r6
mul_pp r1.x, r5.y, c5
mad_pp r1.x, r1, c7.z, c7.w
max_pp r2.x, r2, c6
pow_pp r6.x, r2.x, r1.x
mul_pp r2.xyz, r4, c1
mov_pp r1.x, r6.x
mul_pp r1.x, r5, r1
mul_pp r1.xyz, r1.x, c2
mul r4.xyz, v0, r3
mad r2.xyz, -v0, r3, r2
mad r2.xyz, r5.z, r2, r4
max_pp r0.x, r0, c6
mad_pp r0.xyz, r2, r0.x, r1
mul_pp r1.xyz, r0, c0
cmp r0.x, -t5.z, c6, c6.y
mul_pp r0.x, r0, r0.w
mul_pp r0.x, r0, r7
mul_pp r1.xyz, r0.x, r1
mul r0.x, v0.w, c1.w
mul_pp r1.xyz, r1, c6.w
mul r1.w, r0.x, r3
mov_pp oC0, r1
"
}

SubProgram "flash " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Vector 3 [_GrabTexture_TexelSize]
Float 4 [_Focus]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
SetTexture 4 [_LightTexture0] 2D
SetTexture 5 [_LightTextureB0] 2D
"agal_ps
c6 0.0 1.0 0.5 2.0
c7 2.0 -1.0 250.0 4.0
[bc]
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r0, v0, s1 <2d wrap linear point>
ciaaaaaaafaaapacaaaaaaoeaeaaaaaaacaaaaaaafaababb tex r5, v0, s2 <2d wrap linear point>
aaaaaaaaaaaaabacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r0.w
adaaaaaaacaaadacaaaaaafeacaaaaaaahaaaaaaabaaaaaa mul r2.xy, r0.xyyy, c7.x
abaaaaaaacaaadacacaaaafeacaaaaaaahaaaaffabaaaaaa add r2.xy, r2.xyyy, c7.y
adaaaaaaaaaaadacacaaaafeacaaaaaaadaaaaoeabaaaaaa mul r0.xy, r2.xyyy, c3
adaaaaaaabaaadacaaaaaafeacaaaaaaaeaaaaaaabaaaaaa mul r1.xy, r0.xyyy, c4.x
bcaaaaaaaaaaabacafaaaaoeaeaaaaaaafaaaaoeaeaaaaaa dp3 r0.x, v5, v5
aaaaaaaaadaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r3.xy, r0.x
afaaaaaaaaaaabacafaaaappaeaaaaaaaaaaaaaaaaaaaaaa rcp r0.x, v5.w
adaaaaaaabaaadacabaaaafeacaaaaaaacaaaakkaeaaaaaa mul r1.xy, r1.xyyy, v2.z
abaaaaaaabaaadacabaaaafeacaaaaaaacaaaaoeaeaaaaaa add r1.xy, r1.xyyy, v2
aaaaaaaaabaaamacacaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r1.zw, v2
adaaaaaaaaaaadacafaaaaoeaeaaaaaaaaaaaaaaacaaaaaa mul r0.xy, v5, r0.x
abaaaaaaaaaaadacaaaaaafeacaaaaaaagaaaakkabaaaaaa add r0.xy, r0.xyyy, c6.z
aeaaaaaaaeaaapacabaaaaoeacaaaaaaabaaaappacaaaaaa div r4, r1, r1.w
ciaaaaaaaeaaapacaeaaaafeacaaaaaaadaaaaaaafaababb tex r4, r4.xyyy, s3 <2d wrap linear point>
ciaaaaaaabaaapacaaaaaafeacaaaaaaaeaaaaaaafaababb tex r1, r0.xyyy, s4 <2d wrap linear point>
ciaaaaaaaaaaapacadaaaafeacaaaaaaafaaaaaaafaababb tex r0, r3.xyyy, s5 <2d wrap linear point>
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
adaaaaaaaaaaabacacaaaaffacaaaaaaacaaaaffacaaaaaa mul r0.x, r2.y, r2.y
bfaaaaaaacaaaiacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r2.w, r2.x
adaaaaaaacaaaiacacaaaappacaaaaaaacaaaaaaacaaaaaa mul r2.w, r2.w, r2.x
acaaaaaaaaaaabacacaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r2.w, r0.x
bcaaaaaaabaaabacadaaaaoeaeaaaaaaadaaaaoeaeaaaaaa dp3 r1.x, v3, v3
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
adaaaaaaagaaahacabaaaaaaacaaaaaaadaaaaoeaeaaaaaa mul r6.xyz, r1.x, v3
bcaaaaaaabaaabacagaaaakeacaaaaaaagaaaakeacaaaaaa dp3 r1.x, r6.xyzz, r6.xyzz
abaaaaaaaaaaabacaaaaaaaaacaaaaaaagaaaaffabaaaaaa add r0.x, r0.x, c6.y
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
afaaaaaaacaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r2.z, r0.x
bcaaaaaaaaaaabacacaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r0.x, r2.xyzz, r2.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
adaaaaaaabaaahacabaaaaaaacaaaaaaagaaaakeacaaaaaa mul r1.xyz, r1.x, r6.xyzz
adaaaaaaacaaahacaaaaaaaaacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r0.x, r2.xyzz
bcaaaaaaaaaaabacacaaaakeacaaaaaaabaaaakeacaaaaaa dp3 r0.x, r2.xyzz, r1.xyzz
adaaaaaaacaaahacaaaaaaaaacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r0.x, r2.xyzz
bfaaaaaaagaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r6.xyz, r2.xyzz
adaaaaaaagaaahacagaaaakeacaaaaaaagaaaappabaaaaaa mul r6.xyz, r6.xyzz, c6.w
abaaaaaaagaaahacagaaaakeacaaaaaaabaaaakeacaaaaaa add r6.xyz, r6.xyzz, r1.xyzz
bcaaaaaaabaaabacaeaaaaoeaeaaaaaaaeaaaaoeaeaaaaaa dp3 r1.x, v4, v4
akaaaaaaacaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r2.x, r1.x
adaaaaaaacaaahacacaaaaaaacaaaaaaaeaaaaoeaeaaaaaa mul r2.xyz, r2.x, v4
bfaaaaaaahaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r7.xyz, r2.xyzz
bcaaaaaaacaaabacahaaaakeacaaaaaaagaaaakeacaaaaaa dp3 r2.x, r7.xyzz, r6.xyzz
adaaaaaaabaaabacafaaaaffacaaaaaaafaaaaoeabaaaaaa mul r1.x, r5.y, c5
adaaaaaaabaaabacabaaaaaaacaaaaaaahaaaakkabaaaaaa mul r1.x, r1.x, c7.z
abaaaaaaabaaabacabaaaaaaacaaaaaaahaaaappabaaaaaa add r1.x, r1.x, c7.w
ahaaaaaaacaaabacacaaaaaaacaaaaaaagaaaaoeabaaaaaa max r2.x, r2.x, c6
alaaaaaaagaaapacacaaaaaaacaaaaaaabaaaaaaacaaaaaa pow r6, r2.x, r1.x
adaaaaaaacaaahacaeaaaakeacaaaaaaabaaaaoeabaaaaaa mul r2.xyz, r4.xyzz, c1
aaaaaaaaabaaabacagaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r6.x
adaaaaaaabaaabacafaaaaaaacaaaaaaabaaaaaaacaaaaaa mul r1.x, r5.x, r1.x
adaaaaaaabaaahacabaaaaaaacaaaaaaacaaaaoeabaaaaaa mul r1.xyz, r1.x, c2
adaaaaaaaeaaahacahaaaaoeaeaaaaaaadaaaakeacaaaaaa mul r4.xyz, v7, r3.xyzz
bfaaaaaaahaaahacahaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa neg r7.xyz, v7
adaaaaaaahaaahacahaaaakeacaaaaaaadaaaakeacaaaaaa mul r7.xyz, r7.xyzz, r3.xyzz
abaaaaaaacaaahacahaaaakeacaaaaaaacaaaakeacaaaaaa add r2.xyz, r7.xyzz, r2.xyzz
adaaaaaaacaaahacafaaaakkacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r5.z, r2.xyzz
abaaaaaaacaaahacacaaaakeacaaaaaaaeaaaakeacaaaaaa add r2.xyz, r2.xyzz, r4.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaagaaaaoeabaaaaaa max r0.x, r0.x, c6
adaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r0.xyz, r2.xyzz, r0.x
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaahacaaaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r0.xyzz, c0
bfaaaaaaahaaaeacafaaaakkaeaaaaaaaaaaaaaaaaaaaaaa neg r7.z, v5.z
ckaaaaaaaaaaabacahaaaakkacaaaaaaagaaaaaaabaaaaaa slt r0.x, r7.z, c6.x
adaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaappacaaaaaa mul r0.x, r0.x, r1.w
adaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaappacaaaaaa mul r0.x, r0.x, r0.w
adaaaaaaabaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.x, r1.xyzz
adaaaaaaaaaaabacahaaaappaeaaaaaaabaaaappabaaaaaa mul r0.x, v7.w, c1.w
adaaaaaaabaaahacabaaaakeacaaaaaaagaaaappabaaaaaa mul r1.xyz, r1.xyzz, c6.w
adaaaaaaabaaaiacaaaaaaaaacaaaaaaadaaaappacaaaaaa mul r1.w, r0.x, r3.w
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Vector 3 [_GrabTexture_TexelSize]
Float 4 [_Focus]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 52 ALU, 6 TEX
PARAM c[8] = { program.local[0..5],
		{ 2, 1, 0, 250 },
		{ 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.yw, fragment.texcoord[0], texture[1], 2D;
TEX R2, fragment.texcoord[0], texture[0], 2D;
TEX R1.w, fragment.texcoord[5], texture[5], CUBE;
MAD R3.xy, R0.wyzw, c[6].x, -c[6].y;
MUL R0.xy, R3, c[3];
MUL R3.z, R3.y, R3.y;
MAD R3.z, -R3.x, R3.x, -R3;
MUL R0.xy, R0, c[4].x;
DP3 R0.w, fragment.texcoord[5], fragment.texcoord[5];
DP3 R3.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R3.w, R3.w;
MUL R4.xyz, R3.w, fragment.texcoord[3];
DP3 R4.w, R4, R4;
RSQ R4.w, R4.w;
MUL R4.xyz, R4.w, R4;
ADD R3.z, R3, c[6].y;
RSQ R3.z, R3.z;
RCP R3.z, R3.z;
DP3 R3.w, R3, R3;
RSQ R3.w, R3.w;
MUL R3.xyz, R3.w, R3;
DP3 R3.w, R3, R4;
MUL R3.xyz, R3.w, R3;
DP3 R4.w, fragment.texcoord[4], fragment.texcoord[4];
MAD R0.xy, R0, fragment.texcoord[2].z, fragment.texcoord[2];
MOV R0.z, fragment.texcoord[2].w;
MAD R4.xyz, -R3, c[6].x, R4;
RSQ R4.w, R4.w;
MUL R3.xyz, R4.w, fragment.texcoord[4];
DP3 R3.y, -R3, R4;
MOV R3.x, c[7];
TXP R1.xyz, R0.xyzz, texture[3], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[2], 2D;
TEX R0.w, R0.w, texture[4], 2D;
MUL R0.y, R0, c[5].x;
MAD R3.x, R0.y, c[6].w, R3;
MAX R0.y, R3, c[6].z;
POW R0.y, R0.y, R3.x;
MUL R1.xyz, R1, c[1];
MUL R3.xyz, fragment.color.primary, R2;
MAD R1.xyz, -fragment.color.primary, R2, R1;
MAD R1.xyz, R0.z, R1, R3;
MUL R0.x, R0, R0.y;
MUL R0.xyz, R0.x, c[2];
MAX R2.x, R3.w, c[6].z;
MAD R0.xyz, R1, R2.x, R0;
MUL R1.xyz, R0, c[0];
MUL R0.x, R0.w, R1.w;
MUL R1.xyz, R0.x, R1;
MUL R0.x, fragment.color.primary.w, c[1].w;
MUL result.color.xyz, R1, c[6].x;
MUL result.color.w, R0.x, R2;
END
# 52 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Vector 3 [_GrabTexture_TexelSize]
Float 4 [_Focus]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
"ps_2_0
; 51 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_cube s5
def c6, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c7, 250.00000000, 4.00000000, 0, 0
dcl t0.xy
dcl v0
dcl t2
dcl t3.xyz
dcl t4.xyz
dcl t5.xyz
texld r0, t0, s1
texld r3, t0, s0
texld r5, t0, s2
mov r0.x, r0.w
mad_pp r2.xy, r0, c6.x, c6.y
mul_pp r0.xy, r2, c3
mul_pp r0.xy, r0, c4.x
mad r1.xy, r0, t2.z, t2
mov r1.zw, t2
dp3 r0.x, t5, t5
mov r0.xy, r0.x
texldp r4, r1, s3
texld r7, r0, s4
texld r0, t5, s5
mul_pp r0.x, r2.y, r2.y
mad_pp r0.x, -r2, r2, -r0
dp3_pp r1.x, t3, t3
rsq_pp r1.x, r1.x
mul_pp r6.xyz, r1.x, t3
dp3_pp r1.x, r6, r6
add_pp r0.x, r0, c6.z
rsq_pp r0.x, r0.x
rcp_pp r2.z, r0.x
dp3_pp r0.x, r2, r2
rsq_pp r0.x, r0.x
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, r6
mul_pp r2.xyz, r0.x, r2
dp3_pp r0.x, r2, r1
mul_pp r2.xyz, r0.x, r2
mad_pp r6.xyz, -r2, c6.x, r1
dp3_pp r1.x, t4, t4
rsq_pp r2.x, r1.x
mul_pp r2.xyz, r2.x, t4
dp3_pp r2.x, -r2, r6
mul_pp r1.x, r5.y, c5
mad_pp r1.x, r1, c7, c7.y
max_pp r2.x, r2, c6.w
pow_pp r6.x, r2.x, r1.x
mul_pp r2.xyz, r4, c1
mov_pp r1.x, r6.x
mul_pp r1.x, r5, r1
mul_pp r1.xyz, r1.x, c2
mul r4.xyz, v0, r3
mad r2.xyz, -v0, r3, r2
mad r2.xyz, r5.z, r2, r4
max_pp r0.x, r0, c6.w
mad_pp r0.xyz, r2, r0.x, r1
mul_pp r1.xyz, r0, c0
mul r0.x, r7, r0.w
mul_pp r1.xyz, r0.x, r1
mul r0.x, v0.w, c1.w
mul_pp r1.xyz, r1, c6.x
mul r1.w, r0.x, r3
mov_pp oC0, r1
"
}

SubProgram "flash " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Vector 3 [_GrabTexture_TexelSize]
Float 4 [_Focus]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
"agal_ps
c6 2.0 -1.0 1.0 0.0
c7 250.0 4.0 0.0 0.0
[bc]
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r0, v0, s1 <2d wrap linear point>
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
ciaaaaaaafaaapacaaaaaaoeaeaaaaaaacaaaaaaafaababb tex r5, v0, s2 <2d wrap linear point>
aaaaaaaaaaaaabacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r0.w
adaaaaaaacaaadacaaaaaafeacaaaaaaagaaaaaaabaaaaaa mul r2.xy, r0.xyyy, c6.x
abaaaaaaacaaadacacaaaafeacaaaaaaagaaaaffabaaaaaa add r2.xy, r2.xyyy, c6.y
adaaaaaaaaaaadacacaaaafeacaaaaaaadaaaaoeabaaaaaa mul r0.xy, r2.xyyy, c3
adaaaaaaaaaaadacaaaaaafeacaaaaaaaeaaaaaaabaaaaaa mul r0.xy, r0.xyyy, c4.x
adaaaaaaabaaadacaaaaaafeacaaaaaaacaaaakkaeaaaaaa mul r1.xy, r0.xyyy, v2.z
abaaaaaaabaaadacabaaaafeacaaaaaaacaaaaoeaeaaaaaa add r1.xy, r1.xyyy, v2
aaaaaaaaabaaamacacaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r1.zw, v2
bcaaaaaaaaaaabacafaaaaoeaeaaaaaaafaaaaoeaeaaaaaa dp3 r0.x, v5, v5
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
aeaaaaaaaeaaapacabaaaaoeacaaaaaaabaaaappacaaaaaa div r4, r1, r1.w
ciaaaaaaaeaaapacaeaaaafeacaaaaaaadaaaaaaafaababb tex r4, r4.xyyy, s3 <2d wrap linear point>
ciaaaaaaabaaapacaaaaaafeacaaaaaaaeaaaaaaafaababb tex r1, r0.xyyy, s4 <2d wrap linear point>
ciaaaaaaaaaaapacafaaaaoeaeaaaaaaafaaaaaaafbababb tex r0, v5, s5 <cube wrap linear point>
adaaaaaaaaaaabacacaaaaffacaaaaaaacaaaaffacaaaaaa mul r0.x, r2.y, r2.y
bfaaaaaaacaaaiacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r2.w, r2.x
adaaaaaaacaaaiacacaaaappacaaaaaaacaaaaaaacaaaaaa mul r2.w, r2.w, r2.x
acaaaaaaaaaaabacacaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r2.w, r0.x
bcaaaaaaabaaabacadaaaaoeaeaaaaaaadaaaaoeaeaaaaaa dp3 r1.x, v3, v3
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
adaaaaaaagaaahacabaaaaaaacaaaaaaadaaaaoeaeaaaaaa mul r6.xyz, r1.x, v3
bcaaaaaaabaaabacagaaaakeacaaaaaaagaaaakeacaaaaaa dp3 r1.x, r6.xyzz, r6.xyzz
abaaaaaaaaaaabacaaaaaaaaacaaaaaaagaaaakkabaaaaaa add r0.x, r0.x, c6.z
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
afaaaaaaacaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r2.z, r0.x
bcaaaaaaaaaaabacacaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r0.x, r2.xyzz, r2.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
adaaaaaaabaaahacabaaaaaaacaaaaaaagaaaakeacaaaaaa mul r1.xyz, r1.x, r6.xyzz
adaaaaaaacaaahacaaaaaaaaacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r0.x, r2.xyzz
bcaaaaaaaaaaabacacaaaakeacaaaaaaabaaaakeacaaaaaa dp3 r0.x, r2.xyzz, r1.xyzz
adaaaaaaacaaahacaaaaaaaaacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r0.x, r2.xyzz
bfaaaaaaagaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r6.xyz, r2.xyzz
adaaaaaaagaaahacagaaaakeacaaaaaaagaaaaaaabaaaaaa mul r6.xyz, r6.xyzz, c6.x
abaaaaaaagaaahacagaaaakeacaaaaaaabaaaakeacaaaaaa add r6.xyz, r6.xyzz, r1.xyzz
bcaaaaaaabaaabacaeaaaaoeaeaaaaaaaeaaaaoeaeaaaaaa dp3 r1.x, v4, v4
akaaaaaaacaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r2.x, r1.x
adaaaaaaacaaahacacaaaaaaacaaaaaaaeaaaaoeaeaaaaaa mul r2.xyz, r2.x, v4
bfaaaaaaahaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r7.xyz, r2.xyzz
bcaaaaaaacaaabacahaaaakeacaaaaaaagaaaakeacaaaaaa dp3 r2.x, r7.xyzz, r6.xyzz
adaaaaaaabaaabacafaaaaffacaaaaaaafaaaaoeabaaaaaa mul r1.x, r5.y, c5
adaaaaaaabaaabacabaaaaaaacaaaaaaahaaaaoeabaaaaaa mul r1.x, r1.x, c7
abaaaaaaabaaabacabaaaaaaacaaaaaaahaaaaffabaaaaaa add r1.x, r1.x, c7.y
ahaaaaaaacaaabacacaaaaaaacaaaaaaagaaaappabaaaaaa max r2.x, r2.x, c6.w
alaaaaaaagaaapacacaaaaaaacaaaaaaabaaaaaaacaaaaaa pow r6, r2.x, r1.x
adaaaaaaacaaahacaeaaaakeacaaaaaaabaaaaoeabaaaaaa mul r2.xyz, r4.xyzz, c1
aaaaaaaaabaaabacagaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r6.x
adaaaaaaabaaabacafaaaaaaacaaaaaaabaaaaaaacaaaaaa mul r1.x, r5.x, r1.x
adaaaaaaabaaahacabaaaaaaacaaaaaaacaaaaoeabaaaaaa mul r1.xyz, r1.x, c2
adaaaaaaaeaaahacahaaaaoeaeaaaaaaadaaaakeacaaaaaa mul r4.xyz, v7, r3.xyzz
bfaaaaaaahaaahacahaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa neg r7.xyz, v7
adaaaaaaahaaahacahaaaakeacaaaaaaadaaaakeacaaaaaa mul r7.xyz, r7.xyzz, r3.xyzz
abaaaaaaacaaahacahaaaakeacaaaaaaacaaaakeacaaaaaa add r2.xyz, r7.xyzz, r2.xyzz
adaaaaaaacaaahacafaaaakkacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r5.z, r2.xyzz
abaaaaaaacaaahacacaaaakeacaaaaaaaeaaaakeacaaaaaa add r2.xyz, r2.xyzz, r4.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaagaaaappabaaaaaa max r0.x, r0.x, c6.w
adaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r0.xyz, r2.xyzz, r0.x
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaahacaaaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r0.xyzz, c0
adaaaaaaaaaaabacabaaaappacaaaaaaaaaaaappacaaaaaa mul r0.x, r1.w, r0.w
adaaaaaaabaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.x, r1.xyzz
adaaaaaaaaaaabacahaaaappaeaaaaaaabaaaappabaaaaaa mul r0.x, v7.w, c1.w
adaaaaaaabaaahacabaaaakeacaaaaaaagaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c6.x
adaaaaaaabaaaiacaaaaaaaaacaaaaaaadaaaappacaaaaaa mul r1.w, r0.x, r3.w
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Vector 3 [_GrabTexture_TexelSize]
Float 4 [_Focus]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
SetTexture 4 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 43 ALU, 5 TEX
PARAM c[8] = { program.local[0..5],
		{ 2, 1, 0, 250 },
		{ 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.yw, fragment.texcoord[0], texture[1], 2D;
TEX R1.w, fragment.texcoord[5], texture[4], 2D;
MAD R3.xy, R0.wyzw, c[6].x, -c[6].y;
MUL R0.xy, R3, c[3];
MUL R0.xy, R0, c[4].x;
MAD R1.xy, R0, fragment.texcoord[2].z, fragment.texcoord[2];
MOV R1.z, fragment.texcoord[2].w;
MUL R2.w, R3.y, R3.y;
MAD R2.w, -R3.x, R3.x, -R2;
ADD R2.w, R2, c[6].y;
RSQ R2.w, R2.w;
RCP R3.z, R2.w;
DP3 R2.w, R3, R3;
RSQ R2.w, R2.w;
MUL R3.xyz, R2.w, R3;
DP3 R2.w, R3, fragment.texcoord[3];
MUL R3.xyz, R2.w, R3;
DP3 R3.w, fragment.texcoord[4], fragment.texcoord[4];
MAD R4.xyz, -R3, c[6].x, fragment.texcoord[3];
RSQ R3.w, R3.w;
MUL R3.xyz, R3.w, fragment.texcoord[4];
DP3 R3.y, -R3, R4;
MOV R3.x, c[7];
TXP R2.xyz, R1.xyzz, texture[3], 2D;
TEX R1.xyz, fragment.texcoord[0], texture[2], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1.y, R1, c[5].x;
MAD R3.x, R1.y, c[6].w, R3;
MAX R1.y, R3, c[6].z;
POW R1.y, R1.y, R3.x;
MUL R2.xyz, R2, c[1];
MUL R3.xyz, fragment.color.primary, R0;
MAD R0.xyz, -fragment.color.primary, R0, R2;
MAD R0.xyz, R1.z, R0, R3;
MUL R1.x, R1, R1.y;
MUL R1.xyz, R1.x, c[2];
MAX R2.x, R2.w, c[6].z;
MAD R0.xyz, R0, R2.x, R1;
MUL R0.xyz, R0, c[0];
MUL R1.xyz, R1.w, R0;
MUL R0.x, fragment.color.primary.w, c[1].w;
MUL result.color.xyz, R1, c[6].x;
MUL result.color.w, R0.x, R0;
END
# 43 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Vector 3 [_GrabTexture_TexelSize]
Float 4 [_Focus]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
SetTexture 4 [_LightTexture0] 2D
"ps_2_0
; 42 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c6, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c7, 250.00000000, 4.00000000, 0, 0
dcl t0.xy
dcl v0
dcl t2
dcl t3.xyz
dcl t4.xyz
dcl t5.xy
texld r0, t0, s1
texld r3, t0, s0
texld r5, t0, s2
mov r0.x, r0.w
mad_pp r1.xy, r0, c6.x, c6.y
mul_pp r0.xy, r1, c3
mul_pp r0.xy, r0, c4.x
mov r0.zw, t2
mad r0.xy, r0, t2.z, t2
texldp r4, r0, s3
texld r0, t5, s4
mul_pp r0.x, r1.y, r1.y
mad_pp r0.x, -r1, r1, -r0
add_pp r0.x, r0, c6.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
dp3_pp r0.x, r1, r1
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r1
dp3_pp r0.x, r1, t3
mul_pp r1.xyz, r0.x, r1
mad_pp r6.xyz, -r1, c6.x, t3
dp3_pp r1.x, t4, t4
rsq_pp r2.x, r1.x
mul_pp r2.xyz, r2.x, t4
dp3_pp r2.x, -r2, r6
mul_pp r1.x, r5.y, c5
mad_pp r1.x, r1, c7, c7.y
max_pp r2.x, r2, c6.w
pow_pp r6.x, r2.x, r1.x
mul_pp r2.xyz, r4, c1
mov_pp r1.x, r6.x
mul_pp r1.x, r5, r1
mul_pp r1.xyz, r1.x, c2
mul r4.xyz, v0, r3
mad r2.xyz, -v0, r3, r2
mad r2.xyz, r5.z, r2, r4
max_pp r0.x, r0, c6.w
mad_pp r0.xyz, r2, r0.x, r1
mul_pp r0.xyz, r0, c0
mul_pp r1.xyz, r0.w, r0
mul r0.x, v0.w, c1.w
mul_pp r1.xyz, r1, c6.x
mul r1.w, r0.x, r3
mov_pp oC0, r1
"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Vector 3 [_GrabTexture_TexelSize]
Float 4 [_Focus]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_GrabTexture] 2D
SetTexture 4 [_LightTexture0] 2D
"agal_ps
c6 2.0 -1.0 1.0 0.0
c7 250.0 4.0 0.0 0.0
[bc]
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r0, v0, s1 <2d wrap linear point>
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
ciaaaaaaafaaapacaaaaaaoeaeaaaaaaacaaaaaaafaababb tex r5, v0, s2 <2d wrap linear point>
aaaaaaaaaaaaabacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r0.w
adaaaaaaabaaadacaaaaaafeacaaaaaaagaaaaaaabaaaaaa mul r1.xy, r0.xyyy, c6.x
abaaaaaaabaaadacabaaaafeacaaaaaaagaaaaffabaaaaaa add r1.xy, r1.xyyy, c6.y
adaaaaaaaaaaadacabaaaafeacaaaaaaadaaaaoeabaaaaaa mul r0.xy, r1.xyyy, c3
adaaaaaaaaaaadacaaaaaafeacaaaaaaaeaaaaaaabaaaaaa mul r0.xy, r0.xyyy, c4.x
aaaaaaaaaaaaamacacaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r0.zw, v2
adaaaaaaaaaaadacaaaaaafeacaaaaaaacaaaakkaeaaaaaa mul r0.xy, r0.xyyy, v2.z
abaaaaaaaaaaadacaaaaaafeacaaaaaaacaaaaoeaeaaaaaa add r0.xy, r0.xyyy, v2
aeaaaaaaacaaapacaaaaaaoeacaaaaaaaaaaaappacaaaaaa div r2, r0, r0.w
ciaaaaaaaeaaapacacaaaafeacaaaaaaadaaaaaaafaababb tex r4, r2.xyyy, s3 <2d wrap linear point>
ciaaaaaaaaaaapacafaaaaoeaeaaaaaaaeaaaaaaafaababb tex r0, v5, s4 <2d wrap linear point>
adaaaaaaaaaaabacabaaaaffacaaaaaaabaaaaffacaaaaaa mul r0.x, r1.y, r1.y
bfaaaaaaacaaaiacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r2.w, r1.x
adaaaaaaacaaaiacacaaaappacaaaaaaabaaaaaaacaaaaaa mul r2.w, r2.w, r1.x
acaaaaaaaaaaabacacaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r2.w, r0.x
abaaaaaaaaaaabacaaaaaaaaacaaaaaaagaaaakkabaaaaaa add r0.x, r0.x, c6.z
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
afaaaaaaabaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r1.z, r0.x
bcaaaaaaaaaaabacabaaaakeacaaaaaaabaaaakeacaaaaaa dp3 r0.x, r1.xyzz, r1.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaabaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.x, r1.xyzz
bcaaaaaaaaaaabacabaaaakeacaaaaaaadaaaaoeaeaaaaaa dp3 r0.x, r1.xyzz, v3
adaaaaaaabaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.x, r1.xyzz
bfaaaaaaagaaahacabaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r6.xyz, r1.xyzz
adaaaaaaagaaahacagaaaakeacaaaaaaagaaaaaaabaaaaaa mul r6.xyz, r6.xyzz, c6.x
abaaaaaaagaaahacagaaaakeacaaaaaaadaaaaoeaeaaaaaa add r6.xyz, r6.xyzz, v3
bcaaaaaaabaaabacaeaaaaoeaeaaaaaaaeaaaaoeaeaaaaaa dp3 r1.x, v4, v4
akaaaaaaacaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r2.x, r1.x
adaaaaaaacaaahacacaaaaaaacaaaaaaaeaaaaoeaeaaaaaa mul r2.xyz, r2.x, v4
bfaaaaaaahaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r7.xyz, r2.xyzz
bcaaaaaaacaaabacahaaaakeacaaaaaaagaaaakeacaaaaaa dp3 r2.x, r7.xyzz, r6.xyzz
adaaaaaaabaaabacafaaaaffacaaaaaaafaaaaoeabaaaaaa mul r1.x, r5.y, c5
adaaaaaaabaaabacabaaaaaaacaaaaaaahaaaaoeabaaaaaa mul r1.x, r1.x, c7
abaaaaaaabaaabacabaaaaaaacaaaaaaahaaaaffabaaaaaa add r1.x, r1.x, c7.y
ahaaaaaaacaaabacacaaaaaaacaaaaaaagaaaappabaaaaaa max r2.x, r2.x, c6.w
alaaaaaaagaaapacacaaaaaaacaaaaaaabaaaaaaacaaaaaa pow r6, r2.x, r1.x
adaaaaaaacaaahacaeaaaakeacaaaaaaabaaaaoeabaaaaaa mul r2.xyz, r4.xyzz, c1
aaaaaaaaabaaabacagaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r6.x
adaaaaaaabaaabacafaaaaaaacaaaaaaabaaaaaaacaaaaaa mul r1.x, r5.x, r1.x
adaaaaaaabaaahacabaaaaaaacaaaaaaacaaaaoeabaaaaaa mul r1.xyz, r1.x, c2
adaaaaaaaeaaahacahaaaaoeaeaaaaaaadaaaakeacaaaaaa mul r4.xyz, v7, r3.xyzz
bfaaaaaaahaaahacahaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa neg r7.xyz, v7
adaaaaaaahaaahacahaaaakeacaaaaaaadaaaakeacaaaaaa mul r7.xyz, r7.xyzz, r3.xyzz
abaaaaaaacaaahacahaaaakeacaaaaaaacaaaakeacaaaaaa add r2.xyz, r7.xyzz, r2.xyzz
adaaaaaaacaaahacafaaaakkacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r5.z, r2.xyzz
abaaaaaaacaaahacacaaaakeacaaaaaaaeaaaakeacaaaaaa add r2.xyz, r2.xyzz, r4.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaagaaaappabaaaaaa max r0.x, r0.x, c6.w
adaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r0.xyz, r2.xyzz, r0.x
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r0.xyz, r0.xyzz, c0
adaaaaaaabaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r1.xyz, r0.w, r0.xyzz
adaaaaaaaaaaabacahaaaappaeaaaaaaabaaaappabaaaaaa mul r0.x, v7.w, c1.w
adaaaaaaabaaahacabaaaakeacaaaaaaagaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c6.x
adaaaaaaabaaaiacaaaaaaaaacaaaaaaadaaaappacaaaaaa mul r1.w, r0.x, r3.w
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
"
}

}
	}

#LINE 124

		}
		
		SubShader
		{
			LOD 400

			Cull Off
			ZWrite Off
			ZTest LEqual
			Blend SrcAlpha OneMinusSrcAlpha
			AlphaTest Greater 0

				Alphatest Greater 0 ZWrite Off ColorMask RGB
	
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }
		Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
// Vertex combos: 3
//   opengl - ALU: 7 to 75
//   d3d9 - ALU: 7 to 78
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [_MainTex_ST]
"!!ARBvp1.0
# 44 ALU
PARAM c[24] = { { 1 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[13].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MOV R0.w, c[0].x;
MUL R1, R0.xyzz, R0.yzzx;
DP4 R2.z, R0, c[18];
DP4 R2.y, R0, c[17];
DP4 R2.x, R0, c[16];
MUL R0.w, R2, R2;
MAD R0.w, R0.x, R0.x, -R0;
DP4 R0.z, R1, c[21];
DP4 R0.y, R1, c[20];
DP4 R0.x, R1, c[19];
ADD R0.xyz, R2, R0;
MUL R1.xyz, R0.w, c[22];
ADD result.texcoord[2].xyz, R0, R1;
MOV R1.xyz, c[14];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[13].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[15];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 44 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Vector 22 [_MainTex_ST]
"vs_2_0
; 47 ALU
def c23, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
mul r1.xyz, v2, c12.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mov r0.w, c23.x
mul r1, r0.xyzz, r0.yzzx
dp4 r2.z, r0, c17
dp4 r2.y, r0, c16
dp4 r2.x, r0, c15
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp4 r0.z, r1, c20
dp4 r0.y, r1, c19
dp4 r0.x, r1, c18
mul r1.xyz, r0.w, c21
add r0.xyz, r2, r0
add oT2.xyz, r0, r1
mov r0.w, c23.x
mov r0.xyz, c13
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c12.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c14, r0
mov r0, c9
mov r1, c8
dp4 r4.y, c14, r0
dp4 r4.x, c14, r1
dp3 oT1.y, r4, r2
dp3 oT3.y, r2, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
mov oD0, v4
mad oT0.xy, v3, c22, c22.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize (_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize (_glesNormal);
  highp vec3 shlight;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = tmpvar_1.xyz;
  tmpvar_6[1] = (cross (tmpvar_2, tmpvar_1.xyz) * _glesTANGENT.w);
  tmpvar_6[2] = tmpvar_2;
  mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_6[0].x;
  tmpvar_7[0].y = tmpvar_6[1].x;
  tmpvar_7[0].z = tmpvar_6[2].x;
  tmpvar_7[1].x = tmpvar_6[0].y;
  tmpvar_7[1].y = tmpvar_6[1].y;
  tmpvar_7[1].z = tmpvar_6[2].y;
  tmpvar_7[2].x = tmpvar_6[0].z;
  tmpvar_7[2].y = tmpvar_6[1].z;
  tmpvar_7[2].z = tmpvar_6[2].z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (tmpvar_5 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_11;
  mediump vec4 normal;
  normal = tmpvar_10;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_12;
  tmpvar_12 = dot (unity_SHAr, normal);
  x1.x = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAg, normal);
  x1.y = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAb, normal);
  x1.z = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHBr, tmpvar_15);
  x2.x = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBg, tmpvar_15);
  x2.y = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBb, tmpvar_15);
  x2.z = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (unity_SHC.xyz * vC);
  x3 = tmpvar_20;
  tmpvar_11 = ((x1 + x2) + x3);
  shlight = tmpvar_11;
  tmpvar_4 = shlight;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_7 * (((_World2Object * tmpvar_9).xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _Specular;
uniform highp float _Shininess;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
uniform sampler2D _BumpMap;
void main ()
{
  lowp vec4 c;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec3 nm;
  mediump vec4 tex;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  nm = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (col.xyz, _Color.xyz, tmpvar_10);
  col.xyz = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = col.xyz;
  tmpvar_2 = tmpvar_13;
  tmpvar_3 = nm;
  highp float tmpvar_14;
  tmpvar_14 = (_Shininess * mask.y);
  tmpvar_4 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = col.w;
  tmpvar_5 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize (xlv_TEXCOORD3);
  mediump vec3 lightDir;
  lightDir = xlv_TEXCOORD1;
  mediump vec3 viewDir;
  viewDir = tmpvar_16;
  mediump vec4 c_i0;
  mediump float shininess;
  mediump vec3 nNormal;
  lowp vec3 tmpvar_17;
  tmpvar_17 = normalize (tmpvar_3);
  nNormal = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = ((tmpvar_4 * 250.0) + 4.0);
  shininess = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, dot (nNormal, lightDir));
  mediump float tmpvar_20;
  tmpvar_20 = (pow (max (0.0, dot (-(viewDir), reflect (lightDir, nNormal))), shininess) * mask.x);
  highp vec3 tmpvar_21;
  tmpvar_21 = (((tmpvar_2 * tmpvar_19) + (_Specular.xyz * tmpvar_20)) * _LightColor0.xyz);
  c_i0.xyz = tmpvar_21;
  c_i0.xyz = (c_i0.xyz * 2.0);
  c_i0.w = tmpvar_5;
  c = c_i0;
  c.xyz = (c.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  c.w = tmpvar_5;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize (_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize (_glesNormal);
  highp vec3 shlight;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = tmpvar_1.xyz;
  tmpvar_6[1] = (cross (tmpvar_2, tmpvar_1.xyz) * _glesTANGENT.w);
  tmpvar_6[2] = tmpvar_2;
  mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_6[0].x;
  tmpvar_7[0].y = tmpvar_6[1].x;
  tmpvar_7[0].z = tmpvar_6[2].x;
  tmpvar_7[1].x = tmpvar_6[0].y;
  tmpvar_7[1].y = tmpvar_6[1].y;
  tmpvar_7[1].z = tmpvar_6[2].y;
  tmpvar_7[2].x = tmpvar_6[0].z;
  tmpvar_7[2].y = tmpvar_6[1].z;
  tmpvar_7[2].z = tmpvar_6[2].z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (tmpvar_5 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_11;
  mediump vec4 normal;
  normal = tmpvar_10;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_12;
  tmpvar_12 = dot (unity_SHAr, normal);
  x1.x = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAg, normal);
  x1.y = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAb, normal);
  x1.z = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHBr, tmpvar_15);
  x2.x = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBg, tmpvar_15);
  x2.y = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBb, tmpvar_15);
  x2.z = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (unity_SHC.xyz * vC);
  x3 = tmpvar_20;
  tmpvar_11 = ((x1 + x2) + x3);
  shlight = tmpvar_11;
  tmpvar_4 = shlight;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_7 * (((_World2Object * tmpvar_9).xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _Specular;
uniform highp float _Shininess;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
uniform sampler2D _BumpMap;
void main ()
{
  lowp vec4 c;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec3 nm;
  mediump vec4 tex;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_6;
  lowp vec3 normal;
  normal.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal.z = sqrt (((1.0 - (normal.x * normal.x)) - (normal.y * normal.y)));
  nm = normal;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (col.xyz, _Color.xyz, tmpvar_9);
  col.xyz = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = col.xyz;
  tmpvar_2 = tmpvar_12;
  tmpvar_3 = nm;
  highp float tmpvar_13;
  tmpvar_13 = (_Shininess * mask.y);
  tmpvar_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = col.w;
  tmpvar_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize (xlv_TEXCOORD3);
  mediump vec3 lightDir;
  lightDir = xlv_TEXCOORD1;
  mediump vec3 viewDir;
  viewDir = tmpvar_15;
  mediump vec4 c_i0;
  mediump float shininess;
  mediump vec3 nNormal;
  lowp vec3 tmpvar_16;
  tmpvar_16 = normalize (tmpvar_3);
  nNormal = tmpvar_16;
  lowp float tmpvar_17;
  tmpvar_17 = ((tmpvar_4 * 250.0) + 4.0);
  shininess = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (nNormal, lightDir));
  mediump float tmpvar_19;
  tmpvar_19 = (pow (max (0.0, dot (-(viewDir), reflect (lightDir, nNormal))), shininess) * mask.x);
  highp vec3 tmpvar_20;
  tmpvar_20 = (((tmpvar_2 * tmpvar_18) + (_Specular.xyz * tmpvar_19)) * _LightColor0.xyz);
  c_i0.xyz = tmpvar_20;
  c_i0.xyz = (c_i0.xyz * 2.0);
  c_i0.w = tmpvar_5;
  c = c_i0;
  c.xyz = (c.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  c.w = tmpvar_5;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Vector 22 [_MainTex_ST]
"agal_vs
c23 1.0 0.0 0.0 0.0
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaamaaaappabaaaaaa mul r1.xyz, a1, c12.w
bcaaaaaaacaaaiacabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r2.w, r1.xyzz, c5
bcaaaaaaaaaaabacabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r0.x, r1.xyzz, c4
bcaaaaaaaaaaaeacabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r0.z, r1.xyzz, c6
aaaaaaaaaaaaacacacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r2.w
aaaaaaaaaaaaaiacbhaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c23.x
adaaaaaaabaaapacaaaaaakeacaaaaaaaaaaaacjacaaaaaa mul r1, r0.xyzz, r0.yzzx
bdaaaaaaacaaaeacaaaaaaoeacaaaaaabbaaaaoeabaaaaaa dp4 r2.z, r0, c17
bdaaaaaaacaaacacaaaaaaoeacaaaaaabaaaaaoeabaaaaaa dp4 r2.y, r0, c16
bdaaaaaaacaaabacaaaaaaoeacaaaaaaapaaaaoeabaaaaaa dp4 r2.x, r0, c15
adaaaaaaaaaaaiacacaaaappacaaaaaaacaaaappacaaaaaa mul r0.w, r2.w, r2.w
adaaaaaaadaaaiacaaaaaaaaacaaaaaaaaaaaaaaacaaaaaa mul r3.w, r0.x, r0.x
acaaaaaaaaaaaiacadaaaappacaaaaaaaaaaaappacaaaaaa sub r0.w, r3.w, r0.w
bdaaaaaaaaaaaeacabaaaaoeacaaaaaabeaaaaoeabaaaaaa dp4 r0.z, r1, c20
bdaaaaaaaaaaacacabaaaaoeacaaaaaabdaaaaoeabaaaaaa dp4 r0.y, r1, c19
bdaaaaaaaaaaabacabaaaaoeacaaaaaabcaaaaoeabaaaaaa dp4 r0.x, r1, c18
adaaaaaaabaaahacaaaaaappacaaaaaabfaaaaoeabaaaaaa mul r1.xyz, r0.w, c21
abaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaacaaahaeaaaaaakeacaaaaaaabaaaakeacaaaaaa add v2.xyz, r0.xyzz, r1.xyzz
aaaaaaaaaaaaaiacbhaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c23.x
aaaaaaaaaaaaahacanaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c13
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r1.z, r0, c10
bdaaaaaaabaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r1.y, r0, c9
bdaaaaaaabaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r1.x, r0, c8
adaaaaaaaeaaahacabaaaakeacaaaaaaamaaaappabaaaaaa mul r4.xyz, r1.xyzz, c12.w
acaaaaaaadaaahacaeaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r4.xyzz, a0
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaaaaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r0.yzxx
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaafaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r5.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacafaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r5.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaaeaaaeacaoaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c14, r0
aaaaaaaaaaaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c9
aaaaaaaaabaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c8
bdaaaaaaaeaaacacaoaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.y, c14, r0
bdaaaaaaaeaaabacaoaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.x, c14, r1
bcaaaaaaabaaacaeaeaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v1.y, r4.xyzz, r2.xyzz
bcaaaaaaadaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v3.y, r2.xyzz, r3.xyzz
bcaaaaaaabaaaeaeabaaaaoeaaaaaaaaaeaaaakeacaaaaaa dp3 v1.z, a1, r4.xyzz
bcaaaaaaabaaabaeaeaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v1.x, r4.xyzz, a5
bcaaaaaaadaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v3.z, a1, r3.xyzz
bcaaaaaaadaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v3.x, a5, r3.xyzz
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
adaaaaaaafaaadacadaaaaoeaaaaaaaabgaaaaoeabaaaaaa mul r5.xy, a3, c22
abaaaaaaaaaaadaeafaaaafeacaaaaaabgaaaaooabaaaaaa add v0.xy, r5.xyyy, c22.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
"!!ARBvp1.0
# 7 ALU
PARAM c[16] = { program.local[0],
		state.matrix.mvp,
		program.local[5..15] };
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[14], c[14].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 7 instructions, 0 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
"vs_2_0
; 7 ALU
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov oD0, v5
mad oT0.xy, v3, c13, c13.zwzw
mad oT1.xy, v4, c12, c12.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;

uniform highp vec4 _MainTex_ST;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec4 tex;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (col.xyz, _Color.xyz, tmpvar_7);
  col.xyz = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = col.xyz;
  tmpvar_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = col.w;
  tmpvar_3 = tmpvar_11;
  c = vec4(0.0, 0.0, 0.0, 0.0);
  c.xyz = (tmpvar_2 * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  c.w = tmpvar_3;
  c.w = tmpvar_3;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;

uniform highp vec4 _MainTex_ST;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform sampler2D _BumpMap;
void main ()
{
  lowp vec4 c;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec4 tex;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_4;
  lowp vec3 normal;
  normal.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal.z = sqrt (((1.0 - (normal.x * normal.x)) - (normal.y * normal.y)));
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (col.xyz, _Color.xyz, tmpvar_7);
  col.xyz = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = col.xyz;
  tmpvar_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = col.w;
  tmpvar_3 = tmpvar_11;
  c = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  c.xyz = (tmpvar_2 * ((8.0 * tmpvar_12.w) * tmpvar_12.xyz));
  c.w = tmpvar_3;
  c.w = tmpvar_3;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
"agal_vs
[bc]
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
adaaaaaaaaaaadacadaaaaoeaaaaaaaaanaaaaoeabaaaaaa mul r0.xy, a3, c13
abaaaaaaaaaaadaeaaaaaafeacaaaaaaanaaaaooabaaaaaa add v0.xy, r0.xyyy, c13.zwzw
adaaaaaaaaaaadacaeaaaaoeaaaaaaaaamaaaaoeabaaaaaa mul r0.xy, a4, c12
abaaaaaaabaaadaeaaaaaafeacaaaaaaamaaaaooabaaaaaa add v1.xy, r0.xyyy, c12.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Vector 31 [_MainTex_ST]
"!!ARBvp1.0
# 75 ALU
PARAM c[32] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..31] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[13].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[17];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[16];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[18];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[19];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[21];
MAD R1.xyz, R0.x, c[20], R1;
MAD R0.xyz, R0.z, c[22], R1;
MAD R1.xyz, R0.w, c[23], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R3.z, R0, c[29];
DP4 R3.y, R0, c[28];
DP4 R3.x, R0, c[27];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[30];
MOV R1.w, c[0].x;
DP4 R2.z, R4, c[26];
DP4 R2.y, R4, c[25];
DP4 R2.x, R4, c[24];
ADD R2.xyz, R2, R3;
ADD R0.xyz, R2, R0;
ADD result.texcoord[2].xyz, R0, R1;
MOV R1.xyz, c[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[13].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1, c[15];
MUL R0.xyz, R0, vertex.attrib[14].w;
DP4 R3.z, R1, c[11];
DP4 R3.y, R1, c[10];
DP4 R3.x, R1, c[9];
DP3 result.texcoord[1].y, R3, R0;
DP3 result.texcoord[3].y, R0, R2;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[31], c[31].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 75 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 18 [unity_4LightAtten0]
Vector 19 [unity_LightColor0]
Vector 20 [unity_LightColor1]
Vector 21 [unity_LightColor2]
Vector 22 [unity_LightColor3]
Vector 23 [unity_SHAr]
Vector 24 [unity_SHAg]
Vector 25 [unity_SHAb]
Vector 26 [unity_SHBr]
Vector 27 [unity_SHBg]
Vector 28 [unity_SHBb]
Vector 29 [unity_SHC]
Vector 30 [_MainTex_ST]
"vs_2_0
; 78 ALU
def c31, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
mul r3.xyz, v2, c12.w
dp4 r0.x, v0, c5
add r1, -r0.x, c16
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c15
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c31.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c17
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c18
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c31.x
dp4 r2.z, r4, c25
dp4 r2.y, r4, c24
dp4 r2.x, r4, c23
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c31.y
mul r0, r0, r1
mul r1.xyz, r0.y, c20
mad r1.xyz, r0.x, c19, r1
mad r0.xyz, r0.z, c21, r1
mad r1.xyz, r0.w, c22, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c28
dp4 r3.y, r0, c27
dp4 r3.x, r0, c26
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c29
add r2.xyz, r2, r3
add r0.xyz, r2, r0
add oT2.xyz, r0, r1
mov r1.w, c31.x
mov r1.xyz, c13
dp4 r0.z, r1, c10
dp4 r0.y, r1, c9
dp4 r0.x, r1, c8
mad r3.xyz, r0, c12.w, -v0
mov r1.xyz, v1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r1.yzxw
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c14, r0
mov r1, c9
mov r0, c8
dp4 r4.y, c14, r1
dp4 r4.x, c14, r0
dp3 oT1.y, r4, r2
dp3 oT3.y, r2, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
mov oD0, v4
mad oT0.xy, v3, c30, c30.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightAtten0;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize (_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize (_glesNormal);
  highp vec3 shlight;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (tmpvar_2 * unity_Scale.w));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = tmpvar_1.xyz;
  tmpvar_7[1] = (cross (tmpvar_2, tmpvar_1.xyz) * _glesTANGENT.w);
  tmpvar_7[2] = tmpvar_2;
  mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_7[0].x;
  tmpvar_8[0].y = tmpvar_7[1].x;
  tmpvar_8[0].z = tmpvar_7[2].x;
  tmpvar_8[1].x = tmpvar_7[0].y;
  tmpvar_8[1].y = tmpvar_7[1].y;
  tmpvar_8[1].z = tmpvar_7[2].y;
  tmpvar_8[2].x = tmpvar_7[0].z;
  tmpvar_8[2].y = tmpvar_7[1].z;
  tmpvar_8[2].z = tmpvar_7[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_6;
  mediump vec3 tmpvar_12;
  mediump vec4 normal;
  normal = tmpvar_11;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal);
  x1.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal);
  x1.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal);
  x1.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC);
  x3 = tmpvar_21;
  tmpvar_12 = ((x1 + x2) + x3);
  shlight = tmpvar_12;
  tmpvar_4 = shlight;
  highp vec3 tmpvar_22;
  tmpvar_22 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_23 * tmpvar_6.x) + (tmpvar_24 * tmpvar_6.y)) + (tmpvar_25 * tmpvar_6.z)) * inversesqrt (tmpvar_26))) * (1.0/((1.0 + (tmpvar_26 * unity_4LightAtten0)))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_4 + ((((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y)) + (unity_LightColor[2].xyz * tmpvar_27.z)) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_4 = tmpvar_28;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _Specular;
uniform highp float _Shininess;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
uniform sampler2D _BumpMap;
void main ()
{
  lowp vec4 c;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec3 nm;
  mediump vec4 tex;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  nm = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (col.xyz, _Color.xyz, tmpvar_10);
  col.xyz = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = col.xyz;
  tmpvar_2 = tmpvar_13;
  tmpvar_3 = nm;
  highp float tmpvar_14;
  tmpvar_14 = (_Shininess * mask.y);
  tmpvar_4 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = col.w;
  tmpvar_5 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize (xlv_TEXCOORD3);
  mediump vec3 lightDir;
  lightDir = xlv_TEXCOORD1;
  mediump vec3 viewDir;
  viewDir = tmpvar_16;
  mediump vec4 c_i0;
  mediump float shininess;
  mediump vec3 nNormal;
  lowp vec3 tmpvar_17;
  tmpvar_17 = normalize (tmpvar_3);
  nNormal = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = ((tmpvar_4 * 250.0) + 4.0);
  shininess = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, dot (nNormal, lightDir));
  mediump float tmpvar_20;
  tmpvar_20 = (pow (max (0.0, dot (-(viewDir), reflect (lightDir, nNormal))), shininess) * mask.x);
  highp vec3 tmpvar_21;
  tmpvar_21 = (((tmpvar_2 * tmpvar_19) + (_Specular.xyz * tmpvar_20)) * _LightColor0.xyz);
  c_i0.xyz = tmpvar_21;
  c_i0.xyz = (c_i0.xyz * 2.0);
  c_i0.w = tmpvar_5;
  c = c_i0;
  c.xyz = (c.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  c.w = tmpvar_5;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightAtten0;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize (_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize (_glesNormal);
  highp vec3 shlight;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (tmpvar_2 * unity_Scale.w));
  highp mat3 tmpvar_7;
  tmpvar_7[0] = tmpvar_1.xyz;
  tmpvar_7[1] = (cross (tmpvar_2, tmpvar_1.xyz) * _glesTANGENT.w);
  tmpvar_7[2] = tmpvar_2;
  mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_7[0].x;
  tmpvar_8[0].y = tmpvar_7[1].x;
  tmpvar_8[0].z = tmpvar_7[2].x;
  tmpvar_8[1].x = tmpvar_7[0].y;
  tmpvar_8[1].y = tmpvar_7[1].y;
  tmpvar_8[1].z = tmpvar_7[2].y;
  tmpvar_8[2].x = tmpvar_7[0].z;
  tmpvar_8[2].y = tmpvar_7[1].z;
  tmpvar_8[2].z = tmpvar_7[2].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_6;
  mediump vec3 tmpvar_12;
  mediump vec4 normal;
  normal = tmpvar_11;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal);
  x1.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal);
  x1.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal);
  x1.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC);
  x3 = tmpvar_21;
  tmpvar_12 = ((x1 + x2) + x3);
  shlight = tmpvar_12;
  tmpvar_4 = shlight;
  highp vec3 tmpvar_22;
  tmpvar_22 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_23 * tmpvar_6.x) + (tmpvar_24 * tmpvar_6.y)) + (tmpvar_25 * tmpvar_6.z)) * inversesqrt (tmpvar_26))) * (1.0/((1.0 + (tmpvar_26 * unity_4LightAtten0)))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_4 + ((((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y)) + (unity_LightColor[2].xyz * tmpvar_27.z)) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_4 = tmpvar_28;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_8 * (((_World2Object * tmpvar_10).xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _Specular;
uniform highp float _Shininess;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
uniform sampler2D _BumpMap;
void main ()
{
  lowp vec4 c;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec3 nm;
  mediump vec4 tex;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_6;
  lowp vec3 normal;
  normal.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal.z = sqrt (((1.0 - (normal.x * normal.x)) - (normal.y * normal.y)));
  nm = normal;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (col.xyz, _Color.xyz, tmpvar_9);
  col.xyz = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = col.xyz;
  tmpvar_2 = tmpvar_12;
  tmpvar_3 = nm;
  highp float tmpvar_13;
  tmpvar_13 = (_Shininess * mask.y);
  tmpvar_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = col.w;
  tmpvar_5 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize (xlv_TEXCOORD3);
  mediump vec3 lightDir;
  lightDir = xlv_TEXCOORD1;
  mediump vec3 viewDir;
  viewDir = tmpvar_15;
  mediump vec4 c_i0;
  mediump float shininess;
  mediump vec3 nNormal;
  lowp vec3 tmpvar_16;
  tmpvar_16 = normalize (tmpvar_3);
  nNormal = tmpvar_16;
  lowp float tmpvar_17;
  tmpvar_17 = ((tmpvar_4 * 250.0) + 4.0);
  shininess = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (nNormal, lightDir));
  mediump float tmpvar_19;
  tmpvar_19 = (pow (max (0.0, dot (-(viewDir), reflect (lightDir, nNormal))), shininess) * mask.x);
  highp vec3 tmpvar_20;
  tmpvar_20 = (((tmpvar_2 * tmpvar_18) + (_Specular.xyz * tmpvar_19)) * _LightColor0.xyz);
  c_i0.xyz = tmpvar_20;
  c_i0.xyz = (c_i0.xyz * 2.0);
  c_i0.w = tmpvar_5;
  c = c_i0;
  c.xyz = (c.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  c.w = tmpvar_5;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 18 [unity_4LightAtten0]
Vector 19 [unity_LightColor0]
Vector 20 [unity_LightColor1]
Vector 21 [unity_LightColor2]
Vector 22 [unity_LightColor3]
Vector 23 [unity_SHAr]
Vector 24 [unity_SHAg]
Vector 25 [unity_SHAb]
Vector 26 [unity_SHBr]
Vector 27 [unity_SHBg]
Vector 28 [unity_SHBb]
Vector 29 [unity_SHC]
Vector 30 [_MainTex_ST]
"agal_vs
c31 1.0 0.0 0.0 0.0
[bc]
adaaaaaaadaaahacabaaaaoeaaaaaaaaamaaaappabaaaaaa mul r3.xyz, a1, c12.w
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.x, a0, c5
bfaaaaaaabaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.x, r0.x
abaaaaaaabaaapacabaaaaaaacaaaaaabaaaaaoeabaaaaaa add r1, r1.x, c16
bcaaaaaaadaaaiacadaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r3.w, r3.xyzz, c5
bcaaaaaaaeaaabacadaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r4.x, r3.xyzz, c4
bcaaaaaaadaaabacadaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r3.x, r3.xyzz, c6
adaaaaaaacaaapacadaaaappacaaaaaaabaaaaoeacaaaaaa mul r2, r3.w, r1
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bfaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r0.x, r0.x
abaaaaaaaaaaapacaaaaaaaaacaaaaaaapaaaaoeabaaaaaa add r0, r0.x, c15
adaaaaaaabaaapacabaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r1, r1, r1
aaaaaaaaaeaaaeacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r4.z, r3.x
adaaaaaaafaaapacaeaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r5, r4.x, r0
abaaaaaaacaaapacafaaaaoeacaaaaaaacaaaaoeacaaaaaa add r2, r5, r2
aaaaaaaaaeaaaiacbpaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r4.w, c31.x
bdaaaaaaaeaaacacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r4.y, a0, c6
adaaaaaaafaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r5, r0, r0
abaaaaaaabaaapacafaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r5, r1
bfaaaaaaaaaaacacaeaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r0.y, r4.y
abaaaaaaaaaaapacaaaaaaffacaaaaaabbaaaaoeabaaaaaa add r0, r0.y, c17
adaaaaaaafaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r5, r0, r0
abaaaaaaabaaapacafaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r5, r1
adaaaaaaaaaaapacadaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r0, r3.x, r0
abaaaaaaaaaaapacaaaaaaoeacaaaaaaacaaaaoeacaaaaaa add r0, r0, r2
adaaaaaaacaaapacabaaaaoeacaaaaaabcaaaaoeabaaaaaa mul r2, r1, c18
aaaaaaaaaeaaacacadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r4.y, r3.w
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
akaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rsq r1.y, r1.y
akaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r1.w, r1.w
akaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rsq r1.z, r1.z
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
abaaaaaaabaaapacacaaaaoeacaaaaaabpaaaaaaabaaaaaa add r1, r2, c31.x
bdaaaaaaacaaaeacaeaaaaoeacaaaaaabjaaaaoeabaaaaaa dp4 r2.z, r4, c25
bdaaaaaaacaaacacaeaaaaoeacaaaaaabiaaaaoeabaaaaaa dp4 r2.y, r4, c24
bdaaaaaaacaaabacaeaaaaoeacaaaaaabhaaaaoeabaaaaaa dp4 r2.x, r4, c23
afaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r1.x, r1.x
afaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rcp r1.y, r1.y
afaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rcp r1.w, r1.w
afaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rcp r1.z, r1.z
ahaaaaaaaaaaapacaaaaaaoeacaaaaaabpaaaaffabaaaaaa max r0, r0, c31.y
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
adaaaaaaabaaahacaaaaaaffacaaaaaabeaaaaoeabaaaaaa mul r1.xyz, r0.y, c20
adaaaaaaafaaahacaaaaaaaaacaaaaaabdaaaaoeabaaaaaa mul r5.xyz, r0.x, c19
abaaaaaaabaaahacafaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r5.xyzz, r1.xyzz
adaaaaaaaaaaahacaaaaaakkacaaaaaabfaaaaoeabaaaaaa mul r0.xyz, r0.z, c21
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaahacaaaaaappacaaaaaabgaaaaoeabaaaaaa mul r1.xyz, r0.w, c22
abaaaaaaabaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r1.xyz, r1.xyzz, r0.xyzz
adaaaaaaaaaaapacaeaaaakeacaaaaaaaeaaaacjacaaaaaa mul r0, r4.xyzz, r4.yzzx
adaaaaaaabaaaiacadaaaappacaaaaaaadaaaappacaaaaaa mul r1.w, r3.w, r3.w
bdaaaaaaadaaaeacaaaaaaoeacaaaaaabmaaaaoeabaaaaaa dp4 r3.z, r0, c28
bdaaaaaaadaaacacaaaaaaoeacaaaaaablaaaaoeabaaaaaa dp4 r3.y, r0, c27
bdaaaaaaadaaabacaaaaaaoeacaaaaaabkaaaaoeabaaaaaa dp4 r3.x, r0, c26
adaaaaaaafaaaiacaeaaaaaaacaaaaaaaeaaaaaaacaaaaaa mul r5.w, r4.x, r4.x
acaaaaaaabaaaiacafaaaappacaaaaaaabaaaappacaaaaaa sub r1.w, r5.w, r1.w
adaaaaaaaaaaahacabaaaappacaaaaaabnaaaaoeabaaaaaa mul r0.xyz, r1.w, c29
abaaaaaaacaaahacacaaaakeacaaaaaaadaaaakeacaaaaaa add r2.xyz, r2.xyzz, r3.xyzz
abaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaacaaahaeaaaaaakeacaaaaaaabaaaakeacaaaaaa add v2.xyz, r0.xyzz, r1.xyzz
aaaaaaaaabaaaiacbpaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r1.w, c31.x
aaaaaaaaabaaahacanaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, c13
bdaaaaaaaaaaaeacabaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r0.z, r1, c10
bdaaaaaaaaaaacacabaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r0.y, r1, c9
bdaaaaaaaaaaabacabaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r0.x, r1, c8
adaaaaaaafaaahacaaaaaakeacaaaaaaamaaaappabaaaaaa mul r5.xyz, r0.xyzz, c12.w
acaaaaaaadaaahacafaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r5.xyzz, a0
aaaaaaaaabaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, a5
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaabaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r1.yzxx
adaaaaaaafaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r5.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacafaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r5.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaaeaaaeacaoaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c14, r0
aaaaaaaaabaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c9
aaaaaaaaaaaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c8
bdaaaaaaaeaaacacaoaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.y, c14, r1
bdaaaaaaaeaaabacaoaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.x, c14, r0
bcaaaaaaabaaacaeaeaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v1.y, r4.xyzz, r2.xyzz
bcaaaaaaadaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v3.y, r2.xyzz, r3.xyzz
bcaaaaaaabaaaeaeabaaaaoeaaaaaaaaaeaaaakeacaaaaaa dp3 v1.z, a1, r4.xyzz
bcaaaaaaabaaabaeaeaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v1.x, r4.xyzz, a5
bcaaaaaaadaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v3.z, a1, r3.xyzz
bcaaaaaaadaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v3.x, a5, r3.xyzz
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
adaaaaaaafaaadacadaaaaoeaaaaaaaaboaaaaoeabaaaaaa mul r5.xy, a3, c30
abaaaaaaaaaaadaeafaaaafeacaaaaaaboaaaaooabaaaaaa add v0.xy, r5.xyyy, c30.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

}
Program "fp" {
// Fragment combos: 2
//   opengl - ALU: 12 to 37, TEX: 3 to 3
//   d3d9 - ALU: 10 to 38, TEX: 3 to 3
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 37 ALU, 3 TEX
PARAM c[6] = { program.local[0..3],
		{ 2, 1, 0, 250 },
		{ 4, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1.xyz, fragment.texcoord[0], texture[2], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2.yw, fragment.texcoord[0], texture[1], 2D;
MAD R2.xy, R2.wyzw, c[4].x, -c[4].y;
MUL R1.w, R2.y, R2.y;
MAD R1.w, -R2.x, R2.x, -R1;
MUL R0.xyz, fragment.color.primary, R0;
ADD R3.xyz, -R0, c[1];
MUL R3.xyz, R1.z, R3;
ADD R1.w, R1, c[4].y;
RSQ R1.w, R1.w;
RCP R2.z, R1.w;
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
MUL R2.xyz, R1.w, R2;
DP3 R1.z, R2, fragment.texcoord[1];
MUL R2.xyz, R2, R1.z;
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
MAD R0.xyz, R3, c[5].y, R0;
RSQ R1.w, R1.w;
MAD R4.xyz, -R2, c[4].x, fragment.texcoord[1];
MUL R2.xyz, R1.w, fragment.texcoord[3];
DP3 R1.w, -R2, R4;
MAX R2.x, R1.w, c[4].z;
MAX R1.z, R1, c[4];
MOV R1.w, c[5].x;
MUL R1.y, R1, c[3].x;
MAD R1.y, R1, c[4].w, R1.w;
POW R1.y, R2.x, R1.y;
MUL R2.xyz, R0, R1.z;
MUL R1.x, R1.y, R1;
MAD R1.xyz, R1.x, c[2], R2;
MUL R2.xyz, R0, fragment.texcoord[2];
MUL R1.xyz, R1, c[0];
MUL R0.x, fragment.color.primary.w, c[1].w;
MAD result.color.xyz, R1, c[4].x, R2;
MUL result.color.w, R0.x, R0;
END
# 37 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
"ps_2_0
; 38 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c5, 250.00000000, 4.00000000, 0.50000000, 0
dcl t0.xy
dcl v0
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r0, t0, s1
texld r3, t0, s0
texld r4, t0, s2
mov r0.x, r0.w
mad_pp r1.xy, r0, c4.x, c4.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.x, -r1, r1, -r0
add_pp r0.x, r0, c4.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
dp3_pp r0.x, r1, r1
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r1
dp3_pp r0.x, r1, t1
mul_pp r2.xyz, r1, r0.x
dp3_pp r1.x, t3, t3
rsq_pp r1.x, r1.x
mad_pp r2.xyz, -r2, c4.x, t1
mul_pp r1.xyz, r1.x, t3
dp3_pp r1.x, -r1, r2
mul r2.x, r4.y, c3
max_pp r1.x, r1, c4.w
mad_pp r2.x, r2, c5, c5.y
pow_pp r5.x, r1.x, r2.x
mul r2.xyz, v0, r3
add_pp r3.xyz, -r2, c1
mul_pp r3.xyz, r4.z, r3
mad_pp r2.xyz, r3, c5.z, r2
max_pp r0.x, r0, c4.w
mul_pp r3.xyz, r2, r0.x
mov_pp r1.x, r5.x
mul_pp r0.x, r1, r4
mad r0.xyz, r0.x, c2, r3
mul r1.xyz, r0, c0
mul_pp r2.xyz, r2, t2
mul r0.x, v0.w, c1.w
mad_pp r1.xyz, r1, c4.x, r2
mul r1.w, r0.x, r3
mov_pp oC0, r1
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
"agal_ps
c4 2.0 -1.0 1.0 0.0
c5 250.0 4.0 0.5 0.0
[bc]
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r0, v0, s1 <2d wrap linear point>
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
ciaaaaaaaeaaapacaaaaaaoeaeaaaaaaacaaaaaaafaababb tex r4, v0, s2 <2d wrap linear point>
aaaaaaaaaaaaabacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r0.w
adaaaaaaabaaadacaaaaaafeacaaaaaaaeaaaaaaabaaaaaa mul r1.xy, r0.xyyy, c4.x
abaaaaaaabaaadacabaaaafeacaaaaaaaeaaaaffabaaaaaa add r1.xy, r1.xyyy, c4.y
adaaaaaaaaaaabacabaaaaffacaaaaaaabaaaaffacaaaaaa mul r0.x, r1.y, r1.y
bfaaaaaaacaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r2.x, r1.x
adaaaaaaacaaabacacaaaaaaacaaaaaaabaaaaaaacaaaaaa mul r2.x, r2.x, r1.x
acaaaaaaaaaaabacacaaaaaaacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r2.x, r0.x
abaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaakkabaaaaaa add r0.x, r0.x, c4.z
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
afaaaaaaabaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r1.z, r0.x
bcaaaaaaaaaaabacabaaaakeacaaaaaaabaaaakeacaaaaaa dp3 r0.x, r1.xyzz, r1.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaabaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.x, r1.xyzz
bcaaaaaaaaaaabacabaaaakeacaaaaaaabaaaaoeaeaaaaaa dp3 r0.x, r1.xyzz, v1
adaaaaaaacaaahacabaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r2.xyz, r1.xyzz, r0.x
bcaaaaaaabaaabacadaaaaoeaeaaaaaaadaaaaoeaeaaaaaa dp3 r1.x, v3, v3
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
bfaaaaaaacaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r2.xyz, r2.xyzz
adaaaaaaacaaahacacaaaakeacaaaaaaaeaaaaaaabaaaaaa mul r2.xyz, r2.xyzz, c4.x
abaaaaaaacaaahacacaaaakeacaaaaaaabaaaaoeaeaaaaaa add r2.xyz, r2.xyzz, v1
adaaaaaaabaaahacabaaaaaaacaaaaaaadaaaaoeaeaaaaaa mul r1.xyz, r1.x, v3
bfaaaaaaafaaahacabaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r5.xyz, r1.xyzz
bcaaaaaaabaaabacafaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r1.x, r5.xyzz, r2.xyzz
adaaaaaaacaaabacaeaaaaffacaaaaaaadaaaaoeabaaaaaa mul r2.x, r4.y, c3
ahaaaaaaabaaabacabaaaaaaacaaaaaaaeaaaappabaaaaaa max r1.x, r1.x, c4.w
adaaaaaaacaaabacacaaaaaaacaaaaaaafaaaaoeabaaaaaa mul r2.x, r2.x, c5
abaaaaaaacaaabacacaaaaaaacaaaaaaafaaaaffabaaaaaa add r2.x, r2.x, c5.y
alaaaaaaafaaapacabaaaaaaacaaaaaaacaaaaaaacaaaaaa pow r5, r1.x, r2.x
adaaaaaaacaaahacahaaaaoeaeaaaaaaadaaaakeacaaaaaa mul r2.xyz, v7, r3.xyzz
bfaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r3.xyz, r2.xyzz
abaaaaaaadaaahacadaaaakeacaaaaaaabaaaaoeabaaaaaa add r3.xyz, r3.xyzz, c1
adaaaaaaadaaahacaeaaaakkacaaaaaaadaaaakeacaaaaaa mul r3.xyz, r4.z, r3.xyzz
adaaaaaaagaaahacadaaaakeacaaaaaaafaaaakkabaaaaaa mul r6.xyz, r3.xyzz, c5.z
abaaaaaaacaaahacagaaaakeacaaaaaaacaaaakeacaaaaaa add r2.xyz, r6.xyzz, r2.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaappabaaaaaa max r0.x, r0.x, c4.w
adaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r3.xyz, r2.xyzz, r0.x
aaaaaaaaabaaabacafaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r5.x
adaaaaaaaaaaabacabaaaaaaacaaaaaaaeaaaaaaacaaaaaa mul r0.x, r1.x, r4.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaaoeabaaaaaa mul r0.xyz, r0.x, c2
abaaaaaaaaaaahacaaaaaakeacaaaaaaadaaaakeacaaaaaa add r0.xyz, r0.xyzz, r3.xyzz
adaaaaaaabaaahacaaaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r0.xyzz, c0
adaaaaaaacaaahacacaaaakeacaaaaaaacaaaaoeaeaaaaaa mul r2.xyz, r2.xyzz, v2
adaaaaaaaaaaabacahaaaappaeaaaaaaabaaaappabaaaaaa mul r0.x, v7.w, c1.w
adaaaaaaabaaahacabaaaakeacaaaaaaaeaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c4.x
abaaaaaaabaaahacabaaaakeacaaaaaaacaaaakeacaaaaaa add r1.xyz, r1.xyzz, r2.xyzz
adaaaaaaabaaaiacaaaaaaaaacaaaaaaadaaaappacaaaaaa mul r1.w, r0.x, r3.w
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.5, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[3], 2D;
TEX R2.z, fragment.texcoord[0], texture[2], 2D;
MUL R2.xyw, fragment.color.primary.xyzz, R0.xyzz;
ADD R0.xyz, -R2.xyww, c[0];
MUL R0.xyz, R2.z, R0;
MAD R0.xyz, R0, c[1].x, R2.xyww;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, R0;
MUL R0.x, fragment.color.primary.w, c[0].w;
MUL result.color.xyz, R1, c[1].y;
MUL result.color.w, R0.x, R0;
END
# 12 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [unity_Lightmap] 2D
"ps_2_0
; 10 ALU, 3 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s3
def c1, 0.50000000, 8.00000000, 0, 0
dcl t0.xy
dcl v0
dcl t1.xy
texld r1, t0, s2
texld r0, t1, s3
texld r2, t0, s0
mul r2.xyz, v0, r2
mul_pp r0.xyz, r0.w, r0
add_pp r3.xyz, -r2, c0
mul_pp r1.xyz, r1.z, r3
mad_pp r1.xyz, r1, c1.x, r2
mul_pp r0.xyz, r0, r1
mul r1.x, v0.w, c0.w
mul_pp r0.xyz, r0, c1.y
mul r0.w, r1.x, r2
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [unity_Lightmap] 2D
"agal_ps
c1 0.5 8.0 0.0 0.0
[bc]
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaacaaaaaaafaababb tex r1, v0, s2 <2d wrap linear point>
ciaaaaaaaaaaapacabaaaaoeaeaaaaaaadaaaaaaafaababb tex r0, v1, s3 <2d wrap linear point>
ciaaaaaaacaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r2, v0, s0 <2d wrap linear point>
adaaaaaaacaaahacahaaaaoeaeaaaaaaacaaaakeacaaaaaa mul r2.xyz, v7, r2.xyzz
adaaaaaaaaaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r0.w, r0.xyzz
bfaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r3.xyz, r2.xyzz
abaaaaaaadaaahacadaaaakeacaaaaaaaaaaaaoeabaaaaaa add r3.xyz, r3.xyzz, c0
adaaaaaaabaaahacabaaaakkacaaaaaaadaaaakeacaaaaaa mul r1.xyz, r1.z, r3.xyzz
adaaaaaaabaaahacabaaaakeacaaaaaaabaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c1.x
abaaaaaaabaaahacabaaaakeacaaaaaaacaaaakeacaaaaaa add r1.xyz, r1.xyzz, r2.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaabacahaaaappaeaaaaaaaaaaaappabaaaaaa mul r1.x, v7.w, c0.w
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c1.y
adaaaaaaaaaaaiacabaaaaaaacaaaaaaacaaaappacaaaaaa mul r0.w, r1.x, r2.w
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

}
	}
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardAdd" }
		ZWrite Off Blend One One Fog { Color (0,0,0,0) }
		Blend SrcAlpha One
Program "vp" {
// Vertex combos: 5
//   opengl - ALU: 26 to 35
//   d3d9 - ALU: 29 to 38
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 20 [_MainTex_ST]
"!!ARBvp1.0
# 34 ALU
PARAM c[21] = { { 1 },
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
MOV result.color, vertex.color;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 34 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
"vs_2_0
; 37 ALU
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
mov r0.w, c20.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
mad r0.xyz, r4, c16.w, -v0
dp3 oT1.y, r0, r2
dp3 oT1.z, v2, r0
dp3 oT1.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT2.y, r2, r3
dp3 oT2.z, v2, r3
dp3 oT2.x, v1, r3
mov oD0, v4
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
mad oT0.xy, v3, c19, c19.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "POINT" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize (_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize (_glesNormal);
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = tmpvar_1.xyz;
  tmpvar_5[1] = (cross (tmpvar_2, tmpvar_1.xyz) * _glesTANGENT.w);
  tmpvar_5[2] = tmpvar_2;
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5[0].x;
  tmpvar_6[0].y = tmpvar_5[1].x;
  tmpvar_6[0].z = tmpvar_5[2].x;
  tmpvar_6[1].x = tmpvar_5[0].y;
  tmpvar_6[1].y = tmpvar_5[1].y;
  tmpvar_6[1].z = tmpvar_5[2].y;
  tmpvar_6[2].x = tmpvar_5[0].z;
  tmpvar_6[2].y = tmpvar_5[1].z;
  tmpvar_6[2].z = tmpvar_5[2].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * (((_World2Object * tmpvar_8).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _Specular;
uniform highp float _Shininess;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
uniform sampler2D _BumpMap;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec3 nm;
  mediump vec4 tex;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  nm = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (col.xyz, _Color.xyz, tmpvar_10);
  col.xyz = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = col.xyz;
  tmpvar_2 = tmpvar_13;
  tmpvar_3 = nm;
  highp float tmpvar_14;
  tmpvar_14 = (_Shininess * mask.y);
  tmpvar_4 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = col.w;
  tmpvar_5 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize (xlv_TEXCOORD1);
  lightDir = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3));
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_LightTexture0, tmpvar_17);
  mediump vec3 lightDir_i0;
  lightDir_i0 = lightDir;
  mediump float atten;
  atten = tmpvar_18.w;
  mediump vec4 c_i0;
  mediump float shininess;
  mediump vec3 nNormal;
  lowp vec3 tmpvar_19;
  tmpvar_19 = normalize (tmpvar_3);
  nNormal = tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_20 = ((tmpvar_4 * 250.0) + 4.0);
  shininess = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = normalize (lightDir_i0);
  lightDir_i0 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = max (0.0, dot (nNormal, tmpvar_21));
  mediump float tmpvar_23;
  tmpvar_23 = (pow (max (0.0, dot (-(normalize (xlv_TEXCOORD2)), reflect (tmpvar_21, nNormal))), shininess) * mask.x);
  highp vec3 tmpvar_24;
  tmpvar_24 = (((tmpvar_2 * tmpvar_22) + (_Specular.xyz * tmpvar_23)) * _LightColor0.xyz);
  c_i0.xyz = tmpvar_24;
  c_i0.xyz = (c_i0.xyz * (atten * 2.0));
  c_i0.w = tmpvar_5;
  c = c_i0;
  c.w = tmpvar_5;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize (_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize (_glesNormal);
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = tmpvar_1.xyz;
  tmpvar_5[1] = (cross (tmpvar_2, tmpvar_1.xyz) * _glesTANGENT.w);
  tmpvar_5[2] = tmpvar_2;
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5[0].x;
  tmpvar_6[0].y = tmpvar_5[1].x;
  tmpvar_6[0].z = tmpvar_5[2].x;
  tmpvar_6[1].x = tmpvar_5[0].y;
  tmpvar_6[1].y = tmpvar_5[1].y;
  tmpvar_6[1].z = tmpvar_5[2].y;
  tmpvar_6[2].x = tmpvar_5[0].z;
  tmpvar_6[2].y = tmpvar_5[1].z;
  tmpvar_6[2].z = tmpvar_5[2].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * (((_World2Object * tmpvar_8).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _Specular;
uniform highp float _Shininess;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
uniform sampler2D _BumpMap;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec3 nm;
  mediump vec4 tex;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_6;
  lowp vec3 normal;
  normal.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal.z = sqrt (((1.0 - (normal.x * normal.x)) - (normal.y * normal.y)));
  nm = normal;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (col.xyz, _Color.xyz, tmpvar_9);
  col.xyz = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = col.xyz;
  tmpvar_2 = tmpvar_12;
  tmpvar_3 = nm;
  highp float tmpvar_13;
  tmpvar_13 = (_Shininess * mask.y);
  tmpvar_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = col.w;
  tmpvar_5 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize (xlv_TEXCOORD1);
  lightDir = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_LightTexture0, tmpvar_16);
  mediump vec3 lightDir_i0;
  lightDir_i0 = lightDir;
  mediump float atten;
  atten = tmpvar_17.w;
  mediump vec4 c_i0;
  mediump float shininess;
  mediump vec3 nNormal;
  lowp vec3 tmpvar_18;
  tmpvar_18 = normalize (tmpvar_3);
  nNormal = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = ((tmpvar_4 * 250.0) + 4.0);
  shininess = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = normalize (lightDir_i0);
  lightDir_i0 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = max (0.0, dot (nNormal, tmpvar_20));
  mediump float tmpvar_22;
  tmpvar_22 = (pow (max (0.0, dot (-(normalize (xlv_TEXCOORD2)), reflect (tmpvar_20, nNormal))), shininess) * mask.x);
  highp vec3 tmpvar_23;
  tmpvar_23 = (((tmpvar_2 * tmpvar_21) + (_Specular.xyz * tmpvar_22)) * _LightColor0.xyz);
  c_i0.xyz = tmpvar_23;
  c_i0.xyz = (c_i0.xyz * (atten * 2.0));
  c_i0.w = tmpvar_5;
  c = c_i0;
  c.w = tmpvar_5;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
"agal_vs
c20 1.0 0.0 0.0 0.0
[bc]
aaaaaaaaaaaaaiacbeaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c20.x
aaaaaaaaaaaaahacbbaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c17
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r1.z, r0, c10
bdaaaaaaabaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r1.y, r0, c9
bdaaaaaaabaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r1.x, r0, c8
adaaaaaaacaaahacabaaaakeacaaaaaabaaaaappabaaaaaa mul r2.xyz, r1.xyzz, c16.w
acaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r2.xyzz, a0
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaaaaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r0.yzxx
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaaeaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r4.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacaeaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r4.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaaeaaaeacbcaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c18, r0
aaaaaaaaaaaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c9
bdaaaaaaaeaaacacbcaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.y, c18, r0
aaaaaaaaabaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c8
bdaaaaaaaeaaabacbcaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.x, c18, r1
adaaaaaaabaaahacaeaaaakeacaaaaaabaaaaappabaaaaaa mul r1.xyz, r4.xyzz, c16.w
acaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r0.xyz, r1.xyzz, a0
bcaaaaaaabaaacaeaaaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v1.y, r0.xyzz, r2.xyzz
bcaaaaaaabaaaeaeabaaaaoeaaaaaaaaaaaaaakeacaaaaaa dp3 v1.z, a1, r0.xyzz
bcaaaaaaabaaabaeaaaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v1.x, r0.xyzz, a5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bcaaaaaaacaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v2.y, r2.xyzz, r3.xyzz
bcaaaaaaacaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v2.z, a1, r3.xyzz
bcaaaaaaacaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v2.x, a5, r3.xyzz
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
bdaaaaaaadaaaeaeaaaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 v3.z, r0, c14
bdaaaaaaadaaacaeaaaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 v3.y, r0, c13
bdaaaaaaadaaabaeaaaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 v3.x, r0, c12
adaaaaaaaaaaadacadaaaaoeaaaaaaaabdaaaaoeabaaaaaa mul r0.xy, a3, c19
abaaaaaaaaaaadaeaaaaaafeacaaaaaabdaaaaooabaaaaaa add v0.xy, r0.xyyy, c19.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 9 [unity_Scale]
Vector 10 [_WorldSpaceCameraPos]
Vector 11 [_WorldSpaceLightPos0]
Matrix 5 [_World2Object]
Vector 12 [_MainTex_ST]
"!!ARBvp1.0
# 26 ALU
PARAM c[13] = { { 1 },
		state.matrix.mvp,
		program.local[5..12] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[10];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[7];
DP4 R2.y, R1, c[6];
DP4 R2.x, R1, c[5];
MAD R2.xyz, R2, c[9].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[11];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[7];
DP4 R3.y, R0, c[6];
DP4 R3.x, R0, c[5];
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[12], c[12].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 26 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_Scale]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Matrix 4 [_World2Object]
Vector 11 [_MainTex_ST]
"vs_2_0
; 29 ALU
def c12, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
mov r0.w, c12.x
mov r0.xyz, c9
dp4 r1.z, r0, c6
dp4 r1.y, r0, c5
dp4 r1.x, r0, c4
mad r3.xyz, r1, c8.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c6
dp4 r4.z, c10, r0
mov r0, c5
mov r1, c4
dp4 r4.y, c10, r0
dp4 r4.x, c10, r1
dp3 oT1.y, r4, r2
dp3 oT2.y, r2, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
dp3 oT2.z, v2, r3
dp3 oT2.x, v1, r3
mov oD0, v4
mad oT0.xy, v3, c11, c11.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize (_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize (_glesNormal);
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = tmpvar_1.xyz;
  tmpvar_5[1] = (cross (tmpvar_2, tmpvar_1.xyz) * _glesTANGENT.w);
  tmpvar_5[2] = tmpvar_2;
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5[0].x;
  tmpvar_6[0].y = tmpvar_5[1].x;
  tmpvar_6[0].z = tmpvar_5[2].x;
  tmpvar_6[1].x = tmpvar_5[0].y;
  tmpvar_6[1].y = tmpvar_5[1].y;
  tmpvar_6[1].z = tmpvar_5[2].y;
  tmpvar_6[2].x = tmpvar_5[0].z;
  tmpvar_6[2].y = tmpvar_5[1].z;
  tmpvar_6[2].z = tmpvar_5[2].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * (((_World2Object * tmpvar_8).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _Specular;
uniform highp float _Shininess;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
uniform sampler2D _BumpMap;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec3 nm;
  mediump vec4 tex;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  nm = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (col.xyz, _Color.xyz, tmpvar_10);
  col.xyz = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = col.xyz;
  tmpvar_2 = tmpvar_13;
  tmpvar_3 = nm;
  highp float tmpvar_14;
  tmpvar_14 = (_Shininess * mask.y);
  tmpvar_4 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = col.w;
  tmpvar_5 = tmpvar_15;
  lightDir = xlv_TEXCOORD1;
  mediump vec3 lightDir_i0;
  lightDir_i0 = lightDir;
  mediump vec4 c_i0;
  mediump float shininess;
  mediump vec3 nNormal;
  lowp vec3 tmpvar_16;
  tmpvar_16 = normalize (tmpvar_3);
  nNormal = tmpvar_16;
  lowp float tmpvar_17;
  tmpvar_17 = ((tmpvar_4 * 250.0) + 4.0);
  shininess = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (nNormal, lightDir_i0));
  mediump float tmpvar_19;
  tmpvar_19 = (pow (max (0.0, dot (-(normalize (xlv_TEXCOORD2)), reflect (lightDir_i0, nNormal))), shininess) * mask.x);
  highp vec3 tmpvar_20;
  tmpvar_20 = (((tmpvar_2 * tmpvar_18) + (_Specular.xyz * tmpvar_19)) * _LightColor0.xyz);
  c_i0.xyz = tmpvar_20;
  c_i0.xyz = (c_i0.xyz * 2.0);
  c_i0.w = tmpvar_5;
  c = c_i0;
  c.w = tmpvar_5;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize (_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize (_glesNormal);
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = tmpvar_1.xyz;
  tmpvar_5[1] = (cross (tmpvar_2, tmpvar_1.xyz) * _glesTANGENT.w);
  tmpvar_5[2] = tmpvar_2;
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5[0].x;
  tmpvar_6[0].y = tmpvar_5[1].x;
  tmpvar_6[0].z = tmpvar_5[2].x;
  tmpvar_6[1].x = tmpvar_5[0].y;
  tmpvar_6[1].y = tmpvar_5[1].y;
  tmpvar_6[1].z = tmpvar_5[2].y;
  tmpvar_6[2].x = tmpvar_5[0].z;
  tmpvar_6[2].y = tmpvar_5[1].z;
  tmpvar_6[2].z = tmpvar_5[2].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * (((_World2Object * tmpvar_8).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _Specular;
uniform highp float _Shininess;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
uniform sampler2D _BumpMap;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec3 nm;
  mediump vec4 tex;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_6;
  lowp vec3 normal;
  normal.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal.z = sqrt (((1.0 - (normal.x * normal.x)) - (normal.y * normal.y)));
  nm = normal;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (col.xyz, _Color.xyz, tmpvar_9);
  col.xyz = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = col.xyz;
  tmpvar_2 = tmpvar_12;
  tmpvar_3 = nm;
  highp float tmpvar_13;
  tmpvar_13 = (_Shininess * mask.y);
  tmpvar_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = col.w;
  tmpvar_5 = tmpvar_14;
  lightDir = xlv_TEXCOORD1;
  mediump vec3 lightDir_i0;
  lightDir_i0 = lightDir;
  mediump vec4 c_i0;
  mediump float shininess;
  mediump vec3 nNormal;
  lowp vec3 tmpvar_15;
  tmpvar_15 = normalize (tmpvar_3);
  nNormal = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = ((tmpvar_4 * 250.0) + 4.0);
  shininess = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (nNormal, lightDir_i0));
  mediump float tmpvar_18;
  tmpvar_18 = (pow (max (0.0, dot (-(normalize (xlv_TEXCOORD2)), reflect (lightDir_i0, nNormal))), shininess) * mask.x);
  highp vec3 tmpvar_19;
  tmpvar_19 = (((tmpvar_2 * tmpvar_17) + (_Specular.xyz * tmpvar_18)) * _LightColor0.xyz);
  c_i0.xyz = tmpvar_19;
  c_i0.xyz = (c_i0.xyz * 2.0);
  c_i0.w = tmpvar_5;
  c = c_i0;
  c.w = tmpvar_5;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_Scale]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Matrix 4 [_World2Object]
Vector 11 [_MainTex_ST]
"agal_vs
c12 1.0 0.0 0.0 0.0
[bc]
aaaaaaaaaaaaaiacamaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c12.x
aaaaaaaaaaaaahacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c9
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaagaaaaoeabaaaaaa dp4 r1.z, r0, c6
bdaaaaaaabaaacacaaaaaaoeacaaaaaaafaaaaoeabaaaaaa dp4 r1.y, r0, c5
bdaaaaaaabaaabacaaaaaaoeacaaaaaaaeaaaaoeabaaaaaa dp4 r1.x, r0, c4
adaaaaaaacaaahacabaaaakeacaaaaaaaiaaaappabaaaaaa mul r2.xyz, r1.xyzz, c8.w
acaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r2.xyzz, a0
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaaaaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r0.yzxx
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaaeaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r4.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacaeaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r4.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaaaaaapacagaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c6
bdaaaaaaaeaaaeacakaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c10, r0
aaaaaaaaaaaaapacafaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c5
aaaaaaaaabaaapacaeaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c4
bdaaaaaaaeaaacacakaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.y, c10, r0
bdaaaaaaaeaaabacakaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.x, c10, r1
bcaaaaaaabaaacaeaeaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v1.y, r4.xyzz, r2.xyzz
bcaaaaaaacaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v2.y, r2.xyzz, r3.xyzz
bcaaaaaaabaaaeaeabaaaaoeaaaaaaaaaeaaaakeacaaaaaa dp3 v1.z, a1, r4.xyzz
bcaaaaaaabaaabaeaeaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v1.x, r4.xyzz, a5
bcaaaaaaacaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v2.z, a1, r3.xyzz
bcaaaaaaacaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v2.x, a5, r3.xyzz
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
adaaaaaaaaaaadacadaaaaoeaaaaaaaaalaaaaoeabaaaaaa mul r0.xy, a3, c11
abaaaaaaaaaaadaeaaaaaafeacaaaaaaalaaaaooabaaaaaa add v0.xy, r0.xyyy, c11.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 20 [_MainTex_ST]
"!!ARBvp1.0
# 35 ALU
PARAM c[21] = { { 1 },
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
MOV result.color, vertex.color;
DP4 result.texcoord[3].w, R0, c[16];
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
"vs_2_0
; 38 ALU
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
mov r0.w, c20.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
mad r0.xyz, r4, c16.w, -v0
dp4 r0.w, v0, c7
dp3 oT1.y, r0, r2
dp3 oT1.z, v2, r0
dp3 oT1.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT2.y, r2, r3
dp3 oT2.z, v2, r3
dp3 oT2.x, v1, r3
mov oD0, v4
dp4 oT3.w, r0, c15
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
mad oT0.xy, v3, c19, c19.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize (_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize (_glesNormal);
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = tmpvar_1.xyz;
  tmpvar_5[1] = (cross (tmpvar_2, tmpvar_1.xyz) * _glesTANGENT.w);
  tmpvar_5[2] = tmpvar_2;
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5[0].x;
  tmpvar_6[0].y = tmpvar_5[1].x;
  tmpvar_6[0].z = tmpvar_5[2].x;
  tmpvar_6[1].x = tmpvar_5[0].y;
  tmpvar_6[1].y = tmpvar_5[1].y;
  tmpvar_6[1].z = tmpvar_5[2].y;
  tmpvar_6[2].x = tmpvar_5[0].z;
  tmpvar_6[2].y = tmpvar_5[1].z;
  tmpvar_6[2].z = tmpvar_5[2].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * (((_World2Object * tmpvar_8).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _Specular;
uniform highp float _Shininess;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
uniform sampler2D _BumpMap;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec3 nm;
  mediump vec4 tex;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  nm = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (col.xyz, _Color.xyz, tmpvar_10);
  col.xyz = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = col.xyz;
  tmpvar_2 = tmpvar_13;
  tmpvar_3 = nm;
  highp float tmpvar_14;
  tmpvar_14 = (_Shininess * mask.y);
  tmpvar_4 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = col.w;
  tmpvar_5 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize (xlv_TEXCOORD1);
  lightDir = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5));
  highp vec3 LightCoord_i0;
  LightCoord_i0 = xlv_TEXCOORD3.xyz;
  highp vec2 tmpvar_18;
  tmpvar_18 = vec2(dot (LightCoord_i0, LightCoord_i0));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_LightTextureB0, tmpvar_18);
  mediump vec3 lightDir_i0;
  lightDir_i0 = lightDir;
  mediump float atten;
  atten = ((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_17.w) * tmpvar_19.w);
  mediump vec4 c_i0;
  mediump float shininess;
  mediump vec3 nNormal;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize (tmpvar_3);
  nNormal = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = ((tmpvar_4 * 250.0) + 4.0);
  shininess = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = normalize (lightDir_i0);
  lightDir_i0 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = max (0.0, dot (nNormal, tmpvar_22));
  mediump float tmpvar_24;
  tmpvar_24 = (pow (max (0.0, dot (-(normalize (xlv_TEXCOORD2)), reflect (tmpvar_22, nNormal))), shininess) * mask.x);
  highp vec3 tmpvar_25;
  tmpvar_25 = (((tmpvar_2 * tmpvar_23) + (_Specular.xyz * tmpvar_24)) * _LightColor0.xyz);
  c_i0.xyz = tmpvar_25;
  c_i0.xyz = (c_i0.xyz * (atten * 2.0));
  c_i0.w = tmpvar_5;
  c = c_i0;
  c.w = tmpvar_5;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize (_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize (_glesNormal);
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = tmpvar_1.xyz;
  tmpvar_5[1] = (cross (tmpvar_2, tmpvar_1.xyz) * _glesTANGENT.w);
  tmpvar_5[2] = tmpvar_2;
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5[0].x;
  tmpvar_6[0].y = tmpvar_5[1].x;
  tmpvar_6[0].z = tmpvar_5[2].x;
  tmpvar_6[1].x = tmpvar_5[0].y;
  tmpvar_6[1].y = tmpvar_5[1].y;
  tmpvar_6[1].z = tmpvar_5[2].y;
  tmpvar_6[2].x = tmpvar_5[0].z;
  tmpvar_6[2].y = tmpvar_5[1].z;
  tmpvar_6[2].z = tmpvar_5[2].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * (((_World2Object * tmpvar_8).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _Specular;
uniform highp float _Shininess;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
uniform sampler2D _BumpMap;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec3 nm;
  mediump vec4 tex;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_6;
  lowp vec3 normal;
  normal.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal.z = sqrt (((1.0 - (normal.x * normal.x)) - (normal.y * normal.y)));
  nm = normal;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (col.xyz, _Color.xyz, tmpvar_9);
  col.xyz = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = col.xyz;
  tmpvar_2 = tmpvar_12;
  tmpvar_3 = nm;
  highp float tmpvar_13;
  tmpvar_13 = (_Shininess * mask.y);
  tmpvar_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = col.w;
  tmpvar_5 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize (xlv_TEXCOORD1);
  lightDir = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5));
  highp vec3 LightCoord_i0;
  LightCoord_i0 = xlv_TEXCOORD3.xyz;
  highp vec2 tmpvar_17;
  tmpvar_17 = vec2(dot (LightCoord_i0, LightCoord_i0));
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_LightTextureB0, tmpvar_17);
  mediump vec3 lightDir_i0;
  lightDir_i0 = lightDir;
  mediump float atten;
  atten = ((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_16.w) * tmpvar_18.w);
  mediump vec4 c_i0;
  mediump float shininess;
  mediump vec3 nNormal;
  lowp vec3 tmpvar_19;
  tmpvar_19 = normalize (tmpvar_3);
  nNormal = tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_20 = ((tmpvar_4 * 250.0) + 4.0);
  shininess = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = normalize (lightDir_i0);
  lightDir_i0 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = max (0.0, dot (nNormal, tmpvar_21));
  mediump float tmpvar_23;
  tmpvar_23 = (pow (max (0.0, dot (-(normalize (xlv_TEXCOORD2)), reflect (tmpvar_21, nNormal))), shininess) * mask.x);
  highp vec3 tmpvar_24;
  tmpvar_24 = (((tmpvar_2 * tmpvar_22) + (_Specular.xyz * tmpvar_23)) * _LightColor0.xyz);
  c_i0.xyz = tmpvar_24;
  c_i0.xyz = (c_i0.xyz * (atten * 2.0));
  c_i0.w = tmpvar_5;
  c = c_i0;
  c.w = tmpvar_5;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
"agal_vs
c20 1.0 0.0 0.0 0.0
[bc]
aaaaaaaaaaaaaiacbeaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c20.x
aaaaaaaaaaaaahacbbaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c17
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r1.z, r0, c10
bdaaaaaaabaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r1.y, r0, c9
bdaaaaaaabaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r1.x, r0, c8
adaaaaaaacaaahacabaaaakeacaaaaaabaaaaappabaaaaaa mul r2.xyz, r1.xyzz, c16.w
acaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r2.xyzz, a0
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaaaaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r0.yzxx
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaaeaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r4.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacaeaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r4.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaaeaaaeacbcaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c18, r0
aaaaaaaaaaaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c9
bdaaaaaaaeaaacacbcaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.y, c18, r0
aaaaaaaaabaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c8
bdaaaaaaaeaaabacbcaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.x, c18, r1
adaaaaaaabaaahacaeaaaakeacaaaaaabaaaaappabaaaaaa mul r1.xyz, r4.xyzz, c16.w
acaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r0.xyz, r1.xyzz, a0
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bcaaaaaaabaaacaeaaaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v1.y, r0.xyzz, r2.xyzz
bcaaaaaaabaaaeaeabaaaaoeaaaaaaaaaaaaaakeacaaaaaa dp3 v1.z, a1, r0.xyzz
bcaaaaaaabaaabaeaaaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v1.x, r0.xyzz, a5
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bcaaaaaaacaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v2.y, r2.xyzz, r3.xyzz
bcaaaaaaacaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v2.z, a1, r3.xyzz
bcaaaaaaacaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v2.x, a5, r3.xyzz
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
bdaaaaaaadaaaiaeaaaaaaoeacaaaaaaapaaaaoeabaaaaaa dp4 v3.w, r0, c15
bdaaaaaaadaaaeaeaaaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 v3.z, r0, c14
bdaaaaaaadaaacaeaaaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 v3.y, r0, c13
bdaaaaaaadaaabaeaaaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 v3.x, r0, c12
adaaaaaaaaaaadacadaaaaoeaaaaaaaabdaaaaoeabaaaaaa mul r0.xy, a3, c19
abaaaaaaaaaaadaeaaaaaafeacaaaaaabdaaaaooabaaaaaa add v0.xy, r0.xyyy, c19.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 20 [_MainTex_ST]
"!!ARBvp1.0
# 34 ALU
PARAM c[21] = { { 1 },
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
MOV result.color, vertex.color;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 34 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
"vs_2_0
; 37 ALU
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
mov r0.w, c20.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
mad r0.xyz, r4, c16.w, -v0
dp3 oT1.y, r0, r2
dp3 oT1.z, v2, r0
dp3 oT1.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT2.y, r2, r3
dp3 oT2.z, v2, r3
dp3 oT2.x, v1, r3
mov oD0, v4
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
mad oT0.xy, v3, c19, c19.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize (_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize (_glesNormal);
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = tmpvar_1.xyz;
  tmpvar_5[1] = (cross (tmpvar_2, tmpvar_1.xyz) * _glesTANGENT.w);
  tmpvar_5[2] = tmpvar_2;
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5[0].x;
  tmpvar_6[0].y = tmpvar_5[1].x;
  tmpvar_6[0].z = tmpvar_5[2].x;
  tmpvar_6[1].x = tmpvar_5[0].y;
  tmpvar_6[1].y = tmpvar_5[1].y;
  tmpvar_6[1].z = tmpvar_5[2].y;
  tmpvar_6[2].x = tmpvar_5[0].z;
  tmpvar_6[2].y = tmpvar_5[1].z;
  tmpvar_6[2].z = tmpvar_5[2].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * (((_World2Object * tmpvar_8).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _Specular;
uniform highp float _Shininess;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
uniform sampler2D _BumpMap;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec3 nm;
  mediump vec4 tex;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  nm = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (col.xyz, _Color.xyz, tmpvar_10);
  col.xyz = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = col.xyz;
  tmpvar_2 = tmpvar_13;
  tmpvar_3 = nm;
  highp float tmpvar_14;
  tmpvar_14 = (_Shininess * mask.y);
  tmpvar_4 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = col.w;
  tmpvar_5 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize (xlv_TEXCOORD1);
  lightDir = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3));
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_LightTextureB0, tmpvar_17);
  lowp vec4 tmpvar_19;
  tmpvar_19 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  mediump vec3 lightDir_i0;
  lightDir_i0 = lightDir;
  mediump float atten;
  atten = (tmpvar_18.w * tmpvar_19.w);
  mediump vec4 c_i0;
  mediump float shininess;
  mediump vec3 nNormal;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize (tmpvar_3);
  nNormal = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = ((tmpvar_4 * 250.0) + 4.0);
  shininess = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = normalize (lightDir_i0);
  lightDir_i0 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = max (0.0, dot (nNormal, tmpvar_22));
  mediump float tmpvar_24;
  tmpvar_24 = (pow (max (0.0, dot (-(normalize (xlv_TEXCOORD2)), reflect (tmpvar_22, nNormal))), shininess) * mask.x);
  highp vec3 tmpvar_25;
  tmpvar_25 = (((tmpvar_2 * tmpvar_23) + (_Specular.xyz * tmpvar_24)) * _LightColor0.xyz);
  c_i0.xyz = tmpvar_25;
  c_i0.xyz = (c_i0.xyz * (atten * 2.0));
  c_i0.w = tmpvar_5;
  c = c_i0;
  c.w = tmpvar_5;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize (_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize (_glesNormal);
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = tmpvar_1.xyz;
  tmpvar_5[1] = (cross (tmpvar_2, tmpvar_1.xyz) * _glesTANGENT.w);
  tmpvar_5[2] = tmpvar_2;
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5[0].x;
  tmpvar_6[0].y = tmpvar_5[1].x;
  tmpvar_6[0].z = tmpvar_5[2].x;
  tmpvar_6[1].x = tmpvar_5[0].y;
  tmpvar_6[1].y = tmpvar_5[1].y;
  tmpvar_6[1].z = tmpvar_5[2].y;
  tmpvar_6[2].x = tmpvar_5[0].z;
  tmpvar_6[2].y = tmpvar_5[1].z;
  tmpvar_6[2].z = tmpvar_5[2].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * (((_World2Object * tmpvar_8).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _Specular;
uniform highp float _Shininess;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
uniform sampler2D _BumpMap;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec3 nm;
  mediump vec4 tex;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_6;
  lowp vec3 normal;
  normal.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal.z = sqrt (((1.0 - (normal.x * normal.x)) - (normal.y * normal.y)));
  nm = normal;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (col.xyz, _Color.xyz, tmpvar_9);
  col.xyz = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = col.xyz;
  tmpvar_2 = tmpvar_12;
  tmpvar_3 = nm;
  highp float tmpvar_13;
  tmpvar_13 = (_Shininess * mask.y);
  tmpvar_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = col.w;
  tmpvar_5 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize (xlv_TEXCOORD1);
  lightDir = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_LightTextureB0, tmpvar_16);
  lowp vec4 tmpvar_18;
  tmpvar_18 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  mediump vec3 lightDir_i0;
  lightDir_i0 = lightDir;
  mediump float atten;
  atten = (tmpvar_17.w * tmpvar_18.w);
  mediump vec4 c_i0;
  mediump float shininess;
  mediump vec3 nNormal;
  lowp vec3 tmpvar_19;
  tmpvar_19 = normalize (tmpvar_3);
  nNormal = tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_20 = ((tmpvar_4 * 250.0) + 4.0);
  shininess = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = normalize (lightDir_i0);
  lightDir_i0 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = max (0.0, dot (nNormal, tmpvar_21));
  mediump float tmpvar_23;
  tmpvar_23 = (pow (max (0.0, dot (-(normalize (xlv_TEXCOORD2)), reflect (tmpvar_21, nNormal))), shininess) * mask.x);
  highp vec3 tmpvar_24;
  tmpvar_24 = (((tmpvar_2 * tmpvar_22) + (_Specular.xyz * tmpvar_23)) * _LightColor0.xyz);
  c_i0.xyz = tmpvar_24;
  c_i0.xyz = (c_i0.xyz * (atten * 2.0));
  c_i0.w = tmpvar_5;
  c = c_i0;
  c.w = tmpvar_5;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
"agal_vs
c20 1.0 0.0 0.0 0.0
[bc]
aaaaaaaaaaaaaiacbeaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c20.x
aaaaaaaaaaaaahacbbaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c17
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r1.z, r0, c10
bdaaaaaaabaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r1.y, r0, c9
bdaaaaaaabaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r1.x, r0, c8
adaaaaaaacaaahacabaaaakeacaaaaaabaaaaappabaaaaaa mul r2.xyz, r1.xyzz, c16.w
acaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r2.xyzz, a0
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaaaaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r0.yzxx
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaaeaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r4.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacaeaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r4.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaaeaaaeacbcaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c18, r0
aaaaaaaaaaaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c9
bdaaaaaaaeaaacacbcaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.y, c18, r0
aaaaaaaaabaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c8
bdaaaaaaaeaaabacbcaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.x, c18, r1
adaaaaaaabaaahacaeaaaakeacaaaaaabaaaaappabaaaaaa mul r1.xyz, r4.xyzz, c16.w
acaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r0.xyz, r1.xyzz, a0
bcaaaaaaabaaacaeaaaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v1.y, r0.xyzz, r2.xyzz
bcaaaaaaabaaaeaeabaaaaoeaaaaaaaaaaaaaakeacaaaaaa dp3 v1.z, a1, r0.xyzz
bcaaaaaaabaaabaeaaaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v1.x, r0.xyzz, a5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bcaaaaaaacaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v2.y, r2.xyzz, r3.xyzz
bcaaaaaaacaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v2.z, a1, r3.xyzz
bcaaaaaaacaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v2.x, a5, r3.xyzz
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
bdaaaaaaadaaaeaeaaaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 v3.z, r0, c14
bdaaaaaaadaaacaeaaaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 v3.y, r0, c13
bdaaaaaaadaaabaeaaaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 v3.x, r0, c12
adaaaaaaaaaaadacadaaaaoeaaaaaaaabdaaaaoeabaaaaaa mul r0.xy, a3, c19
abaaaaaaaaaaadaeaaaaaafeacaaaaaabdaaaaooabaaaaaa add v0.xy, r0.xyyy, c19.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 20 [_MainTex_ST]
"!!ARBvp1.0
# 32 ALU
PARAM c[21] = { { 1 },
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
MOV result.color, vertex.color;
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 32 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
"vs_2_0
; 35 ALU
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v4
mov r0.w, c20.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT1.y, r4, r2
dp3 oT2.y, r2, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
dp3 oT2.z, v2, r3
dp3 oT2.x, v1, r3
mov oD0, v4
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
mad oT0.xy, v3, c19, c19.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize (_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize (_glesNormal);
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = tmpvar_1.xyz;
  tmpvar_5[1] = (cross (tmpvar_2, tmpvar_1.xyz) * _glesTANGENT.w);
  tmpvar_5[2] = tmpvar_2;
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5[0].x;
  tmpvar_6[0].y = tmpvar_5[1].x;
  tmpvar_6[0].z = tmpvar_5[2].x;
  tmpvar_6[1].x = tmpvar_5[0].y;
  tmpvar_6[1].y = tmpvar_5[1].y;
  tmpvar_6[1].z = tmpvar_5[2].y;
  tmpvar_6[2].x = tmpvar_5[0].z;
  tmpvar_6[2].y = tmpvar_5[1].z;
  tmpvar_6[2].z = tmpvar_5[2].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * (((_World2Object * tmpvar_8).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _Specular;
uniform highp float _Shininess;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
uniform sampler2D _BumpMap;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec3 nm;
  mediump vec4 tex;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  nm = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (col.xyz, _Color.xyz, tmpvar_10);
  col.xyz = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = col.xyz;
  tmpvar_2 = tmpvar_13;
  tmpvar_3 = nm;
  highp float tmpvar_14;
  tmpvar_14 = (_Shininess * mask.y);
  tmpvar_4 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = col.w;
  tmpvar_5 = tmpvar_15;
  lightDir = xlv_TEXCOORD1;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightTexture0, xlv_TEXCOORD3);
  mediump vec3 lightDir_i0;
  lightDir_i0 = lightDir;
  mediump float atten;
  atten = tmpvar_16.w;
  mediump vec4 c_i0;
  mediump float shininess;
  mediump vec3 nNormal;
  lowp vec3 tmpvar_17;
  tmpvar_17 = normalize (tmpvar_3);
  nNormal = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = ((tmpvar_4 * 250.0) + 4.0);
  shininess = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, dot (nNormal, lightDir_i0));
  mediump float tmpvar_20;
  tmpvar_20 = (pow (max (0.0, dot (-(normalize (xlv_TEXCOORD2)), reflect (lightDir_i0, nNormal))), shininess) * mask.x);
  highp vec3 tmpvar_21;
  tmpvar_21 = (((tmpvar_2 * tmpvar_19) + (_Specular.xyz * tmpvar_20)) * _LightColor0.xyz);
  c_i0.xyz = tmpvar_21;
  c_i0.xyz = (c_i0.xyz * (atten * 2.0));
  c_i0.w = tmpvar_5;
  c = c_i0;
  c.w = tmpvar_5;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize (_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize (_glesNormal);
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = tmpvar_1.xyz;
  tmpvar_5[1] = (cross (tmpvar_2, tmpvar_1.xyz) * _glesTANGENT.w);
  tmpvar_5[2] = tmpvar_2;
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5[0].x;
  tmpvar_6[0].y = tmpvar_5[1].x;
  tmpvar_6[0].z = tmpvar_5[2].x;
  tmpvar_6[1].x = tmpvar_5[0].y;
  tmpvar_6[1].y = tmpvar_5[1].y;
  tmpvar_6[1].z = tmpvar_5[2].y;
  tmpvar_6[2].x = tmpvar_5[0].z;
  tmpvar_6[2].y = tmpvar_5[1].z;
  tmpvar_6[2].z = tmpvar_5[2].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * (((_World2Object * tmpvar_8).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_9;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _Specular;
uniform highp float _Shininess;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
uniform sampler2D _BumpMap;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec3 nm;
  mediump vec4 tex;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_6;
  lowp vec3 normal;
  normal.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal.z = sqrt (((1.0 - (normal.x * normal.x)) - (normal.y * normal.y)));
  nm = normal;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (col.xyz, _Color.xyz, tmpvar_9);
  col.xyz = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = col.xyz;
  tmpvar_2 = tmpvar_12;
  tmpvar_3 = nm;
  highp float tmpvar_13;
  tmpvar_13 = (_Shininess * mask.y);
  tmpvar_4 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = col.w;
  tmpvar_5 = tmpvar_14;
  lightDir = xlv_TEXCOORD1;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_LightTexture0, xlv_TEXCOORD3);
  mediump vec3 lightDir_i0;
  lightDir_i0 = lightDir;
  mediump float atten;
  atten = tmpvar_15.w;
  mediump vec4 c_i0;
  mediump float shininess;
  mediump vec3 nNormal;
  lowp vec3 tmpvar_16;
  tmpvar_16 = normalize (tmpvar_3);
  nNormal = tmpvar_16;
  lowp float tmpvar_17;
  tmpvar_17 = ((tmpvar_4 * 250.0) + 4.0);
  shininess = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (nNormal, lightDir_i0));
  mediump float tmpvar_19;
  tmpvar_19 = (pow (max (0.0, dot (-(normalize (xlv_TEXCOORD2)), reflect (lightDir_i0, nNormal))), shininess) * mask.x);
  highp vec3 tmpvar_20;
  tmpvar_20 = (((tmpvar_2 * tmpvar_18) + (_Specular.xyz * tmpvar_19)) * _LightColor0.xyz);
  c_i0.xyz = tmpvar_20;
  c_i0.xyz = (c_i0.xyz * (atten * 2.0));
  c_i0.w = tmpvar_5;
  c = c_i0;
  c.w = tmpvar_5;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
"agal_vs
c20 1.0 0.0 0.0 0.0
[bc]
aaaaaaaaaaaaaiacbeaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c20.x
aaaaaaaaaaaaahacbbaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c17
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r1.z, r0, c10
bdaaaaaaabaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r1.y, r0, c9
bdaaaaaaabaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r1.x, r0, c8
adaaaaaaacaaahacabaaaakeacaaaaaabaaaaappabaaaaaa mul r2.xyz, r1.xyzz, c16.w
acaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r3.xyz, r2.xyzz, a0
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaaaaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r0.yzxx
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaaeaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r4.xyz, a1.yzxw, r0.zxyy
acaaaaaaabaaahacaeaaaakeacaaaaaaabaaaakeacaaaaaa sub r1.xyz, r4.xyzz, r1.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaafaaaappaaaaaaaa mul r2.xyz, r1.xyzz, a5.w
aaaaaaaaaaaaapacakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c10
bdaaaaaaaeaaaeacbcaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.z, c18, r0
aaaaaaaaaaaaapacajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0, c9
bdaaaaaaaeaaacacbcaaaaoeabaaaaaaaaaaaaoeacaaaaaa dp4 r4.y, c18, r0
aaaaaaaaabaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1, c8
bdaaaaaaaeaaabacbcaaaaoeabaaaaaaabaaaaoeacaaaaaa dp4 r4.x, c18, r1
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bcaaaaaaabaaacaeaeaaaakeacaaaaaaacaaaakeacaaaaaa dp3 v1.y, r4.xyzz, r2.xyzz
bcaaaaaaacaaacaeacaaaakeacaaaaaaadaaaakeacaaaaaa dp3 v2.y, r2.xyzz, r3.xyzz
bcaaaaaaabaaaeaeabaaaaoeaaaaaaaaaeaaaakeacaaaaaa dp3 v1.z, a1, r4.xyzz
bcaaaaaaabaaabaeaeaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v1.x, r4.xyzz, a5
bcaaaaaaacaaaeaeabaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v2.z, a1, r3.xyzz
bcaaaaaaacaaabaeafaaaaoeaaaaaaaaadaaaakeacaaaaaa dp3 v2.x, a5, r3.xyzz
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
bdaaaaaaadaaacaeaaaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 v3.y, r0, c13
bdaaaaaaadaaabaeaaaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 v3.x, r0, c12
adaaaaaaaaaaadacadaaaaoeaaaaaaaabdaaaaoeabaaaaaa mul r0.xy, a3, c19
abaaaaaaaaaaadaeaaaaaafeacaaaaaabdaaaaooabaaaaaa add v0.xy, r0.xyyy, c19.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.zw, c0
"
}

}
Program "fp" {
// Fragment combos: 5
//   opengl - ALU: 36 to 50, TEX: 3 to 5
//   d3d9 - ALU: 37 to 52, TEX: 3 to 5
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 45 ALU, 4 TEX
PARAM c[6] = { program.local[0..3],
		{ 2, 1, 0, 250 },
		{ 4, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1.xyz, fragment.texcoord[0], texture[2], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2.yw, fragment.texcoord[0], texture[1], 2D;
MAD R2.xy, R2.wyzw, c[4].x, -c[4].y;
MUL R2.z, R2.y, R2.y;
MAD R2.z, -R2.x, R2.x, -R2;
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
DP3 R2.w, fragment.texcoord[1], fragment.texcoord[1];
RSQ R2.w, R2.w;
MUL R3.xyz, R2.w, fragment.texcoord[1];
DP3 R3.w, R3, R3;
RSQ R3.w, R3.w;
MUL R3.xyz, R3.w, R3;
ADD R2.z, R2, c[4].y;
RSQ R2.z, R2.z;
RCP R2.z, R2.z;
DP3 R2.w, R2, R2;
RSQ R2.w, R2.w;
MUL R2.xyz, R2.w, R2;
DP3 R2.w, R2, R3;
MUL R2.xyz, R2, R2.w;
DP3 R3.w, fragment.texcoord[2], fragment.texcoord[2];
MAD R3.xyz, -R2, c[4].x, R3;
RSQ R3.w, R3.w;
MUL R2.xyz, R3.w, fragment.texcoord[2];
DP3 R2.x, -R2, R3;
MAX R3.x, R2, c[4].z;
MUL R0.xyz, fragment.color.primary, R0;
MOV R2.x, c[5];
MUL R1.y, R1, c[3].x;
MAD R1.y, R1, c[4].w, R2.x;
ADD R2.xyz, -R0, c[1];
MUL R2.xyz, R1.z, R2;
MAD R0.xyz, R2, c[5].y, R0;
MAX R1.z, R2.w, c[4];
MUL R2.xyz, R0, R1.z;
POW R1.y, R3.x, R1.y;
MUL R0.x, R1.y, R1;
MAD R0.xyz, R0.x, c[2], R2;
MUL R0.xyz, R0, c[0];
TEX R1.w, R1.w, texture[3], 2D;
MUL R1.xyz, R1.w, R0;
MUL R0.x, fragment.color.primary.w, c[1].w;
MUL result.color.xyz, R1, c[4].x;
MUL result.color.w, R0.x, R0;
END
# 45 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_LightTexture0] 2D
"ps_2_0
; 46 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c5, 250.00000000, 4.00000000, 0.50000000, 0
dcl t0.xy
dcl v0
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r2, t0, s0
texld r3, t0, s2
dp3 r0.x, t3, t3
mov r0.xy, r0.x
dp3_pp r1.x, t1, t1
rsq_pp r1.x, r1.x
mul_pp r4.xyz, r1.x, t1
dp3_pp r1.x, r4, r4
rsq_pp r1.x, r1.x
mul_pp r4.xyz, r1.x, r4
mul r2.xyz, v0, r2
texld r6, r0, s3
texld r0, t0, s1
mov r0.x, r0.w
mad_pp r5.xy, r0, c4.x, c4.y
mul_pp r0.x, r5.y, r5.y
mad_pp r0.x, -r5, r5, -r0
add_pp r0.x, r0, c4.z
rsq_pp r0.x, r0.x
rcp_pp r5.z, r0.x
dp3_pp r0.x, r5, r5
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r5
dp3_pp r0.x, r1, r4
mul_pp r5.xyz, r1, r0.x
dp3_pp r1.x, t2, t2
rsq_pp r1.x, r1.x
mad_pp r4.xyz, -r5, c4.x, r4
mul_pp r1.xyz, r1.x, t2
dp3_pp r1.x, -r1, r4
mul r4.x, r3.y, c3
max_pp r1.x, r1, c4.w
mad_pp r4.x, r4, c5, c5.y
pow_pp r5.x, r1.x, r4.x
add_pp r4.xyz, -r2, c1
mul_pp r4.xyz, r3.z, r4
mov_pp r1.x, r5.x
max_pp r0.x, r0, c4.w
mad_pp r2.xyz, r4, c5.z, r2
mul_pp r2.xyz, r2, r0.x
mul_pp r0.x, r1, r3
mad r0.xyz, r0.x, c2, r2
mul r0.xyz, r0, c0
mul_pp r1.xyz, r6.x, r0
mul r0.x, v0.w, c1.w
mul_pp r1.xyz, r1, c4.x
mul r1.w, r0.x, r2
mov_pp oC0, r1
"
}

SubProgram "gles " {
Keywords { "POINT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_LightTexture0] 2D
"agal_ps
c4 2.0 -1.0 1.0 0.0
c5 250.0 4.0 0.5 0.0
[bc]
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r1, v0, s1 <2d wrap linear point>
ciaaaaaaacaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r2, v0, s0 <2d wrap linear point>
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaacaaaaaaafaababb tex r3, v0, s2 <2d wrap linear point>
bcaaaaaaaaaaabacadaaaaoeaeaaaaaaadaaaaoeaeaaaaaa dp3 r0.x, v3, v3
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
bcaaaaaaabaaabacabaaaaoeaeaaaaaaabaaaaoeaeaaaaaa dp3 r1.x, v1, v1
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
adaaaaaaaeaaahacabaaaaaaacaaaaaaabaaaaoeaeaaaaaa mul r4.xyz, r1.x, v1
bcaaaaaaabaaabacaeaaaakeacaaaaaaaeaaaakeacaaaaaa dp3 r1.x, r4.xyzz, r4.xyzz
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
adaaaaaaaeaaahacabaaaaaaacaaaaaaaeaaaakeacaaaaaa mul r4.xyz, r1.x, r4.xyzz
adaaaaaaacaaahacahaaaaoeaeaaaaaaacaaaakeacaaaaaa mul r2.xyz, v7, r2.xyzz
ciaaaaaaaaaaapacaaaaaafeacaaaaaaadaaaaaaafaababb tex r0, r0.xyyy, s3 <2d wrap linear point>
aaaaaaaaaaaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r1.y
aaaaaaaaaaaaabacabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r1.w
adaaaaaaafaaadacaaaaaafeacaaaaaaaeaaaaaaabaaaaaa mul r5.xy, r0.xyyy, c4.x
abaaaaaaafaaadacafaaaafeacaaaaaaaeaaaaffabaaaaaa add r5.xy, r5.xyyy, c4.y
adaaaaaaaaaaabacafaaaaffacaaaaaaafaaaaffacaaaaaa mul r0.x, r5.y, r5.y
bfaaaaaaadaaaiacafaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r3.w, r5.x
adaaaaaaadaaaiacadaaaappacaaaaaaafaaaaaaacaaaaaa mul r3.w, r3.w, r5.x
acaaaaaaaaaaabacadaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r3.w, r0.x
abaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaakkabaaaaaa add r0.x, r0.x, c4.z
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
afaaaaaaafaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r5.z, r0.x
bcaaaaaaaaaaabacafaaaakeacaaaaaaafaaaakeacaaaaaa dp3 r0.x, r5.xyzz, r5.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaabaaahacaaaaaaaaacaaaaaaafaaaakeacaaaaaa mul r1.xyz, r0.x, r5.xyzz
bcaaaaaaaaaaabacabaaaakeacaaaaaaaeaaaakeacaaaaaa dp3 r0.x, r1.xyzz, r4.xyzz
adaaaaaaafaaahacabaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r5.xyz, r1.xyzz, r0.x
bcaaaaaaabaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r1.x, v2, v2
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
bfaaaaaaagaaahacafaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r6.xyz, r5.xyzz
adaaaaaaagaaahacagaaaakeacaaaaaaaeaaaaaaabaaaaaa mul r6.xyz, r6.xyzz, c4.x
abaaaaaaaeaaahacagaaaakeacaaaaaaaeaaaakeacaaaaaa add r4.xyz, r6.xyzz, r4.xyzz
adaaaaaaabaaahacabaaaaaaacaaaaaaacaaaaoeaeaaaaaa mul r1.xyz, r1.x, v2
bfaaaaaaagaaahacabaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r6.xyz, r1.xyzz
bcaaaaaaabaaabacagaaaakeacaaaaaaaeaaaakeacaaaaaa dp3 r1.x, r6.xyzz, r4.xyzz
adaaaaaaaeaaabacadaaaaffacaaaaaaadaaaaoeabaaaaaa mul r4.x, r3.y, c3
ahaaaaaaabaaabacabaaaaaaacaaaaaaaeaaaappabaaaaaa max r1.x, r1.x, c4.w
adaaaaaaaeaaabacaeaaaaaaacaaaaaaafaaaaoeabaaaaaa mul r4.x, r4.x, c5
abaaaaaaaeaaabacaeaaaaaaacaaaaaaafaaaaffabaaaaaa add r4.x, r4.x, c5.y
alaaaaaaafaaapacabaaaaaaacaaaaaaaeaaaaaaacaaaaaa pow r5, r1.x, r4.x
bfaaaaaaaeaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r4.xyz, r2.xyzz
abaaaaaaaeaaahacaeaaaakeacaaaaaaabaaaaoeabaaaaaa add r4.xyz, r4.xyzz, c1
adaaaaaaaeaaahacadaaaakkacaaaaaaaeaaaakeacaaaaaa mul r4.xyz, r3.z, r4.xyzz
aaaaaaaaabaaabacafaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r5.x
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaappabaaaaaa max r0.x, r0.x, c4.w
adaaaaaaagaaahacaeaaaakeacaaaaaaafaaaakkabaaaaaa mul r6.xyz, r4.xyzz, c5.z
abaaaaaaacaaahacagaaaakeacaaaaaaacaaaakeacaaaaaa add r2.xyz, r6.xyzz, r2.xyzz
adaaaaaaacaaahacacaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r2.xyz, r2.xyzz, r0.x
adaaaaaaaaaaabacabaaaaaaacaaaaaaadaaaaaaacaaaaaa mul r0.x, r1.x, r3.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaaoeabaaaaaa mul r0.xyz, r0.x, c2
abaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaakeacaaaaaa add r0.xyz, r0.xyzz, r2.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r0.xyz, r0.xyzz, c0
adaaaaaaabaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r1.xyz, r0.w, r0.xyzz
adaaaaaaaaaaabacahaaaappaeaaaaaaabaaaappabaaaaaa mul r0.x, v7.w, c1.w
adaaaaaaabaaahacabaaaakeacaaaaaaaeaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c4.x
adaaaaaaabaaaiacaaaaaaaaacaaaaaaacaaaappacaaaaaa mul r1.w, r0.x, r2.w
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 36 ALU, 3 TEX
PARAM c[6] = { program.local[0..3],
		{ 2, 1, 0, 250 },
		{ 4, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1.xyz, fragment.texcoord[0], texture[2], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2.yw, fragment.texcoord[0], texture[1], 2D;
MAD R2.xy, R2.wyzw, c[4].x, -c[4].y;
MUL R1.w, R2.y, R2.y;
MAD R1.w, -R2.x, R2.x, -R1;
MUL R0.xyz, fragment.color.primary, R0;
ADD R3.xyz, -R0, c[1];
MUL R3.xyz, R1.z, R3;
ADD R1.w, R1, c[4].y;
RSQ R1.w, R1.w;
RCP R2.z, R1.w;
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
MUL R2.xyz, R1.w, R2;
DP3 R1.z, R2, fragment.texcoord[1];
MUL R2.xyz, R2, R1.z;
DP3 R1.w, fragment.texcoord[2], fragment.texcoord[2];
MAD R0.xyz, R3, c[5].y, R0;
RSQ R1.w, R1.w;
MAD R4.xyz, -R2, c[4].x, fragment.texcoord[1];
MUL R2.xyz, R1.w, fragment.texcoord[2];
DP3 R1.w, -R2, R4;
MAX R2.x, R1.w, c[4].z;
MAX R1.z, R1, c[4];
MOV R1.w, c[5].x;
MUL R1.y, R1, c[3].x;
MAD R1.y, R1, c[4].w, R1.w;
POW R1.y, R2.x, R1.y;
MUL R2.xyz, R0, R1.z;
MUL R0.x, R1.y, R1;
MAD R0.xyz, R0.x, c[2], R2;
MUL R1.xyz, R0, c[0];
MUL R0.x, fragment.color.primary.w, c[1].w;
MUL result.color.xyz, R1, c[4].x;
MUL result.color.w, R0.x, R0;
END
# 36 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
"ps_2_0
; 37 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c5, 250.00000000, 4.00000000, 0.50000000, 0
dcl t0.xy
dcl v0
dcl t1.xyz
dcl t2.xyz
texld r0, t0, s1
texld r3, t0, s0
texld r4, t0, s2
mov r0.x, r0.w
mad_pp r1.xy, r0, c4.x, c4.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.x, -r1, r1, -r0
add_pp r0.x, r0, c4.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
dp3_pp r0.x, r1, r1
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r1
dp3_pp r0.x, r1, t1
mul_pp r2.xyz, r1, r0.x
dp3_pp r1.x, t2, t2
rsq_pp r1.x, r1.x
mad_pp r2.xyz, -r2, c4.x, t1
mul_pp r1.xyz, r1.x, t2
dp3_pp r1.x, -r1, r2
mul r2.x, r4.y, c3
max_pp r1.x, r1, c4.w
mad_pp r2.x, r2, c5, c5.y
pow_pp r5.x, r1.x, r2.x
mul r2.xyz, v0, r3
add_pp r3.xyz, -r2, c1
mul_pp r3.xyz, r4.z, r3
mov_pp r1.x, r5.x
max_pp r0.x, r0, c4.w
mad_pp r2.xyz, r3, c5.z, r2
mul_pp r2.xyz, r2, r0.x
mul_pp r0.x, r1, r4
mad r0.xyz, r0.x, c2, r2
mul r1.xyz, r0, c0
mul r0.x, v0.w, c1.w
mul_pp r1.xyz, r1, c4.x
mul r1.w, r0.x, r3
mov_pp oC0, r1
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
"agal_ps
c4 2.0 -1.0 1.0 0.0
c5 250.0 4.0 0.5 0.0
[bc]
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r0, v0, s1 <2d wrap linear point>
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
ciaaaaaaaeaaapacaaaaaaoeaeaaaaaaacaaaaaaafaababb tex r4, v0, s2 <2d wrap linear point>
aaaaaaaaaaaaabacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r0.w
adaaaaaaabaaadacaaaaaafeacaaaaaaaeaaaaaaabaaaaaa mul r1.xy, r0.xyyy, c4.x
abaaaaaaabaaadacabaaaafeacaaaaaaaeaaaaffabaaaaaa add r1.xy, r1.xyyy, c4.y
adaaaaaaaaaaabacabaaaaffacaaaaaaabaaaaffacaaaaaa mul r0.x, r1.y, r1.y
bfaaaaaaacaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r2.x, r1.x
adaaaaaaacaaabacacaaaaaaacaaaaaaabaaaaaaacaaaaaa mul r2.x, r2.x, r1.x
acaaaaaaaaaaabacacaaaaaaacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r2.x, r0.x
abaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaakkabaaaaaa add r0.x, r0.x, c4.z
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
afaaaaaaabaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r1.z, r0.x
bcaaaaaaaaaaabacabaaaakeacaaaaaaabaaaakeacaaaaaa dp3 r0.x, r1.xyzz, r1.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaabaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.x, r1.xyzz
bcaaaaaaaaaaabacabaaaakeacaaaaaaabaaaaoeaeaaaaaa dp3 r0.x, r1.xyzz, v1
adaaaaaaacaaahacabaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r2.xyz, r1.xyzz, r0.x
bcaaaaaaabaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r1.x, v2, v2
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
bfaaaaaaacaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r2.xyz, r2.xyzz
adaaaaaaacaaahacacaaaakeacaaaaaaaeaaaaaaabaaaaaa mul r2.xyz, r2.xyzz, c4.x
abaaaaaaacaaahacacaaaakeacaaaaaaabaaaaoeaeaaaaaa add r2.xyz, r2.xyzz, v1
adaaaaaaabaaahacabaaaaaaacaaaaaaacaaaaoeaeaaaaaa mul r1.xyz, r1.x, v2
bfaaaaaaafaaahacabaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r5.xyz, r1.xyzz
bcaaaaaaabaaabacafaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r1.x, r5.xyzz, r2.xyzz
adaaaaaaacaaabacaeaaaaffacaaaaaaadaaaaoeabaaaaaa mul r2.x, r4.y, c3
ahaaaaaaabaaabacabaaaaaaacaaaaaaaeaaaappabaaaaaa max r1.x, r1.x, c4.w
adaaaaaaacaaabacacaaaaaaacaaaaaaafaaaaoeabaaaaaa mul r2.x, r2.x, c5
abaaaaaaacaaabacacaaaaaaacaaaaaaafaaaaffabaaaaaa add r2.x, r2.x, c5.y
alaaaaaaafaaapacabaaaaaaacaaaaaaacaaaaaaacaaaaaa pow r5, r1.x, r2.x
adaaaaaaacaaahacahaaaaoeaeaaaaaaadaaaakeacaaaaaa mul r2.xyz, v7, r3.xyzz
bfaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r3.xyz, r2.xyzz
abaaaaaaadaaahacadaaaakeacaaaaaaabaaaaoeabaaaaaa add r3.xyz, r3.xyzz, c1
adaaaaaaadaaahacaeaaaakkacaaaaaaadaaaakeacaaaaaa mul r3.xyz, r4.z, r3.xyzz
aaaaaaaaabaaabacafaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r5.x
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaappabaaaaaa max r0.x, r0.x, c4.w
adaaaaaaafaaahacadaaaakeacaaaaaaafaaaakkabaaaaaa mul r5.xyz, r3.xyzz, c5.z
abaaaaaaacaaahacafaaaakeacaaaaaaacaaaakeacaaaaaa add r2.xyz, r5.xyzz, r2.xyzz
adaaaaaaacaaahacacaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r2.xyz, r2.xyzz, r0.x
adaaaaaaaaaaabacabaaaaaaacaaaaaaaeaaaaaaacaaaaaa mul r0.x, r1.x, r4.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaaoeabaaaaaa mul r0.xyz, r0.x, c2
abaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaakeacaaaaaa add r0.xyz, r0.xyzz, r2.xyzz
adaaaaaaabaaahacaaaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r0.xyzz, c0
adaaaaaaaaaaabacahaaaappaeaaaaaaabaaaappabaaaaaa mul r0.x, v7.w, c1.w
adaaaaaaabaaahacabaaaakeacaaaaaaaeaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c4.x
adaaaaaaabaaaiacaaaaaaaaacaaaaaaadaaaappacaaaaaa mul r1.w, r0.x, r3.w
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 50 ALU, 5 TEX
PARAM c[6] = { program.local[0..3],
		{ 0, 0.5, 2, 1 },
		{ 250, 4 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R2, fragment.texcoord[0], texture[0], 2D;
TEX R3.yw, fragment.texcoord[0], texture[1], 2D;
RCP R0.x, fragment.texcoord[3].w;
MAD R1.xy, fragment.texcoord[3], R0.x, c[4].y;
DP3 R1.z, fragment.texcoord[3], fragment.texcoord[3];
DP3 R3.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R3.x, R3.x;
TEX R0.xyz, fragment.texcoord[0], texture[2], 2D;
TEX R0.w, R1, texture[3], 2D;
TEX R1.w, R1.z, texture[4], 2D;
MAD R1.xy, R3.wyzw, c[4].z, -c[4].w;
MUL R1.z, R1.y, R1.y;
MAD R1.z, -R1.x, R1.x, -R1;
MUL R3.xyz, R3.x, fragment.texcoord[1];
DP3 R4.x, R3, R3;
RSQ R4.x, R4.x;
MUL R3.xyz, R4.x, R3;
ADD R1.z, R1, c[4].w;
RSQ R1.z, R1.z;
RCP R1.z, R1.z;
DP3 R3.w, R1, R1;
RSQ R3.w, R3.w;
MUL R1.xyz, R3.w, R1;
DP3 R3.w, R1, R3;
MUL R1.xyz, R1, R3.w;
DP3 R4.x, fragment.texcoord[2], fragment.texcoord[2];
MUL R0.y, R0, c[3].x;
MAD R3.xyz, -R1, c[4].z, R3;
RSQ R4.x, R4.x;
MUL R1.xyz, R4.x, fragment.texcoord[2];
DP3 R1.x, -R1, R3;
MAX R3.x, R1, c[4];
MUL R1.xyz, fragment.color.primary, R2;
ADD R2.xyz, -R1, c[1];
MUL R2.xyz, R0.z, R2;
MAD R0.y, R0, c[5].x, c[5];
POW R0.y, R3.x, R0.y;
MAX R0.z, R3.w, c[4].x;
MAD R1.xyz, R2, c[4].y, R1;
MUL R1.xyz, R1, R0.z;
MUL R0.x, R0.y, R0;
MAD R0.xyz, R0.x, c[2], R1;
MUL R1.xyz, R0, c[0];
SLT R0.x, c[4], fragment.texcoord[3].z;
MUL R0.x, R0, R0.w;
MUL R0.x, R0, R1.w;
MUL R1.xyz, R0.x, R1;
MUL R0.x, fragment.color.primary.w, c[1].w;
MUL result.color.xyz, R1, c[4].z;
MUL result.color.w, R0.x, R2;
END
# 50 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
"ps_2_0
; 52 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c4, 0.00000000, 1.00000000, 0.50000000, 2.00000000
def c5, 2.00000000, -1.00000000, 250.00000000, 4.00000000
dcl t0.xy
dcl v0
dcl t1.xyz
dcl t2.xyz
dcl t3
texld r3, t0, s0
texld r4, t0, s2
rcp r1.x, t3.w
mad r2.xy, t3, r1.x, c4.z
dp3 r0.x, t3, t3
mov r1.xy, r0.x
texld r6, r1, s4
texld r1, t0, s1
texld r0, r2, s3
dp3_pp r1.x, t1, t1
rsq_pp r1.x, r1.x
mul_pp r5.xyz, r1.x, t1
dp3_pp r1.x, r5, r5
rsq_pp r1.x, r1.x
mul_pp r5.xyz, r1.x, r5
mov r0.y, r1
mov r0.x, r1.w
mad_pp r2.xy, r0, c5.x, c5.y
mul_pp r0.x, r2.y, r2.y
mad_pp r0.x, -r2, r2, -r0
add_pp r0.x, r0, c4.y
rsq_pp r0.x, r0.x
rcp_pp r2.z, r0.x
dp3_pp r0.x, r2, r2
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r2
dp3_pp r0.x, r1, r5
mul_pp r2.xyz, r1, r0.x
dp3_pp r1.x, t2, t2
rsq_pp r1.x, r1.x
mad_pp r2.xyz, -r2, c4.w, r5
mul_pp r1.xyz, r1.x, t2
dp3_pp r1.x, -r1, r2
mul r2.x, r4.y, c3
max_pp r1.x, r1, c4
mad_pp r2.x, r2, c5.z, c5.w
pow_pp r5.x, r1.x, r2.x
mul r2.xyz, v0, r3
add_pp r3.xyz, -r2, c1
mul_pp r3.xyz, r4.z, r3
mov_pp r1.x, r5.x
max_pp r0.x, r0, c4
mad_pp r2.xyz, r3, c4.z, r2
mul_pp r2.xyz, r2, r0.x
mul_pp r0.x, r1, r4
mad r0.xyz, r0.x, c2, r2
mul r1.xyz, r0, c0
cmp r0.x, -t3.z, c4, c4.y
mul_pp r0.x, r0, r0.w
mul_pp r0.x, r0, r6
mul_pp r1.xyz, r0.x, r1
mul r0.x, v0.w, c1.w
mul_pp r1.xyz, r1, c4.w
mul r1.w, r0.x, r3
mov_pp oC0, r1
"
}

SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
"agal_ps
c4 0.0 1.0 0.5 2.0
c5 2.0 -1.0 250.0 4.0
[bc]
ciaaaaaaacaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r2, v0, s1 <2d wrap linear point>
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
ciaaaaaaaeaaapacaaaaaaoeaeaaaaaaacaaaaaaafaababb tex r4, v0, s2 <2d wrap linear point>
afaaaaaaabaaabacadaaaappaeaaaaaaaaaaaaaaaaaaaaaa rcp r1.x, v3.w
bcaaaaaaaaaaabacadaaaaoeaeaaaaaaadaaaaoeaeaaaaaa dp3 r0.x, v3, v3
adaaaaaaabaaadacadaaaaoeaeaaaaaaabaaaaaaacaaaaaa mul r1.xy, v3, r1.x
abaaaaaaabaaadacabaaaafeacaaaaaaaeaaaakkabaaaaaa add r1.xy, r1.xyyy, c4.z
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
ciaaaaaaaaaaapacaaaaaafeacaaaaaaaeaaaaaaafaababb tex r0, r0.xyyy, s4 <2d wrap linear point>
ciaaaaaaabaaapacabaaaafeacaaaaaaadaaaaaaafaababb tex r1, r1.xyyy, s3 <2d wrap linear point>
bcaaaaaaabaaabacabaaaaoeaeaaaaaaabaaaaoeaeaaaaaa dp3 r1.x, v1, v1
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
adaaaaaaafaaahacabaaaaaaacaaaaaaabaaaaoeaeaaaaaa mul r5.xyz, r1.x, v1
bcaaaaaaabaaabacafaaaakeacaaaaaaafaaaakeacaaaaaa dp3 r1.x, r5.xyzz, r5.xyzz
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
adaaaaaaafaaahacabaaaaaaacaaaaaaafaaaakeacaaaaaa mul r5.xyz, r1.x, r5.xyzz
aaaaaaaaaaaaacacacaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r2.y
aaaaaaaaaaaaabacacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r2.w
adaaaaaaacaaadacaaaaaafeacaaaaaaafaaaaaaabaaaaaa mul r2.xy, r0.xyyy, c5.x
abaaaaaaacaaadacacaaaafeacaaaaaaafaaaaffabaaaaaa add r2.xy, r2.xyyy, c5.y
adaaaaaaaaaaabacacaaaaffacaaaaaaacaaaaffacaaaaaa mul r0.x, r2.y, r2.y
bfaaaaaaaeaaaiacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r4.w, r2.x
adaaaaaaaeaaaiacaeaaaappacaaaaaaacaaaaaaacaaaaaa mul r4.w, r4.w, r2.x
acaaaaaaaaaaabacaeaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r4.w, r0.x
abaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaaffabaaaaaa add r0.x, r0.x, c4.y
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
afaaaaaaacaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r2.z, r0.x
bcaaaaaaaaaaabacacaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r0.x, r2.xyzz, r2.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaabaaahacaaaaaaaaacaaaaaaacaaaakeacaaaaaa mul r1.xyz, r0.x, r2.xyzz
bcaaaaaaaaaaabacabaaaakeacaaaaaaafaaaakeacaaaaaa dp3 r0.x, r1.xyzz, r5.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r2.xyz, r1.xyzz, r0.x
bcaaaaaaabaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r1.x, v2, v2
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
bfaaaaaaacaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r2.xyz, r2.xyzz
adaaaaaaacaaahacacaaaakeacaaaaaaaeaaaappabaaaaaa mul r2.xyz, r2.xyzz, c4.w
abaaaaaaacaaahacacaaaakeacaaaaaaafaaaakeacaaaaaa add r2.xyz, r2.xyzz, r5.xyzz
adaaaaaaabaaahacabaaaaaaacaaaaaaacaaaaoeaeaaaaaa mul r1.xyz, r1.x, v2
bfaaaaaaagaaahacabaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r6.xyz, r1.xyzz
bcaaaaaaabaaabacagaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r1.x, r6.xyzz, r2.xyzz
adaaaaaaacaaabacaeaaaaffacaaaaaaadaaaaoeabaaaaaa mul r2.x, r4.y, c3
ahaaaaaaabaaabacabaaaaaaacaaaaaaaeaaaaoeabaaaaaa max r1.x, r1.x, c4
adaaaaaaacaaabacacaaaaaaacaaaaaaafaaaakkabaaaaaa mul r2.x, r2.x, c5.z
abaaaaaaacaaabacacaaaaaaacaaaaaaafaaaappabaaaaaa add r2.x, r2.x, c5.w
alaaaaaaafaaapacabaaaaaaacaaaaaaacaaaaaaacaaaaaa pow r5, r1.x, r2.x
adaaaaaaacaaahacahaaaaoeaeaaaaaaadaaaakeacaaaaaa mul r2.xyz, v7, r3.xyzz
bfaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r3.xyz, r2.xyzz
abaaaaaaadaaahacadaaaakeacaaaaaaabaaaaoeabaaaaaa add r3.xyz, r3.xyzz, c1
adaaaaaaadaaahacaeaaaakkacaaaaaaadaaaakeacaaaaaa mul r3.xyz, r4.z, r3.xyzz
aaaaaaaaabaaabacafaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r5.x
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaaoeabaaaaaa max r0.x, r0.x, c4
adaaaaaaagaaahacadaaaakeacaaaaaaaeaaaakkabaaaaaa mul r6.xyz, r3.xyzz, c4.z
abaaaaaaacaaahacagaaaakeacaaaaaaacaaaakeacaaaaaa add r2.xyz, r6.xyzz, r2.xyzz
adaaaaaaacaaahacacaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r2.xyz, r2.xyzz, r0.x
adaaaaaaaaaaabacabaaaaaaacaaaaaaaeaaaaaaacaaaaaa mul r0.x, r1.x, r4.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaaoeabaaaaaa mul r0.xyz, r0.x, c2
abaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaakeacaaaaaa add r0.xyz, r0.xyzz, r2.xyzz
adaaaaaaabaaahacaaaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r0.xyzz, c0
bfaaaaaaagaaaeacadaaaakkaeaaaaaaaaaaaaaaaaaaaaaa neg r6.z, v3.z
ckaaaaaaaaaaabacagaaaakkacaaaaaaaeaaaaaaabaaaaaa slt r0.x, r6.z, c4.x
adaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaappacaaaaaa mul r0.x, r0.x, r1.w
adaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaappacaaaaaa mul r0.x, r0.x, r0.w
adaaaaaaabaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.x, r1.xyzz
adaaaaaaaaaaabacahaaaappaeaaaaaaabaaaappabaaaaaa mul r0.x, v7.w, c1.w
adaaaaaaabaaahacabaaaakeacaaaaaaaeaaaappabaaaaaa mul r1.xyz, r1.xyzz, c4.w
adaaaaaaabaaaiacaaaaaaaaacaaaaaaadaaaappacaaaaaa mul r1.w, r0.x, r3.w
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 47 ALU, 5 TEX
PARAM c[6] = { program.local[0..3],
		{ 2, 1, 0, 250 },
		{ 4, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.xyz, fragment.texcoord[0], texture[2], 2D;
TEX R3.yw, fragment.texcoord[0], texture[1], 2D;
TEX R2, fragment.texcoord[0], texture[0], 2D;
TEX R1.w, fragment.texcoord[3], texture[4], CUBE;
MAD R1.xy, R3.wyzw, c[4].x, -c[4].y;
MUL R1.z, R1.y, R1.y;
MAD R1.z, -R1.x, R1.x, -R1;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
DP3 R3.x, fragment.texcoord[1], fragment.texcoord[1];
ADD R1.z, R1, c[4].y;
RSQ R3.x, R3.x;
MUL R3.xyz, R3.x, fragment.texcoord[1];
DP3 R4.x, R3, R3;
RSQ R4.x, R4.x;
MUL R3.xyz, R4.x, R3;
RSQ R1.z, R1.z;
RCP R1.z, R1.z;
DP3 R3.w, R1, R1;
RSQ R3.w, R3.w;
MUL R1.xyz, R3.w, R1;
DP3 R3.w, R1, R3;
MUL R1.xyz, R1, R3.w;
DP3 R4.x, fragment.texcoord[2], fragment.texcoord[2];
MAD R3.xyz, -R1, c[4].x, R3;
RSQ R4.x, R4.x;
MUL R1.xyz, R4.x, fragment.texcoord[2];
DP3 R1.x, -R1, R3;
MAX R3.x, R1, c[4].z;
MUL R1.xyz, fragment.color.primary, R2;
MOV R2.x, c[5];
MUL R0.y, R0, c[3].x;
MAD R0.y, R0, c[4].w, R2.x;
ADD R2.xyz, -R1, c[1];
MUL R2.xyz, R0.z, R2;
POW R0.y, R3.x, R0.y;
MAX R0.z, R3.w, c[4];
MAD R1.xyz, R2, c[5].y, R1;
MUL R1.xyz, R1, R0.z;
MUL R0.x, R0.y, R0;
MAD R0.xyz, R0.x, c[2], R1;
MUL R1.xyz, R0, c[0];
TEX R0.w, R0.w, texture[3], 2D;
MUL R0.x, R0.w, R1.w;
MUL R1.xyz, R0.x, R1;
MUL R0.x, fragment.color.primary.w, c[1].w;
MUL result.color.xyz, R1, c[4].x;
MUL result.color.w, R0.x, R2;
END
# 47 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"ps_2_0
; 48 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c5, 250.00000000, 4.00000000, 0.50000000, 0
dcl t0.xy
dcl v0
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r1, t0, s1
texld r3, t0, s0
texld r4, t0, s2
dp3 r0.x, t3, t3
mov r0.xy, r0.x
dp3_pp r1.x, t1, t1
rsq_pp r1.x, r1.x
mul_pp r5.xyz, r1.x, t1
dp3_pp r1.x, r5, r5
rsq_pp r1.x, r1.x
mul_pp r5.xyz, r1.x, r5
texld r6, r0, s3
texld r0, t3, s4
mov r0.y, r1
mov r0.x, r1.w
mad_pp r2.xy, r0, c4.x, c4.y
mul_pp r0.x, r2.y, r2.y
mad_pp r0.x, -r2, r2, -r0
add_pp r0.x, r0, c4.z
rsq_pp r0.x, r0.x
rcp_pp r2.z, r0.x
dp3_pp r0.x, r2, r2
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r2
dp3_pp r0.x, r1, r5
mul_pp r2.xyz, r1, r0.x
dp3_pp r1.x, t2, t2
rsq_pp r1.x, r1.x
mad_pp r2.xyz, -r2, c4.x, r5
mul_pp r1.xyz, r1.x, t2
dp3_pp r1.x, -r1, r2
mul r2.x, r4.y, c3
max_pp r1.x, r1, c4.w
mad_pp r2.x, r2, c5, c5.y
pow_pp r5.x, r1.x, r2.x
mul r2.xyz, v0, r3
add_pp r3.xyz, -r2, c1
mul_pp r3.xyz, r4.z, r3
mov_pp r1.x, r5.x
max_pp r0.x, r0, c4.w
mad_pp r2.xyz, r3, c5.z, r2
mul_pp r2.xyz, r2, r0.x
mul_pp r0.x, r1, r4
mad r0.xyz, r0.x, c2, r2
mul r1.xyz, r0, c0
mul r0.x, r6, r0.w
mul_pp r1.xyz, r0.x, r1
mul r0.x, v0.w, c1.w
mul_pp r1.xyz, r1, c4.x
mul r1.w, r0.x, r3
mov_pp oC0, r1
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"agal_ps
c4 2.0 -1.0 1.0 0.0
c5 250.0 4.0 0.5 0.0
[bc]
ciaaaaaaacaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r2, v0, s1 <2d wrap linear point>
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
ciaaaaaaaeaaapacaaaaaaoeaeaaaaaaacaaaaaaafaababb tex r4, v0, s2 <2d wrap linear point>
bcaaaaaaaaaaabacadaaaaoeaeaaaaaaadaaaaoeaeaaaaaa dp3 r0.x, v3, v3
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
ciaaaaaaabaaapacaaaaaafeacaaaaaaadaaaaaaafaababb tex r1, r0.xyyy, s3 <2d wrap linear point>
ciaaaaaaaaaaapacadaaaaoeaeaaaaaaaeaaaaaaafbababb tex r0, v3, s4 <cube wrap linear point>
bcaaaaaaabaaabacabaaaaoeaeaaaaaaabaaaaoeaeaaaaaa dp3 r1.x, v1, v1
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
adaaaaaaafaaahacabaaaaaaacaaaaaaabaaaaoeaeaaaaaa mul r5.xyz, r1.x, v1
bcaaaaaaabaaabacafaaaakeacaaaaaaafaaaakeacaaaaaa dp3 r1.x, r5.xyzz, r5.xyzz
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
adaaaaaaafaaahacabaaaaaaacaaaaaaafaaaakeacaaaaaa mul r5.xyz, r1.x, r5.xyzz
aaaaaaaaaaaaacacacaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r2.y
aaaaaaaaaaaaabacacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r2.w
adaaaaaaacaaadacaaaaaafeacaaaaaaaeaaaaaaabaaaaaa mul r2.xy, r0.xyyy, c4.x
abaaaaaaacaaadacacaaaafeacaaaaaaaeaaaaffabaaaaaa add r2.xy, r2.xyyy, c4.y
adaaaaaaaaaaabacacaaaaffacaaaaaaacaaaaffacaaaaaa mul r0.x, r2.y, r2.y
bfaaaaaaaeaaaiacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r4.w, r2.x
adaaaaaaaeaaaiacaeaaaappacaaaaaaacaaaaaaacaaaaaa mul r4.w, r4.w, r2.x
acaaaaaaaaaaabacaeaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r4.w, r0.x
abaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaakkabaaaaaa add r0.x, r0.x, c4.z
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
afaaaaaaacaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r2.z, r0.x
bcaaaaaaaaaaabacacaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r0.x, r2.xyzz, r2.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaabaaahacaaaaaaaaacaaaaaaacaaaakeacaaaaaa mul r1.xyz, r0.x, r2.xyzz
bcaaaaaaaaaaabacabaaaakeacaaaaaaafaaaakeacaaaaaa dp3 r0.x, r1.xyzz, r5.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r2.xyz, r1.xyzz, r0.x
bcaaaaaaabaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r1.x, v2, v2
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
bfaaaaaaacaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r2.xyz, r2.xyzz
adaaaaaaacaaahacacaaaakeacaaaaaaaeaaaaaaabaaaaaa mul r2.xyz, r2.xyzz, c4.x
abaaaaaaacaaahacacaaaakeacaaaaaaafaaaakeacaaaaaa add r2.xyz, r2.xyzz, r5.xyzz
adaaaaaaabaaahacabaaaaaaacaaaaaaacaaaaoeaeaaaaaa mul r1.xyz, r1.x, v2
bfaaaaaaagaaahacabaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r6.xyz, r1.xyzz
bcaaaaaaabaaabacagaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r1.x, r6.xyzz, r2.xyzz
adaaaaaaacaaabacaeaaaaffacaaaaaaadaaaaoeabaaaaaa mul r2.x, r4.y, c3
ahaaaaaaabaaabacabaaaaaaacaaaaaaaeaaaappabaaaaaa max r1.x, r1.x, c4.w
adaaaaaaacaaabacacaaaaaaacaaaaaaafaaaaoeabaaaaaa mul r2.x, r2.x, c5
abaaaaaaacaaabacacaaaaaaacaaaaaaafaaaaffabaaaaaa add r2.x, r2.x, c5.y
alaaaaaaafaaapacabaaaaaaacaaaaaaacaaaaaaacaaaaaa pow r5, r1.x, r2.x
adaaaaaaacaaahacahaaaaoeaeaaaaaaadaaaakeacaaaaaa mul r2.xyz, v7, r3.xyzz
bfaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r3.xyz, r2.xyzz
abaaaaaaadaaahacadaaaakeacaaaaaaabaaaaoeabaaaaaa add r3.xyz, r3.xyzz, c1
adaaaaaaadaaahacaeaaaakkacaaaaaaadaaaakeacaaaaaa mul r3.xyz, r4.z, r3.xyzz
aaaaaaaaabaaabacafaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r5.x
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaappabaaaaaa max r0.x, r0.x, c4.w
adaaaaaaagaaahacadaaaakeacaaaaaaafaaaakkabaaaaaa mul r6.xyz, r3.xyzz, c5.z
abaaaaaaacaaahacagaaaakeacaaaaaaacaaaakeacaaaaaa add r2.xyz, r6.xyzz, r2.xyzz
adaaaaaaacaaahacacaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r2.xyz, r2.xyzz, r0.x
adaaaaaaaaaaabacabaaaaaaacaaaaaaaeaaaaaaacaaaaaa mul r0.x, r1.x, r4.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaaoeabaaaaaa mul r0.xyz, r0.x, c2
abaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaakeacaaaaaa add r0.xyz, r0.xyzz, r2.xyzz
adaaaaaaabaaahacaaaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r0.xyzz, c0
adaaaaaaaaaaabacabaaaappacaaaaaaaaaaaappacaaaaaa mul r0.x, r1.w, r0.w
adaaaaaaabaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.x, r1.xyzz
adaaaaaaaaaaabacahaaaappaeaaaaaaabaaaappabaaaaaa mul r0.x, v7.w, c1.w
adaaaaaaabaaahacabaaaakeacaaaaaaaeaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c4.x
adaaaaaaabaaaiacaaaaaaaaacaaaaaaadaaaappacaaaaaa mul r1.w, r0.x, r3.w
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 38 ALU, 4 TEX
PARAM c[6] = { program.local[0..3],
		{ 2, 1, 0, 250 },
		{ 4, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1.xyz, fragment.texcoord[0], texture[2], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2.yw, fragment.texcoord[0], texture[1], 2D;
TEX R1.w, fragment.texcoord[3], texture[3], 2D;
MAD R2.xy, R2.wyzw, c[4].x, -c[4].y;
MUL R2.z, R2.y, R2.y;
MAD R2.z, -R2.x, R2.x, -R2;
MUL R0.xyz, fragment.color.primary, R0;
ADD R3.xyz, -R0, c[1];
MUL R3.xyz, R1.z, R3;
ADD R2.z, R2, c[4].y;
RSQ R2.z, R2.z;
RCP R2.z, R2.z;
DP3 R2.w, R2, R2;
RSQ R2.w, R2.w;
MUL R2.xyz, R2.w, R2;
DP3 R1.z, R2, fragment.texcoord[1];
MUL R2.xyz, R2, R1.z;
DP3 R2.w, fragment.texcoord[2], fragment.texcoord[2];
MAD R0.xyz, R3, c[5].y, R0;
MAD R4.xyz, -R2, c[4].x, fragment.texcoord[1];
RSQ R2.w, R2.w;
MUL R2.xyz, R2.w, fragment.texcoord[2];
DP3 R2.x, -R2, R4;
MAX R2.y, R2.x, c[4].z;
MOV R2.x, c[5];
MUL R1.y, R1, c[3].x;
MAD R1.y, R1, c[4].w, R2.x;
POW R1.y, R2.y, R1.y;
MAX R1.z, R1, c[4];
MUL R2.xyz, R0, R1.z;
MUL R0.x, R1.y, R1;
MAD R0.xyz, R0.x, c[2], R2;
MUL R0.xyz, R0, c[0];
MUL R1.xyz, R1.w, R0;
MUL R0.x, fragment.color.primary.w, c[1].w;
MUL result.color.xyz, R1, c[4].x;
MUL result.color.w, R0.x, R0;
END
# 38 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_LightTexture0] 2D
"ps_2_0
; 39 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c5, 250.00000000, 4.00000000, 0.50000000, 0
dcl t0.xy
dcl v0
dcl t1.xyz
dcl t2.xyz
dcl t3.xy
texld r1, t0, s1
texld r3, t0, s0
texld r4, t0, s2
texld r0, t3, s3
mov r0.y, r1
mov r0.x, r1.w
mad_pp r1.xy, r0, c4.x, c4.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.x, -r1, r1, -r0
add_pp r0.x, r0, c4.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
dp3_pp r0.x, r1, r1
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r1
dp3_pp r0.x, r1, t1
mul_pp r2.xyz, r1, r0.x
dp3_pp r1.x, t2, t2
rsq_pp r1.x, r1.x
mad_pp r2.xyz, -r2, c4.x, t1
mul_pp r1.xyz, r1.x, t2
dp3_pp r1.x, -r1, r2
mul r2.x, r4.y, c3
max_pp r1.x, r1, c4.w
mad_pp r2.x, r2, c5, c5.y
pow_pp r5.x, r1.x, r2.x
mul r2.xyz, v0, r3
add_pp r3.xyz, -r2, c1
mul_pp r3.xyz, r4.z, r3
mov_pp r1.x, r5.x
max_pp r0.x, r0, c4.w
mad_pp r2.xyz, r3, c5.z, r2
mul_pp r2.xyz, r2, r0.x
mul_pp r0.x, r1, r4
mad r0.xyz, r0.x, c2, r2
mul r0.xyz, r0, c0
mul_pp r1.xyz, r0.w, r0
mul r0.x, v0.w, c1.w
mul_pp r1.xyz, r1, c4.x
mul r1.w, r0.x, r3
mov_pp oC0, r1
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Specular]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_Mask] 2D
SetTexture 3 [_LightTexture0] 2D
"agal_ps
c4 2.0 -1.0 1.0 0.0
c5 250.0 4.0 0.5 0.0
[bc]
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r1, v0, s1 <2d wrap linear point>
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
ciaaaaaaaeaaapacaaaaaaoeaeaaaaaaacaaaaaaafaababb tex r4, v0, s2 <2d wrap linear point>
ciaaaaaaaaaaapacadaaaaoeaeaaaaaaadaaaaaaafaababb tex r0, v3, s3 <2d wrap linear point>
aaaaaaaaaaaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r1.y
aaaaaaaaaaaaabacabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r1.w
adaaaaaaabaaadacaaaaaafeacaaaaaaaeaaaaaaabaaaaaa mul r1.xy, r0.xyyy, c4.x
abaaaaaaabaaadacabaaaafeacaaaaaaaeaaaaffabaaaaaa add r1.xy, r1.xyyy, c4.y
adaaaaaaaaaaabacabaaaaffacaaaaaaabaaaaffacaaaaaa mul r0.x, r1.y, r1.y
bfaaaaaaacaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r2.x, r1.x
adaaaaaaacaaabacacaaaaaaacaaaaaaabaaaaaaacaaaaaa mul r2.x, r2.x, r1.x
acaaaaaaaaaaabacacaaaaaaacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r2.x, r0.x
abaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaakkabaaaaaa add r0.x, r0.x, c4.z
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
afaaaaaaabaaaeacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r1.z, r0.x
bcaaaaaaaaaaabacabaaaakeacaaaaaaabaaaakeacaaaaaa dp3 r0.x, r1.xyzz, r1.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaabaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r0.x, r1.xyzz
bcaaaaaaaaaaabacabaaaakeacaaaaaaabaaaaoeaeaaaaaa dp3 r0.x, r1.xyzz, v1
adaaaaaaacaaahacabaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r2.xyz, r1.xyzz, r0.x
bcaaaaaaabaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r1.x, v2, v2
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
bfaaaaaaacaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r2.xyz, r2.xyzz
adaaaaaaacaaahacacaaaakeacaaaaaaaeaaaaaaabaaaaaa mul r2.xyz, r2.xyzz, c4.x
abaaaaaaacaaahacacaaaakeacaaaaaaabaaaaoeaeaaaaaa add r2.xyz, r2.xyzz, v1
adaaaaaaabaaahacabaaaaaaacaaaaaaacaaaaoeaeaaaaaa mul r1.xyz, r1.x, v2
bfaaaaaaafaaahacabaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r5.xyz, r1.xyzz
bcaaaaaaabaaabacafaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r1.x, r5.xyzz, r2.xyzz
adaaaaaaacaaabacaeaaaaffacaaaaaaadaaaaoeabaaaaaa mul r2.x, r4.y, c3
ahaaaaaaabaaabacabaaaaaaacaaaaaaaeaaaappabaaaaaa max r1.x, r1.x, c4.w
adaaaaaaacaaabacacaaaaaaacaaaaaaafaaaaoeabaaaaaa mul r2.x, r2.x, c5
abaaaaaaacaaabacacaaaaaaacaaaaaaafaaaaffabaaaaaa add r2.x, r2.x, c5.y
alaaaaaaafaaapacabaaaaaaacaaaaaaacaaaaaaacaaaaaa pow r5, r1.x, r2.x
adaaaaaaacaaahacahaaaaoeaeaaaaaaadaaaakeacaaaaaa mul r2.xyz, v7, r3.xyzz
bfaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r3.xyz, r2.xyzz
abaaaaaaadaaahacadaaaakeacaaaaaaabaaaaoeabaaaaaa add r3.xyz, r3.xyzz, c1
adaaaaaaadaaahacaeaaaakkacaaaaaaadaaaakeacaaaaaa mul r3.xyz, r4.z, r3.xyzz
aaaaaaaaabaaabacafaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r5.x
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaappabaaaaaa max r0.x, r0.x, c4.w
adaaaaaaafaaahacadaaaakeacaaaaaaafaaaakkabaaaaaa mul r5.xyz, r3.xyzz, c5.z
abaaaaaaacaaahacafaaaakeacaaaaaaacaaaakeacaaaaaa add r2.xyz, r5.xyzz, r2.xyzz
adaaaaaaacaaahacacaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r2.xyz, r2.xyzz, r0.x
adaaaaaaaaaaabacabaaaaaaacaaaaaaaeaaaaaaacaaaaaa mul r0.x, r1.x, r4.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaaoeabaaaaaa mul r0.xyz, r0.x, c2
abaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaakeacaaaaaa add r0.xyz, r0.xyzz, r2.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r0.xyz, r0.xyzz, c0
adaaaaaaabaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r1.xyz, r0.w, r0.xyzz
adaaaaaaaaaaabacahaaaappaeaaaaaaabaaaappabaaaaaa mul r0.x, v7.w, c1.w
adaaaaaaabaaahacabaaaakeacaaaaaaaeaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c4.x
adaaaaaaabaaaiacaaaaaaaaacaaaaaaadaaaappacaaaaaa mul r1.w, r0.x, r3.w
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
"
}

}
	}

#LINE 199

		}
		
		SubShader
		{
			LOD 300

			Cull Off
			ZWrite Off
			ZTest LEqual
			Blend SrcAlpha OneMinusSrcAlpha
			AlphaTest Greater 0

				Alphatest Greater 0 ZWrite Off ColorMask RGB
	
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }
		Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
// Vertex combos: 4
//   opengl - ALU: 7 to 61
//   d3d9 - ALU: 7 to 61
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 9 [unity_Scale]
Vector 10 [_WorldSpaceCameraPos]
Matrix 5 [_Object2World]
Vector 11 [unity_SHAr]
Vector 12 [unity_SHAg]
Vector 13 [unity_SHAb]
Vector 14 [unity_SHBr]
Vector 15 [unity_SHBg]
Vector 16 [unity_SHBb]
Vector 17 [unity_SHC]
Vector 18 [_MainTex_ST]
"!!ARBvp1.0
# 32 ALU
PARAM c[19] = { { 1 },
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[9].w;
DP3 R3.w, R1, c[6];
DP3 R2.w, R1, c[7];
DP3 R0.x, R1, c[5];
MOV R0.y, R3.w;
MOV R0.z, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[13];
DP4 R2.y, R0, c[12];
DP4 R2.x, R0, c[11];
MUL R0.y, R3.w, R3.w;
MAD R0.y, R0.x, R0.x, -R0;
MOV result.texcoord[1].x, R0;
DP4 R3.z, R1, c[16];
DP4 R3.y, R1, c[15];
DP4 R3.x, R1, c[14];
MUL R1.xyz, R0.y, c[17];
ADD R2.xyz, R2, R3;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
ADD result.texcoord[2].xyz, R2, R1;
MOV result.color, vertex.color;
MOV result.texcoord[1].z, R2.w;
MOV result.texcoord[1].y, R3.w;
ADD result.texcoord[3].xyz, -R0, c[10];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 32 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_Scale]
Vector 9 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [_MainTex_ST]
"vs_2_0
; 32 ALU
def c18, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_color0 v3
mul r1.xyz, v1, c8.w
dp3 r3.w, r1, c5
dp3 r2.w, r1, c6
dp3 r0.x, r1, c4
mov r0.y, r3.w
mov r0.z, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c18.x
dp4 r2.z, r0, c12
dp4 r2.y, r0, c11
dp4 r2.x, r0, c10
mul r0.y, r3.w, r3.w
mad r0.y, r0.x, r0.x, -r0
mov oT1.x, r0
dp4 r3.z, r1, c15
dp4 r3.y, r1, c14
dp4 r3.x, r1, c13
mul r1.xyz, r0.y, c16
add r2.xyz, r2, r3
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
add oT2.xyz, r2, r1
mov oD0, v3
mov oT1.z, r2.w
mov oT1.y, r3.w
add oT3.xyz, -r0, c9
mad oT0.xy, v2, c17, c17.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight;
  lowp vec3 tmpvar_1;
  lowp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  mediump vec3 tmpvar_6;
  mediump vec4 normal;
  normal = tmpvar_5;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_7;
  tmpvar_7 = dot (unity_SHAr, normal);
  x1.x = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = dot (unity_SHAg, normal);
  x1.y = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (unity_SHAb, normal);
  x1.z = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHBr, tmpvar_10);
  x2.x = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (unity_SHBg, tmpvar_10);
  x2.y = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHBb, tmpvar_10);
  x2.z = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (unity_SHC.xyz * vC);
  x3 = tmpvar_15;
  tmpvar_6 = ((x1 + x2) + x3);
  shlight = tmpvar_6;
  tmpvar_2 = shlight;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec4 tex;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (col.xyz, _Color.xyz, tmpvar_7);
  col.xyz = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = col.xyz;
  tmpvar_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = col.w;
  tmpvar_3 = tmpvar_11;
  lowp vec4 c_i0;
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz));
  highp vec3 tmpvar_13;
  tmpvar_13 = (((tmpvar_2 * _LightColor0.xyz) * tmpvar_12) * 2.0);
  c_i0.xyz = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = tmpvar_3;
  c_i0.w = tmpvar_14;
  c = c_i0;
  c.xyz = (c_i0.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  c.w = tmpvar_3;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight;
  lowp vec3 tmpvar_1;
  lowp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  mediump vec3 tmpvar_6;
  mediump vec4 normal;
  normal = tmpvar_5;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_7;
  tmpvar_7 = dot (unity_SHAr, normal);
  x1.x = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = dot (unity_SHAg, normal);
  x1.y = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (unity_SHAb, normal);
  x1.z = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHBr, tmpvar_10);
  x2.x = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (unity_SHBg, tmpvar_10);
  x2.y = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHBb, tmpvar_10);
  x2.z = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (unity_SHC.xyz * vC);
  x3 = tmpvar_15;
  tmpvar_6 = ((x1 + x2) + x3);
  shlight = tmpvar_6;
  tmpvar_2 = shlight;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec4 tex;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (col.xyz, _Color.xyz, tmpvar_7);
  col.xyz = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = col.xyz;
  tmpvar_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = col.w;
  tmpvar_3 = tmpvar_11;
  lowp vec4 c_i0;
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz));
  highp vec3 tmpvar_13;
  tmpvar_13 = (((tmpvar_2 * _LightColor0.xyz) * tmpvar_12) * 2.0);
  c_i0.xyz = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = tmpvar_3;
  c_i0.w = tmpvar_14;
  c = c_i0;
  c.xyz = (c_i0.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  c.w = tmpvar_3;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_Scale]
Vector 9 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [_MainTex_ST]
"agal_vs
c18 1.0 0.0 0.0 0.0
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaaiaaaappabaaaaaa mul r1.xyz, a1, c8.w
bcaaaaaaadaaaiacabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r3.w, r1.xyzz, c5
bcaaaaaaacaaaiacabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r2.w, r1.xyzz, c6
bcaaaaaaaaaaabacabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r0.x, r1.xyzz, c4
aaaaaaaaaaaaacacadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r3.w
aaaaaaaaaaaaaeacacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.z, r2.w
adaaaaaaabaaapacaaaaaakeacaaaaaaaaaaaacjacaaaaaa mul r1, r0.xyzz, r0.yzzx
aaaaaaaaaaaaaiacbcaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c18.x
bdaaaaaaacaaaeacaaaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 r2.z, r0, c12
bdaaaaaaacaaacacaaaaaaoeacaaaaaaalaaaaoeabaaaaaa dp4 r2.y, r0, c11
bdaaaaaaacaaabacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r2.x, r0, c10
adaaaaaaaaaaacacadaaaappacaaaaaaadaaaappacaaaaaa mul r0.y, r3.w, r3.w
adaaaaaaaeaaacacaaaaaaaaacaaaaaaaaaaaaaaacaaaaaa mul r4.y, r0.x, r0.x
acaaaaaaaaaaacacaeaaaaffacaaaaaaaaaaaaffacaaaaaa sub r0.y, r4.y, r0.y
aaaaaaaaabaaabaeaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov v1.x, r0.x
bdaaaaaaadaaaeacabaaaaoeacaaaaaaapaaaaoeabaaaaaa dp4 r3.z, r1, c15
bdaaaaaaadaaacacabaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 r3.y, r1, c14
bdaaaaaaadaaabacabaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 r3.x, r1, c13
adaaaaaaabaaahacaaaaaaffacaaaaaabaaaaaoeabaaaaaa mul r1.xyz, r0.y, c16
abaaaaaaacaaahacacaaaakeacaaaaaaadaaaakeacaaaaaa add r2.xyz, r2.xyzz, r3.xyzz
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
abaaaaaaacaaahaeacaaaakeacaaaaaaabaaaakeacaaaaaa add v2.xyz, r2.xyzz, r1.xyzz
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
aaaaaaaaabaaaeaeacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v1.z, r2.w
aaaaaaaaabaaacaeadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v1.y, r3.w
bfaaaaaaaeaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r4.xyz, r0.xyzz
abaaaaaaadaaahaeaeaaaakeacaaaaaaajaaaaoeabaaaaaa add v3.xyz, r4.xyzz, c9
adaaaaaaaeaaadacadaaaaoeaaaaaaaabbaaaaoeabaaaaaa mul r4.xy, a3, c17
abaaaaaaaaaaadaeaeaaaafeacaaaaaabbaaaaooabaaaaaa add v0.xy, r4.xyyy, c17.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Vector 9 [unity_LightmapST]
Vector 10 [_MainTex_ST]
"!!ARBvp1.0
# 7 ALU
PARAM c[11] = { program.local[0],
		state.matrix.mvp,
		program.local[5..10] };
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[9], c[9].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 7 instructions, 0 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
Vector 9 [_MainTex_ST]
"vs_2_0
; 7 ALU
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
dcl_color0 v4
mov oD0, v4
mad oT0.xy, v2, c9, c9.zwzw
mad oT1.xy, v3, c8, c8.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;

uniform highp vec4 _MainTex_ST;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec4 tex;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (col.xyz, _Color.xyz, tmpvar_7);
  col.xyz = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = col.xyz;
  tmpvar_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = col.w;
  tmpvar_3 = tmpvar_11;
  c = vec4(0.0, 0.0, 0.0, 0.0);
  c.xyz = (tmpvar_2 * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  c.w = tmpvar_3;
  c.w = tmpvar_3;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;

uniform highp vec4 _MainTex_ST;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec4 tex;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (col.xyz, _Color.xyz, tmpvar_7);
  col.xyz = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = col.xyz;
  tmpvar_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = col.w;
  tmpvar_3 = tmpvar_11;
  c = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  c.xyz = (tmpvar_2 * ((8.0 * tmpvar_12.w) * tmpvar_12.xyz));
  c.w = tmpvar_3;
  c.w = tmpvar_3;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
Vector 9 [_MainTex_ST]
"agal_vs
[bc]
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
adaaaaaaaaaaadacadaaaaoeaaaaaaaaajaaaaoeabaaaaaa mul r0.xy, a3, c9
abaaaaaaaaaaadaeaaaaaafeacaaaaaaajaaaaooabaaaaaa add v0.xy, r0.xyyy, c9.zwzw
adaaaaaaaaaaadacaeaaaaoeaaaaaaaaaiaaaaoeabaaaaaa mul r0.xy, a4, c8
abaaaaaaabaaadaeaaaaaafeacaaaaaaaiaaaaooabaaaaaa add v1.xy, r0.xyyy, c8.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Matrix 9 [_World2Object]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
"!!ARBvp1.0
# 20 ALU
PARAM c[17] = { { 1 },
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[14];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[13].w, -vertex.position;
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[15], c[15].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 20 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Matrix 8 [_World2Object]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
"vs_2_0
; 21 ALU
def c16, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
mov r0.xyz, c13
mov r0.w, c16.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c12.w, -v0
dp3 oT2.y, r0, r1
dp3 oT2.z, v2, r0
dp3 oT2.x, r0, v1
mov oD0, v5
mad oT0.xy, v3, c15, c15.zwzw
mad oT1.xy, v4, c14, c14.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_LightmapST;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize (_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize (_glesNormal);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = tmpvar_1.xyz;
  tmpvar_3[1] = (cross (tmpvar_2, tmpvar_1.xyz) * _glesTANGENT.w);
  tmpvar_3[2] = tmpvar_2;
  mat3 tmpvar_4;
  tmpvar_4[0].x = tmpvar_3[0].x;
  tmpvar_4[0].y = tmpvar_3[1].x;
  tmpvar_4[0].z = tmpvar_3[2].x;
  tmpvar_4[1].x = tmpvar_3[0].y;
  tmpvar_4[1].y = tmpvar_3[1].y;
  tmpvar_4[1].z = tmpvar_3[2].y;
  tmpvar_4[2].x = tmpvar_3[0].z;
  tmpvar_4[2].y = tmpvar_3[1].z;
  tmpvar_4[2].z = tmpvar_3[2].z;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (tmpvar_4 * (((_World2Object * tmpvar_5).xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec4 tex;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (col.xyz, _Color.xyz, tmpvar_7);
  col.xyz = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = col.xyz;
  tmpvar_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = col.w;
  tmpvar_3 = tmpvar_11;
  c = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize (xlv_TEXCOORD2);
  mediump vec4 tmpvar_13;
  mediump vec3 viewDir;
  viewDir = tmpvar_12;
  highp float nh;
  mediump vec3 scalePerBasisVector_i0;
  mediump vec3 lm_i0;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_i0 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_i0 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (vec3(0.0, 0.0, 1.0), normalize ((normalize ((((scalePerBasisVector_i0.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_i0.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_i0.z * vec3(-0.408248, -0.707107, 0.57735)))) + viewDir))));
  nh = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = lm_i0;
  tmpvar_17.w = pow (nh, 0.0);
  tmpvar_13 = tmpvar_17;
  c.xyz = vec3(0.0, 0.0, 0.0);
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_2 * tmpvar_13.xyz);
  c.xyz = tmpvar_18;
  c.w = tmpvar_3;
  c.w = tmpvar_3;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_LightmapST;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform highp vec4 _MainTex_ST;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize (_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize (_glesNormal);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = tmpvar_1.xyz;
  tmpvar_3[1] = (cross (tmpvar_2, tmpvar_1.xyz) * _glesTANGENT.w);
  tmpvar_3[2] = tmpvar_2;
  mat3 tmpvar_4;
  tmpvar_4[0].x = tmpvar_3[0].x;
  tmpvar_4[0].y = tmpvar_3[1].x;
  tmpvar_4[0].z = tmpvar_3[2].x;
  tmpvar_4[1].x = tmpvar_3[0].y;
  tmpvar_4[1].y = tmpvar_3[1].y;
  tmpvar_4[1].z = tmpvar_3[2].y;
  tmpvar_4[2].x = tmpvar_3[0].z;
  tmpvar_4[2].y = tmpvar_3[1].z;
  tmpvar_4[2].z = tmpvar_3[2].z;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (tmpvar_4 * (((_World2Object * tmpvar_5).xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec4 tex;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (col.xyz, _Color.xyz, tmpvar_7);
  col.xyz = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = col.xyz;
  tmpvar_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = col.w;
  tmpvar_3 = tmpvar_11;
  c = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_LightmapInd, xlv_TEXCOORD1);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize (xlv_TEXCOORD2);
  mediump vec4 tmpvar_15;
  mediump vec3 viewDir;
  viewDir = tmpvar_14;
  highp float nh;
  mediump vec3 scalePerBasisVector_i0;
  mediump vec3 lm_i0;
  lowp vec3 tmpvar_16;
  tmpvar_16 = ((8.0 * tmpvar_12.w) * tmpvar_12.xyz);
  lm_i0 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = ((8.0 * tmpvar_13.w) * tmpvar_13.xyz);
  scalePerBasisVector_i0 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (vec3(0.0, 0.0, 1.0), normalize ((normalize ((((scalePerBasisVector_i0.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_i0.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_i0.z * vec3(-0.408248, -0.707107, 0.57735)))) + viewDir))));
  nh = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = lm_i0;
  tmpvar_19.w = pow (nh, 0.0);
  tmpvar_15 = tmpvar_19;
  c.xyz = vec3(0.0, 0.0, 0.0);
  mediump vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_2 * tmpvar_15.xyz);
  c.xyz = tmpvar_20;
  c.w = tmpvar_3;
  c.w = tmpvar_3;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Matrix 8 [_World2Object]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
"agal_vs
c16 1.0 0.0 0.0 0.0
[bc]
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaabaaahacabaaaancaaaaaaaaaaaaaaajacaaaaaa mul r1.xyz, a1.zxyw, r0.yzxx
aaaaaaaaaaaaahacafaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, a5
adaaaaaaacaaahacabaaaamjaaaaaaaaaaaaaafcacaaaaaa mul r2.xyz, a1.yzxw, r0.zxyy
acaaaaaaaaaaahacacaaaakeacaaaaaaabaaaakeacaaaaaa sub r0.xyz, r2.xyzz, r1.xyzz
adaaaaaaabaaahacaaaaaakeacaaaaaaafaaaappaaaaaaaa mul r1.xyz, r0.xyzz, a5.w
aaaaaaaaaaaaahacanaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c13
aaaaaaaaaaaaaiacbaaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c16.x
bdaaaaaaacaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r2.z, r0, c10
bdaaaaaaacaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r2.x, r0, c8
bdaaaaaaacaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r2.y, r0, c9
adaaaaaaacaaahacacaaaakeacaaaaaaamaaaappabaaaaaa mul r2.xyz, r2.xyzz, c12.w
acaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaaoeaaaaaaaa sub r0.xyz, r2.xyzz, a0
bcaaaaaaacaaacaeaaaaaakeacaaaaaaabaaaakeacaaaaaa dp3 v2.y, r0.xyzz, r1.xyzz
bcaaaaaaacaaaeaeabaaaaoeaaaaaaaaaaaaaakeacaaaaaa dp3 v2.z, a1, r0.xyzz
bcaaaaaaacaaabaeaaaaaakeacaaaaaaafaaaaoeaaaaaaaa dp3 v2.x, r0.xyzz, a5
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
adaaaaaaaaaaadacadaaaaoeaaaaaaaaapaaaaoeabaaaaaa mul r0.xy, a3, c15
abaaaaaaaaaaadaeaaaaaafeacaaaaaaapaaaaooabaaaaaa add v0.xy, r0.xyyy, c15.zwzw
adaaaaaaaaaaadacaeaaaaoeaaaaaaaaaoaaaaoeabaaaaaa mul r0.xy, a4, c14
abaaaaaaabaaadaeaaaaaafeacaaaaaaaoaaaaooabaaaaaa add v1.xy, r0.xyyy, c14.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 9 [unity_Scale]
Vector 10 [_WorldSpaceCameraPos]
Matrix 5 [_Object2World]
Vector 11 [unity_4LightPosX0]
Vector 12 [unity_4LightPosY0]
Vector 13 [unity_4LightPosZ0]
Vector 14 [unity_4LightAtten0]
Vector 15 [unity_LightColor0]
Vector 16 [unity_LightColor1]
Vector 17 [unity_LightColor2]
Vector 18 [unity_LightColor3]
Vector 19 [unity_SHAr]
Vector 20 [unity_SHAg]
Vector 21 [unity_SHAb]
Vector 22 [unity_SHBr]
Vector 23 [unity_SHBg]
Vector 24 [unity_SHBb]
Vector 25 [unity_SHC]
Vector 26 [_MainTex_ST]
"!!ARBvp1.0
# 61 ALU
PARAM c[27] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..26] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R3.xyz, vertex.normal, c[9].w;
DP3 R5.x, R3, c[5];
DP4 R4.zw, vertex.position, c[6];
ADD R2, -R4.z, c[12];
DP3 R4.z, R3, c[6];
DP3 R3.x, R3, c[7];
DP4 R3.w, vertex.position, c[5];
MUL R0, R4.z, R2;
ADD R1, -R3.w, c[11];
DP4 R4.xy, vertex.position, c[7];
MUL R2, R2, R2;
MOV R5.z, R3.x;
MOV R5.y, R4.z;
MOV R5.w, c[0].x;
MAD R0, R5.x, R1, R0;
MAD R2, R1, R1, R2;
ADD R1, -R4.x, c[13];
MAD R2, R1, R1, R2;
MAD R0, R3.x, R1, R0;
MUL R1, R2, c[14];
ADD R1, R1, c[0].x;
MOV result.texcoord[1].z, R3.x;
RSQ R2.x, R2.x;
RSQ R2.y, R2.y;
RSQ R2.z, R2.z;
RSQ R2.w, R2.w;
MUL R0, R0, R2;
DP4 R2.z, R5, c[21];
DP4 R2.y, R5, c[20];
DP4 R2.x, R5, c[19];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[16];
MAD R1.xyz, R0.x, c[15], R1;
MAD R0.xyz, R0.z, c[17], R1;
MAD R1.xyz, R0.w, c[18], R0;
MUL R0, R5.xyzz, R5.yzzx;
MUL R1.w, R4.z, R4.z;
DP4 R5.w, R0, c[24];
DP4 R5.z, R0, c[23];
DP4 R5.y, R0, c[22];
MAD R1.w, R5.x, R5.x, -R1;
MUL R0.xyz, R1.w, c[25];
ADD R2.xyz, R2, R5.yzww;
ADD R0.xyz, R2, R0;
MOV R3.x, R4.w;
MOV R3.y, R4;
ADD result.texcoord[2].xyz, R0, R1;
MOV result.color, vertex.color;
MOV result.texcoord[1].y, R4.z;
MOV result.texcoord[1].x, R5;
ADD result.texcoord[3].xyz, -R3.wxyw, c[10];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[26], c[26].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 61 instructions, 6 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_Scale]
Vector 9 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Vector 10 [unity_4LightPosX0]
Vector 11 [unity_4LightPosY0]
Vector 12 [unity_4LightPosZ0]
Vector 13 [unity_4LightAtten0]
Vector 14 [unity_LightColor0]
Vector 15 [unity_LightColor1]
Vector 16 [unity_LightColor2]
Vector 17 [unity_LightColor3]
Vector 18 [unity_SHAr]
Vector 19 [unity_SHAg]
Vector 20 [unity_SHAb]
Vector 21 [unity_SHBr]
Vector 22 [unity_SHBg]
Vector 23 [unity_SHBb]
Vector 24 [unity_SHC]
Vector 25 [_MainTex_ST]
"vs_2_0
; 61 ALU
def c26, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_color0 v3
mul r3.xyz, v1, c8.w
dp3 r5.x, r3, c4
dp4 r4.zw, v0, c5
add r2, -r4.z, c11
dp3 r4.z, r3, c5
dp3 r3.x, r3, c6
dp4 r3.w, v0, c4
mul r0, r4.z, r2
add r1, -r3.w, c10
dp4 r4.xy, v0, c6
mul r2, r2, r2
mov r5.z, r3.x
mov r5.y, r4.z
mov r5.w, c26.x
mad r0, r5.x, r1, r0
mad r2, r1, r1, r2
add r1, -r4.x, c12
mad r2, r1, r1, r2
mad r0, r3.x, r1, r0
mul r1, r2, c13
add r1, r1, c26.x
mov oT1.z, r3.x
rsq r2.x, r2.x
rsq r2.y, r2.y
rsq r2.z, r2.z
rsq r2.w, r2.w
mul r0, r0, r2
dp4 r2.z, r5, c20
dp4 r2.y, r5, c19
dp4 r2.x, r5, c18
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c26.y
mul r0, r0, r1
mul r1.xyz, r0.y, c15
mad r1.xyz, r0.x, c14, r1
mad r0.xyz, r0.z, c16, r1
mad r1.xyz, r0.w, c17, r0
mul r0, r5.xyzz, r5.yzzx
mul r1.w, r4.z, r4.z
dp4 r5.w, r0, c23
dp4 r5.z, r0, c22
dp4 r5.y, r0, c21
mad r1.w, r5.x, r5.x, -r1
mul r0.xyz, r1.w, c24
add r2.xyz, r2, r5.yzww
add r0.xyz, r2, r0
mov r3.x, r4.w
mov r3.y, r4
add oT2.xyz, r0, r1
mov oD0, v3
mov oT1.y, r4.z
mov oT1.x, r5
add oT3.xyz, -r3.wxyw, c9
mad oT0.xy, v2, c25, c25.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightAtten0;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight;
  lowp vec3 tmpvar_1;
  lowp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  mediump vec3 tmpvar_6;
  mediump vec4 normal;
  normal = tmpvar_5;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_7;
  tmpvar_7 = dot (unity_SHAr, normal);
  x1.x = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = dot (unity_SHAg, normal);
  x1.y = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (unity_SHAb, normal);
  x1.z = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHBr, tmpvar_10);
  x2.x = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (unity_SHBg, tmpvar_10);
  x2.y = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHBb, tmpvar_10);
  x2.z = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (unity_SHC.xyz * vC);
  x3 = tmpvar_15;
  tmpvar_6 = ((x1 + x2) + x3);
  shlight = tmpvar_6;
  tmpvar_2 = shlight;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosX0 - tmpvar_16.x);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosY0 - tmpvar_16.y);
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosZ0 - tmpvar_16.z);
  highp vec4 tmpvar_20;
  tmpvar_20 = (((tmpvar_17 * tmpvar_17) + (tmpvar_18 * tmpvar_18)) + (tmpvar_19 * tmpvar_19));
  highp vec4 tmpvar_21;
  tmpvar_21 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_17 * tmpvar_4.x) + (tmpvar_18 * tmpvar_4.y)) + (tmpvar_19 * tmpvar_4.z)) * inversesqrt (tmpvar_20))) * (1.0/((1.0 + (tmpvar_20 * unity_4LightAtten0)))));
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 + ((((unity_LightColor[0].xyz * tmpvar_21.x) + (unity_LightColor[1].xyz * tmpvar_21.y)) + (unity_LightColor[2].xyz * tmpvar_21.z)) + (unity_LightColor[3].xyz * tmpvar_21.w)));
  tmpvar_2 = tmpvar_22;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec4 tex;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (col.xyz, _Color.xyz, tmpvar_7);
  col.xyz = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = col.xyz;
  tmpvar_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = col.w;
  tmpvar_3 = tmpvar_11;
  lowp vec4 c_i0;
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz));
  highp vec3 tmpvar_13;
  tmpvar_13 = (((tmpvar_2 * _LightColor0.xyz) * tmpvar_12) * 2.0);
  c_i0.xyz = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = tmpvar_3;
  c_i0.w = tmpvar_14;
  c = c_i0;
  c.xyz = (c_i0.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  c.w = tmpvar_3;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightAtten0;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight;
  lowp vec3 tmpvar_1;
  lowp vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  mediump vec3 tmpvar_6;
  mediump vec4 normal;
  normal = tmpvar_5;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_7;
  tmpvar_7 = dot (unity_SHAr, normal);
  x1.x = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = dot (unity_SHAg, normal);
  x1.y = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (unity_SHAb, normal);
  x1.z = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHBr, tmpvar_10);
  x2.x = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (unity_SHBg, tmpvar_10);
  x2.y = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHBb, tmpvar_10);
  x2.z = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (unity_SHC.xyz * vC);
  x3 = tmpvar_15;
  tmpvar_6 = ((x1 + x2) + x3);
  shlight = tmpvar_6;
  tmpvar_2 = shlight;
  highp vec3 tmpvar_16;
  tmpvar_16 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosX0 - tmpvar_16.x);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosY0 - tmpvar_16.y);
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosZ0 - tmpvar_16.z);
  highp vec4 tmpvar_20;
  tmpvar_20 = (((tmpvar_17 * tmpvar_17) + (tmpvar_18 * tmpvar_18)) + (tmpvar_19 * tmpvar_19));
  highp vec4 tmpvar_21;
  tmpvar_21 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_17 * tmpvar_4.x) + (tmpvar_18 * tmpvar_4.y)) + (tmpvar_19 * tmpvar_4.z)) * inversesqrt (tmpvar_20))) * (1.0/((1.0 + (tmpvar_20 * unity_4LightAtten0)))));
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 + ((((unity_LightColor[0].xyz * tmpvar_21.x) + (unity_LightColor[1].xyz * tmpvar_21.y)) + (unity_LightColor[2].xyz * tmpvar_21.z)) + (unity_LightColor[3].xyz * tmpvar_21.w)));
  tmpvar_2 = tmpvar_22;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec4 tex;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (col.xyz, _Color.xyz, tmpvar_7);
  col.xyz = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = col.xyz;
  tmpvar_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = col.w;
  tmpvar_3 = tmpvar_11;
  lowp vec4 c_i0;
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz));
  highp vec3 tmpvar_13;
  tmpvar_13 = (((tmpvar_2 * _LightColor0.xyz) * tmpvar_12) * 2.0);
  c_i0.xyz = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = tmpvar_3;
  c_i0.w = tmpvar_14;
  c = c_i0;
  c.xyz = (c_i0.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  c.w = tmpvar_3;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_Scale]
Vector 9 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Vector 10 [unity_4LightPosX0]
Vector 11 [unity_4LightPosY0]
Vector 12 [unity_4LightPosZ0]
Vector 13 [unity_4LightAtten0]
Vector 14 [unity_LightColor0]
Vector 15 [unity_LightColor1]
Vector 16 [unity_LightColor2]
Vector 17 [unity_LightColor3]
Vector 18 [unity_SHAr]
Vector 19 [unity_SHAg]
Vector 20 [unity_SHAb]
Vector 21 [unity_SHBr]
Vector 22 [unity_SHBg]
Vector 23 [unity_SHBb]
Vector 24 [unity_SHC]
Vector 25 [_MainTex_ST]
"agal_vs
c26 1.0 0.0 0.0 0.0
[bc]
adaaaaaaadaaahacabaaaaoeaaaaaaaaaiaaaappabaaaaaa mul r3.xyz, a1, c8.w
bcaaaaaaafaaabacadaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r5.x, r3.xyzz, c4
bdaaaaaaaeaaamacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r4.zw, a0, c5
bfaaaaaaacaaaeacaeaaaakkacaaaaaaaaaaaaaaaaaaaaaa neg r2.z, r4.z
abaaaaaaacaaapacacaaaakkacaaaaaaalaaaaoeabaaaaaa add r2, r2.z, c11
bcaaaaaaaeaaaeacadaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r4.z, r3.xyzz, c5
bcaaaaaaadaaabacadaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r3.x, r3.xyzz, c6
bdaaaaaaadaaaiacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r3.w, a0, c4
adaaaaaaaaaaapacaeaaaakkacaaaaaaacaaaaoeacaaaaaa mul r0, r4.z, r2
bfaaaaaaabaaaiacadaaaappacaaaaaaaaaaaaaaaaaaaaaa neg r1.w, r3.w
abaaaaaaabaaapacabaaaappacaaaaaaakaaaaoeabaaaaaa add r1, r1.w, c10
bdaaaaaaaeaaadacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r4.xy, a0, c6
adaaaaaaacaaapacacaaaaoeacaaaaaaacaaaaoeacaaaaaa mul r2, r2, r2
aaaaaaaaafaaaeacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r5.z, r3.x
aaaaaaaaafaaacacaeaaaakkacaaaaaaaaaaaaaaaaaaaaaa mov r5.y, r4.z
aaaaaaaaafaaaiacbkaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r5.w, c26.x
adaaaaaaagaaapacafaaaaaaacaaaaaaabaaaaoeacaaaaaa mul r6, r5.x, r1
abaaaaaaaaaaapacagaaaaoeacaaaaaaaaaaaaoeacaaaaaa add r0, r6, r0
adaaaaaaagaaapacabaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r6, r1, r1
abaaaaaaacaaapacagaaaaoeacaaaaaaacaaaaoeacaaaaaa add r2, r6, r2
bfaaaaaaabaaabacaeaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.x, r4.x
abaaaaaaabaaapacabaaaaaaacaaaaaaamaaaaoeabaaaaaa add r1, r1.x, c12
adaaaaaaagaaapacabaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r6, r1, r1
abaaaaaaacaaapacagaaaaoeacaaaaaaacaaaaoeacaaaaaa add r2, r6, r2
adaaaaaaagaaapacadaaaaaaacaaaaaaabaaaaoeacaaaaaa mul r6, r3.x, r1
abaaaaaaaaaaapacagaaaaoeacaaaaaaaaaaaaoeacaaaaaa add r0, r6, r0
adaaaaaaabaaapacacaaaaoeacaaaaaaanaaaaoeabaaaaaa mul r1, r2, c13
abaaaaaaabaaapacabaaaaoeacaaaaaabkaaaaaaabaaaaaa add r1, r1, c26.x
aaaaaaaaabaaaeaeadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov v1.z, r3.x
akaaaaaaacaaabacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r2.x, r2.x
akaaaaaaacaaacacacaaaaffacaaaaaaaaaaaaaaaaaaaaaa rsq r2.y, r2.y
akaaaaaaacaaaeacacaaaakkacaaaaaaaaaaaaaaaaaaaaaa rsq r2.z, r2.z
akaaaaaaacaaaiacacaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r2.w, r2.w
adaaaaaaaaaaapacaaaaaaoeacaaaaaaacaaaaoeacaaaaaa mul r0, r0, r2
bdaaaaaaacaaaeacafaaaaoeacaaaaaabeaaaaoeabaaaaaa dp4 r2.z, r5, c20
bdaaaaaaacaaacacafaaaaoeacaaaaaabdaaaaoeabaaaaaa dp4 r2.y, r5, c19
bdaaaaaaacaaabacafaaaaoeacaaaaaabcaaaaoeabaaaaaa dp4 r2.x, r5, c18
afaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r1.x, r1.x
afaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rcp r1.y, r1.y
afaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rcp r1.w, r1.w
afaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rcp r1.z, r1.z
ahaaaaaaaaaaapacaaaaaaoeacaaaaaabkaaaaffabaaaaaa max r0, r0, c26.y
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
adaaaaaaabaaahacaaaaaaffacaaaaaaapaaaaoeabaaaaaa mul r1.xyz, r0.y, c15
adaaaaaaagaaahacaaaaaaaaacaaaaaaaoaaaaoeabaaaaaa mul r6.xyz, r0.x, c14
abaaaaaaabaaahacagaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r6.xyzz, r1.xyzz
adaaaaaaaaaaahacaaaaaakkacaaaaaabaaaaaoeabaaaaaa mul r0.xyz, r0.z, c16
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaahacaaaaaappacaaaaaabbaaaaoeabaaaaaa mul r1.xyz, r0.w, c17
abaaaaaaabaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r1.xyz, r1.xyzz, r0.xyzz
adaaaaaaaaaaapacafaaaakeacaaaaaaafaaaacjacaaaaaa mul r0, r5.xyzz, r5.yzzx
adaaaaaaabaaaiacaeaaaakkacaaaaaaaeaaaakkacaaaaaa mul r1.w, r4.z, r4.z
bdaaaaaaafaaaiacaaaaaaoeacaaaaaabhaaaaoeabaaaaaa dp4 r5.w, r0, c23
bdaaaaaaafaaaeacaaaaaaoeacaaaaaabgaaaaoeabaaaaaa dp4 r5.z, r0, c22
bdaaaaaaafaaacacaaaaaaoeacaaaaaabfaaaaoeabaaaaaa dp4 r5.y, r0, c21
adaaaaaaagaaaiacafaaaaaaacaaaaaaafaaaaaaacaaaaaa mul r6.w, r5.x, r5.x
acaaaaaaabaaaiacagaaaappacaaaaaaabaaaappacaaaaaa sub r1.w, r6.w, r1.w
adaaaaaaaaaaahacabaaaappacaaaaaabiaaaaoeabaaaaaa mul r0.xyz, r1.w, c24
abaaaaaaacaaahacacaaaakeacaaaaaaafaaaapjacaaaaaa add r2.xyz, r2.xyzz, r5.yzww
abaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r2.xyzz, r0.xyzz
aaaaaaaaadaaabacaeaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r3.x, r4.w
aaaaaaaaadaaacacaeaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r3.y, r4.y
abaaaaaaacaaahaeaaaaaakeacaaaaaaabaaaakeacaaaaaa add v2.xyz, r0.xyzz, r1.xyzz
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
aaaaaaaaabaaacaeaeaaaakkacaaaaaaaaaaaaaaaaaaaaaa mov v1.y, r4.z
aaaaaaaaabaaabaeafaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov v1.x, r5.x
bfaaaaaaagaaalacadaaaapdacaaaaaaaaaaaaaaaaaaaaaa neg r6.xyw, r3.wxww
abaaaaaaadaaahaeagaaaafdacaaaaaaajaaaaoeabaaaaaa add v3.xyz, r6.wxyy, c9
adaaaaaaagaaadacadaaaaoeaaaaaaaabjaaaaoeabaaaaaa mul r6.xy, a3, c25
abaaaaaaaaaaadaeagaaaafeacaaaaaabjaaaaooabaaaaaa add v0.xy, r6.xyyy, c25.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

}
Program "fp" {
// Fragment combos: 3
//   opengl - ALU: 12 to 14, TEX: 2 to 3
//   d3d9 - ALU: 10 to 13, TEX: 2 to 3
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 14 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 0.5, 0, 2 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.z, fragment.texcoord[0], texture[1], 2D;
MUL R0.xyz, fragment.color.primary, R0;
ADD R1.xyw, -R0.xyzz, c[2].xyzz;
MUL R1.xyz, R1.z, R1.xyww;
MAD R0.xyz, R1, c[3].x, R0;
DP3 R1.w, fragment.texcoord[1], c[0];
MAX R1.w, R1, c[3].y;
MUL R1.xyz, R0, c[1];
MUL R1.xyz, R1, R1.w;
MUL R1.xyz, R1, c[3].z;
MUL R1.w, fragment.color.primary, c[2];
MAD result.color.xyz, R0, fragment.texcoord[2], R1;
MUL result.color.w, R1, R0;
END
# 14 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
"ps_2_0
; 13 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c3, 0.50000000, 0.00000000, 2.00000000, 0
dcl t0.xy
dcl v0
dcl t1.xyz
dcl t2.xyz
texld r1, t0, s1
texld r0, t0, s0
mul r2.xyz, v0, r0
add_pp r0.xyz, -r2, c2
mul_pp r1.xyz, r1.z, r0
mad_pp r1.xyz, r1, c3.x, r2
dp3_pp r0.x, t1, c0
mul_pp r2.xyz, r1, c1
max_pp r0.x, r0, c3.y
mul_pp r0.xyz, r2, r0.x
mul r2.xyz, r0, c3.z
mul r0.x, v0.w, c2.w
mad_pp r1.xyz, r1, t2, r2
mul r1.w, r0.x, r0
mov_pp oC0, r1
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
"agal_ps
c3 0.5 0.0 2.0 0.0
[bc]
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r1, v0, s1 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r0, v0, s0 <2d wrap linear point>
adaaaaaaacaaahacahaaaaoeaeaaaaaaaaaaaakeacaaaaaa mul r2.xyz, v7, r0.xyzz
bfaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xyz, r2.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaaoeabaaaaaa add r0.xyz, r0.xyzz, c2
adaaaaaaabaaahacabaaaakkacaaaaaaaaaaaakeacaaaaaa mul r1.xyz, r1.z, r0.xyzz
adaaaaaaabaaahacabaaaakeacaaaaaaadaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c3.x
abaaaaaaabaaahacabaaaakeacaaaaaaacaaaakeacaaaaaa add r1.xyz, r1.xyzz, r2.xyzz
bcaaaaaaaaaaabacabaaaaoeaeaaaaaaaaaaaaoeabaaaaaa dp3 r0.x, v1, c0
adaaaaaaacaaahacabaaaakeacaaaaaaabaaaaoeabaaaaaa mul r2.xyz, r1.xyzz, c1
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaadaaaaffabaaaaaa max r0.x, r0.x, c3.y
adaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r0.xyz, r2.xyzz, r0.x
adaaaaaaacaaahacaaaaaakeacaaaaaaadaaaakkabaaaaaa mul r2.xyz, r0.xyzz, c3.z
adaaaaaaaaaaabacahaaaappaeaaaaaaacaaaappabaaaaaa mul r0.x, v7.w, c2.w
adaaaaaaabaaahacabaaaakeacaaaaaaacaaaaoeaeaaaaaa mul r1.xyz, r1.xyzz, v2
abaaaaaaabaaahacabaaaakeacaaaaaaacaaaakeacaaaaaa add r1.xyz, r1.xyzz, r2.xyzz
adaaaaaaabaaaiacaaaaaaaaacaaaaaaaaaaaappacaaaaaa mul r1.w, r0.x, r0.w
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
SetTexture 2 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.5, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[2], 2D;
TEX R2.z, fragment.texcoord[0], texture[1], 2D;
MUL R2.xyw, fragment.color.primary.xyzz, R0.xyzz;
ADD R0.xyz, -R2.xyww, c[0];
MUL R0.xyz, R2.z, R0;
MAD R0.xyz, R0, c[1].x, R2.xyww;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, R0;
MUL R0.x, fragment.color.primary.w, c[0].w;
MUL result.color.xyz, R1, c[1].y;
MUL result.color.w, R0.x, R0;
END
# 12 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
SetTexture 2 [unity_Lightmap] 2D
"ps_2_0
; 10 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.50000000, 8.00000000, 0, 0
dcl t0.xy
dcl v0
dcl t1.xy
texld r1, t0, s1
texld r0, t1, s2
texld r2, t0, s0
mul r2.xyz, v0, r2
mul_pp r0.xyz, r0.w, r0
add_pp r3.xyz, -r2, c0
mul_pp r1.xyz, r1.z, r3
mad_pp r1.xyz, r1, c1.x, r2
mul_pp r0.xyz, r0, r1
mul r1.x, v0.w, c0.w
mul_pp r0.xyz, r0, c1.y
mul r0.w, r1.x, r2
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
SetTexture 2 [unity_Lightmap] 2D
"agal_ps
c1 0.5 8.0 0.0 0.0
[bc]
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r1, v0, s1 <2d wrap linear point>
ciaaaaaaaaaaapacabaaaaoeaeaaaaaaacaaaaaaafaababb tex r0, v1, s2 <2d wrap linear point>
ciaaaaaaacaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r2, v0, s0 <2d wrap linear point>
adaaaaaaacaaahacahaaaaoeaeaaaaaaacaaaakeacaaaaaa mul r2.xyz, v7, r2.xyzz
adaaaaaaaaaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r0.w, r0.xyzz
bfaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r3.xyz, r2.xyzz
abaaaaaaadaaahacadaaaakeacaaaaaaaaaaaaoeabaaaaaa add r3.xyz, r3.xyzz, c0
adaaaaaaabaaahacabaaaakkacaaaaaaadaaaakeacaaaaaa mul r1.xyz, r1.z, r3.xyzz
adaaaaaaabaaahacabaaaakeacaaaaaaabaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c1.x
abaaaaaaabaaahacabaaaakeacaaaaaaacaaaakeacaaaaaa add r1.xyz, r1.xyzz, r2.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaabacahaaaappaeaaaaaaaaaaaappabaaaaaa mul r1.x, v7.w, c0.w
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c1.y
adaaaaaaaaaaaiacabaaaaaaacaaaaaaacaaaappacaaaaaa mul r0.w, r1.x, r2.w
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
SetTexture 2 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.5, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[2], 2D;
TEX R2.z, fragment.texcoord[0], texture[1], 2D;
MUL R2.xyw, fragment.color.primary.xyzz, R0.xyzz;
ADD R0.xyz, -R2.xyww, c[0];
MUL R0.xyz, R2.z, R0;
MAD R0.xyz, R0, c[1].x, R2.xyww;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, R0;
MUL R0.x, fragment.color.primary.w, c[0].w;
MUL result.color.xyz, R1, c[1].y;
MUL result.color.w, R0.x, R0;
END
# 12 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
SetTexture 2 [unity_Lightmap] 2D
"ps_2_0
; 10 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.50000000, 8.00000000, 0, 0
dcl t0.xy
dcl v0
dcl t1.xy
texld r1, t0, s1
texld r0, t1, s2
texld r2, t0, s0
mul r2.xyz, v0, r2
mul_pp r0.xyz, r0.w, r0
add_pp r3.xyz, -r2, c0
mul_pp r1.xyz, r1.z, r3
mad_pp r1.xyz, r1, c1.x, r2
mul_pp r0.xyz, r0, r1
mul r1.x, v0.w, c0.w
mul_pp r0.xyz, r0, c1.y
mul r0.w, r1.x, r2
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
SetTexture 2 [unity_Lightmap] 2D
"agal_ps
c1 0.5 8.0 0.0 0.0
[bc]
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r1, v0, s1 <2d wrap linear point>
ciaaaaaaaaaaapacabaaaaoeaeaaaaaaacaaaaaaafaababb tex r0, v1, s2 <2d wrap linear point>
ciaaaaaaacaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r2, v0, s0 <2d wrap linear point>
adaaaaaaacaaahacahaaaaoeaeaaaaaaacaaaakeacaaaaaa mul r2.xyz, v7, r2.xyzz
adaaaaaaaaaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r0.w, r0.xyzz
bfaaaaaaadaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r3.xyz, r2.xyzz
abaaaaaaadaaahacadaaaakeacaaaaaaaaaaaaoeabaaaaaa add r3.xyz, r3.xyzz, c0
adaaaaaaabaaahacabaaaakkacaaaaaaadaaaakeacaaaaaa mul r1.xyz, r1.z, r3.xyzz
adaaaaaaabaaahacabaaaakeacaaaaaaabaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c1.x
abaaaaaaabaaahacabaaaakeacaaaaaaacaaaakeacaaaaaa add r1.xyz, r1.xyzz, r2.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaabacahaaaappaeaaaaaaaaaaaappabaaaaaa mul r1.x, v7.w, c0.w
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c1.y
adaaaaaaaaaaaiacabaaaaaaacaaaaaaacaaaappacaaaaaa mul r0.w, r1.x, r2.w
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

}
	}
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardAdd" }
		ZWrite Off Blend One One Fog { Color (0,0,0,0) }
		Blend SrcAlpha One
Program "vp" {
// Vertex combos: 5
//   opengl - ALU: 15 to 20
//   d3d9 - ALU: 15 to 20
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 16 [_MainTex_ST]
"!!ARBvp1.0
# 19 ALU
PARAM c[17] = { program.local[0],
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[13].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
MOV result.color, vertex.color;
DP4 result.texcoord[4].z, R0, c[11];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
ADD result.texcoord[2].xyz, -R0, c[15];
ADD result.texcoord[3].xyz, -R0, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 19 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 15 [_MainTex_ST]
"vs_2_0
; 19 ALU
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_color0 v3
mul r1.xyz, v1, c12.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
mov oD0, v3
dp4 oT4.z, r0, c10
dp4 oT4.y, r0, c9
dp4 oT4.x, r0, c8
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp3 oT1.x, r1, c4
add oT2.xyz, -r0, c14
add oT3.xyz, -r0, c13
mad oT0.xy, v2, c15, c15.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "POINT" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec4 tex;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (col.xyz, _Color.xyz, tmpvar_7);
  col.xyz = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = col.xyz;
  tmpvar_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = col.w;
  tmpvar_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize (xlv_TEXCOORD2);
  lightDir = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = vec2(dot (xlv_TEXCOORD4, xlv_TEXCOORD4));
  lowp float atten;
  atten = texture2D (_LightTexture0, tmpvar_13).w;
  lowp vec4 c_i0;
  lowp float tmpvar_14;
  tmpvar_14 = max (0.0, dot (xlv_TEXCOORD1, lightDir));
  highp vec3 tmpvar_15;
  tmpvar_15 = (((tmpvar_2 * _LightColor0.xyz) * tmpvar_14) * (atten * 2.0));
  c_i0.xyz = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = tmpvar_3;
  c_i0.w = tmpvar_16;
  c = c_i0;
  c.w = tmpvar_3;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec4 tex;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (col.xyz, _Color.xyz, tmpvar_7);
  col.xyz = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = col.xyz;
  tmpvar_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = col.w;
  tmpvar_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize (xlv_TEXCOORD2);
  lightDir = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = vec2(dot (xlv_TEXCOORD4, xlv_TEXCOORD4));
  lowp float atten;
  atten = texture2D (_LightTexture0, tmpvar_13).w;
  lowp vec4 c_i0;
  lowp float tmpvar_14;
  tmpvar_14 = max (0.0, dot (xlv_TEXCOORD1, lightDir));
  highp vec3 tmpvar_15;
  tmpvar_15 = (((tmpvar_2 * _LightColor0.xyz) * tmpvar_14) * (atten * 2.0));
  c_i0.xyz = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = tmpvar_3;
  c_i0.w = tmpvar_16;
  c = c_i0;
  c.w = tmpvar_3;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 15 [_MainTex_ST]
"agal_vs
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaamaaaappabaaaaaa mul r1.xyz, a1, c12.w
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
bdaaaaaaaeaaaeaeaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 v4.z, r0, c10
bdaaaaaaaeaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v4.y, r0, c9
bdaaaaaaaeaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v4.x, r0, c8
bcaaaaaaabaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v1.z, r1.xyzz, c6
bcaaaaaaabaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v1.y, r1.xyzz, c5
bcaaaaaaabaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v1.x, r1.xyzz, c4
bfaaaaaaabaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r1.xyz, r0.xyzz
abaaaaaaacaaahaeabaaaakeacaaaaaaaoaaaaoeabaaaaaa add v2.xyz, r1.xyzz, c14
bfaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xyz, r0.xyzz
abaaaaaaadaaahaeaaaaaakeacaaaaaaanaaaaoeabaaaaaa add v3.xyz, r0.xyzz, c13
adaaaaaaaaaaadacadaaaaoeaaaaaaaaapaaaaoeabaaaaaa mul r0.xy, a3, c15
abaaaaaaaaaaadaeaaaaaafeacaaaaaaapaaaaooabaaaaaa add v0.xy, r0.xyyy, c15.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 9 [unity_Scale]
Vector 10 [_WorldSpaceCameraPos]
Vector 11 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Vector 12 [_MainTex_ST]
"!!ARBvp1.0
# 15 ALU
PARAM c[13] = { program.local[0],
		state.matrix.mvp,
		program.local[5..12] };
TEMP R0;
MUL R0.xyz, vertex.normal, c[9].w;
DP3 result.texcoord[1].z, R0, c[7];
DP3 result.texcoord[1].y, R0, c[6];
DP3 result.texcoord[1].x, R0, c[5];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MOV result.color, vertex.color;
MOV result.texcoord[2].xyz, c[11];
ADD result.texcoord[3].xyz, -R0, c[10];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[12], c[12].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 15 instructions, 1 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_Scale]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 11 [_MainTex_ST]
"vs_2_0
; 15 ALU
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_color0 v3
mul r0.xyz, v1, c8.w
dp3 oT1.z, r0, c6
dp3 oT1.y, r0, c5
dp3 oT1.x, r0, c4
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mov oD0, v3
mov oT2.xyz, c10
add oT3.xyz, -r0, c9
mad oT0.xy, v2, c11, c11.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec4 tex;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (col.xyz, _Color.xyz, tmpvar_7);
  col.xyz = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = col.xyz;
  tmpvar_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = col.w;
  tmpvar_3 = tmpvar_11;
  lightDir = xlv_TEXCOORD2;
  lowp vec4 c_i0;
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD1, lightDir));
  highp vec3 tmpvar_13;
  tmpvar_13 = (((tmpvar_2 * _LightColor0.xyz) * tmpvar_12) * 2.0);
  c_i0.xyz = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = tmpvar_3;
  c_i0.w = tmpvar_14;
  c = c_i0;
  c.w = tmpvar_3;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec4 tex;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (col.xyz, _Color.xyz, tmpvar_7);
  col.xyz = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = col.xyz;
  tmpvar_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = col.w;
  tmpvar_3 = tmpvar_11;
  lightDir = xlv_TEXCOORD2;
  lowp vec4 c_i0;
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD1, lightDir));
  highp vec3 tmpvar_13;
  tmpvar_13 = (((tmpvar_2 * _LightColor0.xyz) * tmpvar_12) * 2.0);
  c_i0.xyz = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = tmpvar_3;
  c_i0.w = tmpvar_14;
  c = c_i0;
  c.w = tmpvar_3;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_Scale]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 11 [_MainTex_ST]
"agal_vs
[bc]
adaaaaaaaaaaahacabaaaaoeaaaaaaaaaiaaaappabaaaaaa mul r0.xyz, a1, c8.w
bcaaaaaaabaaaeaeaaaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v1.z, r0.xyzz, c6
bcaaaaaaabaaacaeaaaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v1.y, r0.xyzz, c5
bcaaaaaaabaaabaeaaaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v1.x, r0.xyzz, c4
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
aaaaaaaaacaaahaeakaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.xyz, c10
bfaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xyz, r0.xyzz
abaaaaaaadaaahaeaaaaaakeacaaaaaaajaaaaoeabaaaaaa add v3.xyz, r0.xyzz, c9
adaaaaaaaaaaadacadaaaaoeaaaaaaaaalaaaaoeabaaaaaa mul r0.xy, a3, c11
abaaaaaaaaaaadaeaaaaaafeacaaaaaaalaaaaooabaaaaaa add v0.xy, r0.xyyy, c11.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 16 [_MainTex_ST]
"!!ARBvp1.0
# 20 ALU
PARAM c[17] = { program.local[0],
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[13].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
MOV result.color, vertex.color;
DP4 result.texcoord[4].w, R0, c[12];
DP4 result.texcoord[4].z, R0, c[11];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
ADD result.texcoord[2].xyz, -R0, c[15];
ADD result.texcoord[3].xyz, -R0, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 20 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 15 [_MainTex_ST]
"vs_2_0
; 20 ALU
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_color0 v3
mul r1.xyz, v1, c12.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
mov oD0, v3
dp4 oT4.w, r0, c11
dp4 oT4.z, r0, c10
dp4 oT4.y, r0, c9
dp4 oT4.x, r0, c8
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp3 oT1.x, r1, c4
add oT2.xyz, -r0, c14
add oT3.xyz, -r0, c13
mad oT0.xy, v2, c15, c15.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec4 tex;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (col.xyz, _Color.xyz, tmpvar_7);
  col.xyz = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = col.xyz;
  tmpvar_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = col.w;
  tmpvar_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize (xlv_TEXCOORD2);
  lightDir = tmpvar_12;
  highp vec3 LightCoord_i0;
  LightCoord_i0 = xlv_TEXCOORD4.xyz;
  highp vec2 tmpvar_13;
  tmpvar_13 = vec2(dot (LightCoord_i0, LightCoord_i0));
  lowp float atten;
  atten = ((float((xlv_TEXCOORD4.z > 0.0)) * texture2D (_LightTexture0, ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w) + 0.5)).w) * texture2D (_LightTextureB0, tmpvar_13).w);
  lowp vec4 c_i0;
  lowp float tmpvar_14;
  tmpvar_14 = max (0.0, dot (xlv_TEXCOORD1, lightDir));
  highp vec3 tmpvar_15;
  tmpvar_15 = (((tmpvar_2 * _LightColor0.xyz) * tmpvar_14) * (atten * 2.0));
  c_i0.xyz = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = tmpvar_3;
  c_i0.w = tmpvar_16;
  c = c_i0;
  c.w = tmpvar_3;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec4 tex;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (col.xyz, _Color.xyz, tmpvar_7);
  col.xyz = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = col.xyz;
  tmpvar_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = col.w;
  tmpvar_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize (xlv_TEXCOORD2);
  lightDir = tmpvar_12;
  highp vec3 LightCoord_i0;
  LightCoord_i0 = xlv_TEXCOORD4.xyz;
  highp vec2 tmpvar_13;
  tmpvar_13 = vec2(dot (LightCoord_i0, LightCoord_i0));
  lowp float atten;
  atten = ((float((xlv_TEXCOORD4.z > 0.0)) * texture2D (_LightTexture0, ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w) + 0.5)).w) * texture2D (_LightTextureB0, tmpvar_13).w);
  lowp vec4 c_i0;
  lowp float tmpvar_14;
  tmpvar_14 = max (0.0, dot (xlv_TEXCOORD1, lightDir));
  highp vec3 tmpvar_15;
  tmpvar_15 = (((tmpvar_2 * _LightColor0.xyz) * tmpvar_14) * (atten * 2.0));
  c_i0.xyz = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = tmpvar_3;
  c_i0.w = tmpvar_16;
  c = c_i0;
  c.w = tmpvar_3;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 15 [_MainTex_ST]
"agal_vs
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaamaaaappabaaaaaa mul r1.xyz, a1, c12.w
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
bdaaaaaaaeaaaiaeaaaaaaoeacaaaaaaalaaaaoeabaaaaaa dp4 v4.w, r0, c11
bdaaaaaaaeaaaeaeaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 v4.z, r0, c10
bdaaaaaaaeaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v4.y, r0, c9
bdaaaaaaaeaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v4.x, r0, c8
bcaaaaaaabaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v1.z, r1.xyzz, c6
bcaaaaaaabaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v1.y, r1.xyzz, c5
bcaaaaaaabaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v1.x, r1.xyzz, c4
bfaaaaaaabaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r1.xyz, r0.xyzz
abaaaaaaacaaahaeabaaaakeacaaaaaaaoaaaaoeabaaaaaa add v2.xyz, r1.xyzz, c14
bfaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xyz, r0.xyzz
abaaaaaaadaaahaeaaaaaakeacaaaaaaanaaaaoeabaaaaaa add v3.xyz, r0.xyzz, c13
adaaaaaaaaaaadacadaaaaoeaaaaaaaaapaaaaoeabaaaaaa mul r0.xy, a3, c15
abaaaaaaaaaaadaeaaaaaafeacaaaaaaapaaaaooabaaaaaa add v0.xy, r0.xyyy, c15.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 16 [_MainTex_ST]
"!!ARBvp1.0
# 19 ALU
PARAM c[17] = { program.local[0],
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[13].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
MOV result.color, vertex.color;
DP4 result.texcoord[4].z, R0, c[11];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
ADD result.texcoord[2].xyz, -R0, c[15];
ADD result.texcoord[3].xyz, -R0, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 19 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 15 [_MainTex_ST]
"vs_2_0
; 19 ALU
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_color0 v3
mul r1.xyz, v1, c12.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
mov oD0, v3
dp4 oT4.z, r0, c10
dp4 oT4.y, r0, c9
dp4 oT4.x, r0, c8
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp3 oT1.x, r1, c4
add oT2.xyz, -r0, c14
add oT3.xyz, -r0, c13
mad oT0.xy, v2, c15, c15.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec4 tex;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (col.xyz, _Color.xyz, tmpvar_7);
  col.xyz = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = col.xyz;
  tmpvar_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = col.w;
  tmpvar_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize (xlv_TEXCOORD2);
  lightDir = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = vec2(dot (xlv_TEXCOORD4, xlv_TEXCOORD4));
  lowp float atten;
  atten = (texture2D (_LightTextureB0, tmpvar_13).w * textureCube (_LightTexture0, xlv_TEXCOORD4).w);
  lowp vec4 c_i0;
  lowp float tmpvar_14;
  tmpvar_14 = max (0.0, dot (xlv_TEXCOORD1, lightDir));
  highp vec3 tmpvar_15;
  tmpvar_15 = (((tmpvar_2 * _LightColor0.xyz) * tmpvar_14) * (atten * 2.0));
  c_i0.xyz = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = tmpvar_3;
  c_i0.w = tmpvar_16;
  c = c_i0;
  c.w = tmpvar_3;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec4 tex;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (col.xyz, _Color.xyz, tmpvar_7);
  col.xyz = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = col.xyz;
  tmpvar_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = col.w;
  tmpvar_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize (xlv_TEXCOORD2);
  lightDir = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = vec2(dot (xlv_TEXCOORD4, xlv_TEXCOORD4));
  lowp float atten;
  atten = (texture2D (_LightTextureB0, tmpvar_13).w * textureCube (_LightTexture0, xlv_TEXCOORD4).w);
  lowp vec4 c_i0;
  lowp float tmpvar_14;
  tmpvar_14 = max (0.0, dot (xlv_TEXCOORD1, lightDir));
  highp vec3 tmpvar_15;
  tmpvar_15 = (((tmpvar_2 * _LightColor0.xyz) * tmpvar_14) * (atten * 2.0));
  c_i0.xyz = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = tmpvar_3;
  c_i0.w = tmpvar_16;
  c = c_i0;
  c.w = tmpvar_3;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 15 [_MainTex_ST]
"agal_vs
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaamaaaappabaaaaaa mul r1.xyz, a1, c12.w
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
bdaaaaaaaeaaaeaeaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 v4.z, r0, c10
bdaaaaaaaeaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v4.y, r0, c9
bdaaaaaaaeaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v4.x, r0, c8
bcaaaaaaabaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v1.z, r1.xyzz, c6
bcaaaaaaabaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v1.y, r1.xyzz, c5
bcaaaaaaabaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v1.x, r1.xyzz, c4
bfaaaaaaabaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r1.xyz, r0.xyzz
abaaaaaaacaaahaeabaaaakeacaaaaaaaoaaaaoeabaaaaaa add v2.xyz, r1.xyzz, c14
bfaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xyz, r0.xyzz
abaaaaaaadaaahaeaaaaaakeacaaaaaaanaaaaoeabaaaaaa add v3.xyz, r0.xyzz, c13
adaaaaaaaaaaadacadaaaaoeaaaaaaaaapaaaaoeabaaaaaa mul r0.xy, a3, c15
abaaaaaaaaaaadaeaaaaaafeacaaaaaaapaaaaooabaaaaaa add v0.xy, r0.xyyy, c15.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 16 [_MainTex_ST]
"!!ARBvp1.0
# 18 ALU
PARAM c[17] = { program.local[0],
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[13].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
MOV result.color, vertex.color;
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
MOV result.texcoord[2].xyz, c[15];
ADD result.texcoord[3].xyz, -R0, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 18 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 15 [_MainTex_ST]
"vs_2_0
; 18 ALU
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_color0 v3
mul r1.xyz, v1, c12.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
mov oD0, v3
dp4 oT4.y, r0, c9
dp4 oT4.x, r0, c8
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp3 oT1.x, r1, c4
mov oT2.xyz, c14
add oT3.xyz, -r0, c13
mad oT0.xy, v2, c15, c15.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec2 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec4 tex;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (col.xyz, _Color.xyz, tmpvar_7);
  col.xyz = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = col.xyz;
  tmpvar_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = col.w;
  tmpvar_3 = tmpvar_11;
  lightDir = xlv_TEXCOORD2;
  lowp float atten;
  atten = texture2D (_LightTexture0, xlv_TEXCOORD4).w;
  lowp vec4 c_i0;
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD1, lightDir));
  highp vec3 tmpvar_13;
  tmpvar_13 = (((tmpvar_2 * _LightColor0.xyz) * tmpvar_12) * (atten * 2.0));
  c_i0.xyz = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = tmpvar_3;
  c_i0.w = tmpvar_14;
  c = c_i0;
  c.w = tmpvar_3;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec2 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _Object2World;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _Mask;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec4 tmpvar_1;
  tmpvar_1 = xlv_COLOR0;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 col;
  mediump vec3 mask;
  mediump vec4 tex;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex = tmpvar_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Mask, xlv_TEXCOORD0).xyz;
  mask = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_1.xyz * tex.xyz);
  col.xyz = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3((mask.z * 0.5));
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (col.xyz, _Color.xyz, tmpvar_7);
  col.xyz = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((tmpvar_1.w * _Color.w) * tex.w);
  col.w = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = col.xyz;
  tmpvar_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = col.w;
  tmpvar_3 = tmpvar_11;
  lightDir = xlv_TEXCOORD2;
  lowp float atten;
  atten = texture2D (_LightTexture0, xlv_TEXCOORD4).w;
  lowp vec4 c_i0;
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD1, lightDir));
  highp vec3 tmpvar_13;
  tmpvar_13 = (((tmpvar_2 * _LightColor0.xyz) * tmpvar_12) * (atten * 2.0));
  c_i0.xyz = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = tmpvar_3;
  c_i0.w = tmpvar_14;
  c = c_i0;
  c.w = tmpvar_3;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 15 [_MainTex_ST]
"agal_vs
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaamaaaappabaaaaaa mul r1.xyz, a1, c12.w
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
aaaaaaaaahaaapaeacaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v7, a2
bdaaaaaaaeaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v4.y, r0, c9
bdaaaaaaaeaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v4.x, r0, c8
bcaaaaaaabaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v1.z, r1.xyzz, c6
bcaaaaaaabaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v1.y, r1.xyzz, c5
bcaaaaaaabaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v1.x, r1.xyzz, c4
aaaaaaaaacaaahaeaoaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.xyz, c14
bfaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xyz, r0.xyzz
abaaaaaaadaaahaeaaaaaakeacaaaaaaanaaaaoeabaaaaaa add v3.xyz, r0.xyzz, c13
adaaaaaaaaaaadacadaaaaoeaaaaaaaaapaaaaoeabaaaaaa mul r0.xy, a3, c15
abaaaaaaaaaaadaeaaaaaafeacaaaaaaapaaaaooabaaaaaa add v0.xy, r0.xyyy, c15.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
aaaaaaaaaeaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.zw, c0
"
}

}
Program "fp" {
// Fragment combos: 5
//   opengl - ALU: 14 to 25, TEX: 2 to 4
//   d3d9 - ALU: 13 to 23, TEX: 2 to 4
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
SetTexture 2 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 19 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.5, 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TEX R0.z, fragment.texcoord[0], texture[1], 2D;
MUL R1.xyz, fragment.color.primary, R1;
DP3 R0.x, fragment.texcoord[4], fragment.texcoord[4];
ADD R2.xyz, -R1, c[1];
TEX R0.w, R0.x, texture[2], 2D;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R3.xyz, R0.x, fragment.texcoord[2];
MUL R0.xyz, R0.z, R2;
MAD R0.xyz, R0, c[2].x, R1;
DP3 R2.x, fragment.texcoord[1], R3;
MAX R1.x, R2, c[2].y;
MUL R0.xyz, R0, c[0];
MUL R0.xyz, R0, R1.x;
MUL R1.x, R0.w, c[2].z;
MUL R0.w, fragment.color.primary, c[1];
MUL result.color.xyz, R0, R1.x;
MUL result.color.w, R0, R1;
END
# 19 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
SetTexture 2 [_LightTexture0] 2D
"ps_2_0
; 18 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 0.00000000, 0.50000000, 2.00000000, 0
dcl t0.xy
dcl v0
dcl t1.xyz
dcl t2.xyz
dcl t4.xyz
texld r1, t0, s0
mul r1.xyz, v0, r1
dp3 r0.x, t4, t4
mov r0.xy, r0.x
add_pp r2.xyz, -r1, c1
texld r3, r0, s2
texld r0, t0, s1
mul_pp r2.xyz, r0.z, r2
mad_pp r1.xyz, r2, c2.y, r1
dp3_pp r0.x, t2, t2
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, t2
dp3_pp r0.x, t1, r0
mul_pp r1.xyz, r1, c0
max_pp r0.x, r0, c2
mul_pp r2.xyz, r1, r0.x
mul_pp r1.x, r3, c2.z
mul r0.x, v0.w, c1.w
mul r1.xyz, r2, r1.x
mul r1.w, r0.x, r1
mov_pp oC0, r1
"
}

SubProgram "gles " {
Keywords { "POINT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
SetTexture 2 [_LightTexture0] 2D
"agal_ps
c2 0.0 0.5 2.0 0.0
[bc]
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r1, v0, s0 <2d wrap linear point>
bcaaaaaaaaaaabacaeaaaaoeaeaaaaaaaeaaaaoeaeaaaaaa dp3 r0.x, v4, v4
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
adaaaaaaabaaahacahaaaaoeaeaaaaaaabaaaakeacaaaaaa mul r1.xyz, v7, r1.xyzz
ciaaaaaaacaaapacaaaaaafeacaaaaaaacaaaaaaafaababb tex r2, r0.xyyy, s2 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r0, v0, s1 <2d wrap linear point>
bfaaaaaaacaaahacabaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r2.xyz, r1.xyzz
abaaaaaaacaaahacacaaaakeacaaaaaaabaaaaoeabaaaaaa add r2.xyz, r2.xyzz, c1
adaaaaaaacaaahacaaaaaakkacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r0.z, r2.xyzz
adaaaaaaadaaahacacaaaakeacaaaaaaacaaaaffabaaaaaa mul r3.xyz, r2.xyzz, c2.y
abaaaaaaabaaahacadaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r3.xyzz, r1.xyzz
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r0.x, v2, v2
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaaoeaeaaaaaa mul r0.xyz, r0.x, v2
bcaaaaaaaaaaabacabaaaaoeaeaaaaaaaaaaaakeacaaaaaa dp3 r0.x, v1, r0.xyzz
adaaaaaaabaaahacabaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r1.xyzz, c0
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaacaaaaoeabaaaaaa max r0.x, r0.x, c2
adaaaaaaacaaahacabaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r2.xyz, r1.xyzz, r0.x
adaaaaaaabaaabacacaaaappacaaaaaaacaaaakkabaaaaaa mul r1.x, r2.w, c2.z
adaaaaaaaaaaabacahaaaappaeaaaaaaabaaaappabaaaaaa mul r0.x, v7.w, c1.w
adaaaaaaabaaahacacaaaakeacaaaaaaabaaaaaaacaaaaaa mul r1.xyz, r2.xyzz, r1.x
adaaaaaaabaaaiacaaaaaaaaacaaaaaaabaaaappacaaaaaa mul r1.w, r0.x, r1.w
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 14 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.5, 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.z, fragment.texcoord[0], texture[1], 2D;
MUL R1.xyw, fragment.color.primary.xyzz, R0.xyzz;
ADD R0.xyz, -R1.xyww, c[1];
MUL R0.xyz, R1.z, R0;
MAD R0.xyz, R0, c[2].x, R1.xyww;
MOV R2.xyz, fragment.texcoord[2];
DP3 R1.z, fragment.texcoord[1], R2;
MUL R0.xyz, R0, c[0];
MAX R1.x, R1.z, c[2].y;
MUL R1.xyz, R0, R1.x;
MUL R0.x, fragment.color.primary.w, c[1].w;
MUL result.color.xyz, R1, c[2].z;
MUL result.color.w, R0.x, R0;
END
# 14 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
"ps_2_0
; 13 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c2, 0.00000000, 0.50000000, 2.00000000, 0
dcl t0.xy
dcl v0
dcl t1.xyz
dcl t2.xyz
texld r1, t0, s1
texld r0, t0, s0
mul r2.xyz, v0, r0
add_pp r0.xyz, -r2, c1
mul_pp r1.xyz, r1.z, r0
mov_pp r3.xyz, t2
dp3_pp r0.x, t1, r3
mad_pp r1.xyz, r1, c2.y, r2
max_pp r0.x, r0, c2
mul_pp r1.xyz, r1, c0
mul_pp r1.xyz, r1, r0.x
mul r0.x, v0.w, c1.w
mul r1.xyz, r1, c2.z
mul r1.w, r0.x, r0
mov_pp oC0, r1
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
"agal_ps
c2 0.0 0.5 2.0 0.0
[bc]
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r1, v0, s1 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r0, v0, s0 <2d wrap linear point>
adaaaaaaacaaahacahaaaaoeaeaaaaaaaaaaaakeacaaaaaa mul r2.xyz, v7, r0.xyzz
bfaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xyz, r2.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaoeabaaaaaa add r0.xyz, r0.xyzz, c1
adaaaaaaabaaahacabaaaakkacaaaaaaaaaaaakeacaaaaaa mul r1.xyz, r1.z, r0.xyzz
aaaaaaaaadaaahacacaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r3.xyz, v2
bcaaaaaaaaaaabacabaaaaoeaeaaaaaaadaaaakeacaaaaaa dp3 r0.x, v1, r3.xyzz
adaaaaaaabaaahacabaaaakeacaaaaaaacaaaaffabaaaaaa mul r1.xyz, r1.xyzz, c2.y
abaaaaaaabaaahacabaaaakeacaaaaaaacaaaakeacaaaaaa add r1.xyz, r1.xyzz, r2.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaacaaaaoeabaaaaaa max r0.x, r0.x, c2
adaaaaaaabaaahacabaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r1.xyzz, c0
adaaaaaaabaaahacabaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r1.xyz, r1.xyzz, r0.x
adaaaaaaaaaaabacahaaaappaeaaaaaaabaaaappabaaaaaa mul r0.x, v7.w, c1.w
adaaaaaaabaaahacabaaaakeacaaaaaaacaaaakkabaaaaaa mul r1.xyz, r1.xyzz, c2.z
adaaaaaaabaaaiacaaaaaaaaacaaaaaaaaaaaappacaaaaaa mul r1.w, r0.x, r0.w
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 25 ALU, 4 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.5, 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R2, fragment.texcoord[0], texture[0], 2D;
MUL R1.xyz, fragment.color.primary, R2;
RCP R0.x, fragment.texcoord[4].w;
MAD R0.zw, fragment.texcoord[4].xyxy, R0.x, c[2].x;
DP3 R0.x, fragment.texcoord[4], fragment.texcoord[4];
ADD R2.xyz, -R1, c[1];
TEX R1.w, R0.zwzw, texture[2], 2D;
TEX R0.w, R0.x, texture[3], 2D;
TEX R0.z, fragment.texcoord[0], texture[1], 2D;
MUL R2.xyz, R0.z, R2;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MAD R1.xyz, R2, c[2].x, R1;
MUL R0.xyz, R0.x, fragment.texcoord[2];
DP3 R2.x, fragment.texcoord[1], R0;
MUL R0.xyz, R1, c[0];
MAX R1.y, R2.x, c[2];
SLT R1.x, c[2].y, fragment.texcoord[4].z;
MUL R1.x, R1, R1.w;
MUL R0.w, R1.x, R0;
MUL R1.x, fragment.color.primary.w, c[1].w;
MUL R0.xyz, R0, R1.y;
MUL R0.w, R0, c[2].z;
MUL result.color.xyz, R0, R0.w;
MUL result.color.w, R1.x, R2;
END
# 25 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
"ps_2_0
; 23 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c2, 0.50000000, 0.00000000, 1.00000000, 2.00000000
dcl t0.xy
dcl v0
dcl t1.xyz
dcl t2.xyz
dcl t4
dp3 r1.x, t4, t4
mov r1.xy, r1.x
rcp r0.x, t4.w
mad r0.xy, t4, r0.x, c2.x
texld r3, r1, s3
texld r2, r0, s2
texld r1, t0, s1
texld r0, t0, s0
mul r0.xyz, v0, r0
add_pp r2.xyz, -r0, c1
mul_pp r1.xyz, r1.z, r2
mad_pp r1.xyz, r1, c2.x, r0
mul_pp r2.xyz, r1, c0
dp3_pp r0.x, t2, t2
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, t2
dp3_pp r1.x, t1, r1
max_pp r1.x, r1, c2.y
cmp r0.x, -t4.z, c2.y, c2.z
mul_pp r2.xyz, r2, r1.x
mul_pp r0.x, r0, r2.w
mul_pp r0.x, r0, r3
mul_pp r1.x, r0, c2.w
mul r0.x, v0.w, c1.w
mul r1.xyz, r2, r1.x
mul r1.w, r0.x, r0
mov_pp oC0, r1
"
}

SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
"agal_ps
c2 0.5 0.0 1.0 2.0
[bc]
bcaaaaaaabaaabacaeaaaaoeaeaaaaaaaeaaaaoeaeaaaaaa dp3 r1.x, v4, v4
aaaaaaaaabaaadacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r1.xy, r1.x
afaaaaaaaaaaabacaeaaaappaeaaaaaaaaaaaaaaaaaaaaaa rcp r0.x, v4.w
adaaaaaaaaaaadacaeaaaaoeaeaaaaaaaaaaaaaaacaaaaaa mul r0.xy, v4, r0.x
abaaaaaaaaaaadacaaaaaafeacaaaaaaacaaaaaaabaaaaaa add r0.xy, r0.xyyy, c2.x
ciaaaaaaadaaapacaaaaaafeacaaaaaaacaaaaaaafaababb tex r3, r0.xyyy, s2 <2d wrap linear point>
ciaaaaaaacaaapacabaaaafeacaaaaaaadaaaaaaafaababb tex r2, r1.xyyy, s3 <2d wrap linear point>
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r1, v0, s1 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r0, v0, s0 <2d wrap linear point>
adaaaaaaaaaaahacahaaaaoeaeaaaaaaaaaaaakeacaaaaaa mul r0.xyz, v7, r0.xyzz
bfaaaaaaacaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r2.xyz, r0.xyzz
abaaaaaaacaaahacacaaaakeacaaaaaaabaaaaoeabaaaaaa add r2.xyz, r2.xyzz, c1
adaaaaaaabaaahacabaaaakkacaaaaaaacaaaakeacaaaaaa mul r1.xyz, r1.z, r2.xyzz
adaaaaaaabaaahacabaaaakeacaaaaaaacaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c2.x
abaaaaaaabaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r1.xyz, r1.xyzz, r0.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r2.xyz, r1.xyzz, c0
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r0.x, v2, v2
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaabaaahacaaaaaaaaacaaaaaaacaaaaoeaeaaaaaa mul r1.xyz, r0.x, v2
bcaaaaaaabaaabacabaaaaoeaeaaaaaaabaaaakeacaaaaaa dp3 r1.x, v1, r1.xyzz
ahaaaaaaabaaabacabaaaaaaacaaaaaaacaaaaffabaaaaaa max r1.x, r1.x, c2.y
adaaaaaaacaaahacacaaaakeacaaaaaaabaaaaaaacaaaaaa mul r2.xyz, r2.xyzz, r1.x
bfaaaaaaadaaabacaeaaaakkaeaaaaaaaaaaaaaaaaaaaaaa neg r3.x, v4.z
ckaaaaaaaaaaabacadaaaaaaacaaaaaaacaaaaffabaaaaaa slt r0.x, r3.x, c2.y
adaaaaaaaaaaabacaaaaaaaaacaaaaaaadaaaappacaaaaaa mul r0.x, r0.x, r3.w
adaaaaaaaaaaabacaaaaaaaaacaaaaaaacaaaappacaaaaaa mul r0.x, r0.x, r2.w
adaaaaaaabaaabacaaaaaaaaacaaaaaaacaaaappabaaaaaa mul r1.x, r0.x, c2.w
adaaaaaaaaaaabacahaaaappaeaaaaaaabaaaappabaaaaaa mul r0.x, v7.w, c1.w
adaaaaaaabaaahacacaaaakeacaaaaaaabaaaaaaacaaaaaa mul r1.xyz, r2.xyzz, r1.x
adaaaaaaabaaaiacaaaaaaaaacaaaaaaaaaaaappacaaaaaa mul r1.w, r0.x, r0.w
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 21 ALU, 4 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.5, 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R2, fragment.texcoord[0], texture[0], 2D;
TEX R0.z, fragment.texcoord[0], texture[1], 2D;
TEX R0.w, fragment.texcoord[4], texture[3], CUBE;
MUL R1.xyz, fragment.color.primary, R2;
DP3 R0.x, fragment.texcoord[4], fragment.texcoord[4];
ADD R2.xyz, -R1, c[1];
MUL R2.xyz, R0.z, R2;
MAD R1.xyz, R2, c[2].x, R1;
TEX R1.w, R0.x, texture[2], 2D;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[2];
DP3 R2.x, fragment.texcoord[1], R0;
MUL R0.xyz, R1, c[0];
MAX R1.x, R2, c[2].y;
MUL R0.xyz, R0, R1.x;
MUL R0.w, R1, R0;
MUL R0.w, R0, c[2].z;
MUL R1.x, fragment.color.primary.w, c[1].w;
MUL result.color.xyz, R0, R0.w;
MUL result.color.w, R1.x, R2;
END
# 21 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
"ps_2_0
; 19 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c2, 0.00000000, 0.50000000, 2.00000000, 0
dcl t0.xy
dcl v0
dcl t1.xyz
dcl t2.xyz
dcl t4.xyz
texld r1, t0, s1
texld r2, t4, s3
dp3 r0.x, t4, t4
mov r0.xy, r0.x
texld r3, r0, s2
texld r0, t0, s0
mul r2.xyz, v0, r0
add_pp r0.xyz, -r2, c1
mul_pp r1.xyz, r1.z, r0
mad_pp r1.xyz, r1, c2.y, r2
mul_pp r2.xyz, r1, c0
dp3_pp r0.x, t2, t2
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, t2
dp3_pp r0.x, t1, r0
max_pp r1.x, r0, c2
mul r0.x, r3, r2.w
mul_pp r2.xyz, r2, r1.x
mul_pp r1.x, r0, c2.z
mul r0.x, v0.w, c1.w
mul r1.xyz, r2, r1.x
mul r1.w, r0.x, r0
mov_pp oC0, r1
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
"agal_ps
c2 0.0 0.5 2.0 0.0
[bc]
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r1, v0, s1 <2d wrap linear point>
ciaaaaaaacaaapacaeaaaaoeaeaaaaaaadaaaaaaafbababb tex r2, v4, s3 <cube wrap linear point>
bcaaaaaaaaaaabacaeaaaaoeaeaaaaaaaeaaaaoeaeaaaaaa dp3 r0.x, v4, v4
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
ciaaaaaaadaaapacaaaaaafeacaaaaaaacaaaaaaafaababb tex r3, r0.xyyy, s2 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r0, v0, s0 <2d wrap linear point>
adaaaaaaacaaahacahaaaaoeaeaaaaaaaaaaaakeacaaaaaa mul r2.xyz, v7, r0.xyzz
bfaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xyz, r2.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaoeabaaaaaa add r0.xyz, r0.xyzz, c1
adaaaaaaabaaahacabaaaakkacaaaaaaaaaaaakeacaaaaaa mul r1.xyz, r1.z, r0.xyzz
adaaaaaaabaaahacabaaaakeacaaaaaaacaaaaffabaaaaaa mul r1.xyz, r1.xyzz, c2.y
abaaaaaaabaaahacabaaaakeacaaaaaaacaaaakeacaaaaaa add r1.xyz, r1.xyzz, r2.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r2.xyz, r1.xyzz, c0
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r0.x, v2, v2
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaaoeaeaaaaaa mul r0.xyz, r0.x, v2
bcaaaaaaaaaaabacabaaaaoeaeaaaaaaaaaaaakeacaaaaaa dp3 r0.x, v1, r0.xyzz
ahaaaaaaabaaabacaaaaaaaaacaaaaaaacaaaaoeabaaaaaa max r1.x, r0.x, c2
adaaaaaaaaaaabacadaaaappacaaaaaaacaaaappacaaaaaa mul r0.x, r3.w, r2.w
adaaaaaaacaaahacacaaaakeacaaaaaaabaaaaaaacaaaaaa mul r2.xyz, r2.xyzz, r1.x
adaaaaaaabaaabacaaaaaaaaacaaaaaaacaaaakkabaaaaaa mul r1.x, r0.x, c2.z
adaaaaaaaaaaabacahaaaappaeaaaaaaabaaaappabaaaaaa mul r0.x, v7.w, c1.w
adaaaaaaabaaahacacaaaakeacaaaaaaabaaaaaaacaaaaaa mul r1.xyz, r2.xyzz, r1.x
adaaaaaaabaaaiacaaaaaaaaacaaaaaaaaaaaappacaaaaaa mul r1.w, r0.x, r0.w
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
SetTexture 2 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 16 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.5, 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TEX R0.w, fragment.texcoord[4], texture[2], 2D;
TEX R0.z, fragment.texcoord[0], texture[1], 2D;
MUL R1.xyz, fragment.color.primary, R1;
ADD R2.xyz, -R1, c[1];
MUL R0.xyz, R0.z, R2;
MAD R0.xyz, R0, c[2].x, R1;
MOV R3.xyz, fragment.texcoord[2];
DP3 R2.x, fragment.texcoord[1], R3;
MAX R1.x, R2, c[2].y;
MUL R0.xyz, R0, c[0];
MUL R0.xyz, R0, R1.x;
MUL R1.x, R0.w, c[2].z;
MUL R0.w, fragment.color.primary, c[1];
MUL result.color.xyz, R0, R1.x;
MUL result.color.w, R0, R1;
END
# 16 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
SetTexture 2 [_LightTexture0] 2D
"ps_2_0
; 14 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 0.00000000, 0.50000000, 2.00000000, 0
dcl t0.xy
dcl v0
dcl t1.xyz
dcl t2.xyz
dcl t4.xy
texld r1, t0, s1
texld r0, t0, s0
texld r2, t4, s2
mul r0.xyz, v0, r0
add_pp r2.xyz, -r0, c1
mul_pp r1.xyz, r1.z, r2
mov_pp r2.xyz, t2
mad_pp r1.xyz, r1, c2.y, r0
dp3_pp r0.x, t1, r2
mul_pp r1.xyz, r1, c0
max_pp r0.x, r0, c2
mul_pp r2.xyz, r1, r0.x
mul_pp r1.x, r2.w, c2.z
mul r0.x, v0.w, c1.w
mul r1.xyz, r2, r1.x
mul r1.w, r0.x, r0
mov_pp oC0, r1
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Mask] 2D
SetTexture 2 [_LightTexture0] 2D
"agal_ps
c2 0.0 0.5 2.0 0.0
[bc]
ciaaaaaaabaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r1, v0, s1 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r0, v0, s0 <2d wrap linear point>
ciaaaaaaacaaapacaeaaaaoeaeaaaaaaacaaaaaaafaababb tex r2, v4, s2 <2d wrap linear point>
adaaaaaaaaaaahacahaaaaoeaeaaaaaaaaaaaakeacaaaaaa mul r0.xyz, v7, r0.xyzz
bfaaaaaaacaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r2.xyz, r0.xyzz
abaaaaaaacaaahacacaaaakeacaaaaaaabaaaaoeabaaaaaa add r2.xyz, r2.xyzz, c1
adaaaaaaabaaahacabaaaakkacaaaaaaacaaaakeacaaaaaa mul r1.xyz, r1.z, r2.xyzz
aaaaaaaaacaaahacacaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r2.xyz, v2
adaaaaaaabaaahacabaaaakeacaaaaaaacaaaaffabaaaaaa mul r1.xyz, r1.xyzz, c2.y
abaaaaaaabaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r1.xyz, r1.xyzz, r0.xyzz
bcaaaaaaaaaaabacabaaaaoeaeaaaaaaacaaaakeacaaaaaa dp3 r0.x, v1, r2.xyzz
adaaaaaaabaaahacabaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r1.xyzz, c0
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaacaaaaoeabaaaaaa max r0.x, r0.x, c2
adaaaaaaacaaahacabaaaakeacaaaaaaaaaaaaaaacaaaaaa mul r2.xyz, r1.xyzz, r0.x
adaaaaaaabaaabacacaaaappacaaaaaaacaaaakkabaaaaaa mul r1.x, r2.w, c2.z
adaaaaaaaaaaabacahaaaappaeaaaaaaabaaaappabaaaaaa mul r0.x, v7.w, c1.w
adaaaaaaabaaahacacaaaakeacaaaaaaabaaaaaaacaaaaaa mul r1.xyz, r2.xyzz, r1.x
adaaaaaaabaaaiacaaaaaaaaacaaaaaaaaaaaappacaaaaaa mul r1.w, r0.x, r0.w
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
"
}

}
	}

#LINE 241

		}
		
		SubShader
		{
			LOD 100
			Cull Off
			Lighting Off
			ZWrite Off
			Fog { Mode Off }
			ColorMask RGB
			AlphaTest Greater .01
			Blend SrcAlpha OneMinusSrcAlpha
			
			Pass
			{
				ColorMaterial AmbientAndDiffuse
				
				SetTexture [_MainTex]
				{
					Combine Texture * Primary
				}
			}
		}
	}
	Fallback Off
}
