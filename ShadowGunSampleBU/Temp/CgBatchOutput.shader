
Shader "AngryBots/Particle/Additive" {
	Properties {
		_MainTex ("Base", 2D) = "white" {}
		_TintColor ("TintColor", Color) = (1.0, 1.0, 1.0, 1.0)
	}
	
	#LINE 36

	
	SubShader {
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent"}
		Cull Off
		Lighting Off
		ZWrite Off
		Fog { Mode Off }
		Blend One One
		
	Pass {
	
		Program "vp" {
// Vertex combos: 1
//   opengl - ALU: 6 to 6
//   d3d9 - ALU: 6 to 6
SubProgram "opengl " {
Keywords { }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "color" Color
Vector 5 [_TintColor]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
# 6 ALU
PARAM c[7] = { program.local[0],
		state.matrix.mvp,
		program.local[5..6] };
MUL result.color, vertex.color, c[5];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[6], c[6].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_TintColor]
Vector 5 [_MainTex_ST]
"vs_2_0
; 6 ALU
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
mul oD0, v2, c4
mad oT0.xy, v1, c5, c5.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;

uniform lowp vec4 _TintColor;
uniform mediump vec4 _MainTex_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * _glesVertex);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_4;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR = (_glesColor * _TintColor);
}



#endif
#ifdef FRAGMENT

varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
uniform sampler2D _MainTex;
void main ()
{
  gl_FragData[0] = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;

uniform lowp vec4 _TintColor;
uniform mediump vec4 _MainTex_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * _glesVertex);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_4;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR = (_glesColor * _TintColor);
}



#endif
#ifdef FRAGMENT

varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
uniform sampler2D _MainTex;
void main ()
{
  gl_FragData[0] = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
}



#endif"
}

SubProgram "flash " {
Keywords { }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_TintColor]
Vector 5 [_MainTex_ST]
"agal_vs
[bc]
adaaaaaaahaaapaeacaaaaoeaaaaaaaaaeaaaaoeabaaaaaa mul v7, a2, c4
adaaaaaaaaaaadacadaaaaoeaaaaaaaaafaaaaoeabaaaaaa mul r0.xy, a3, c5
abaaaaaaaaaaadaeaaaaaafeacaaaaaaafaaaaooabaaaaaa add v0.xy, r0.xyyy, c5.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
"
}

}
Program "fp" {
// Fragment combos: 1
//   opengl - ALU: 2 to 2, TEX: 1 to 1
//   d3d9 - ALU: 2 to 2, TEX: 1 to 1
SubProgram "opengl " {
Keywords { }
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 2 ALU, 1 TEX
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL result.color, R0, fragment.color.primary;
END
# 2 instructions, 1 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 2 ALU, 1 TEX
dcl_2d s0
dcl t0.xy
dcl v0
texld r0, t0, s0
mul r0, r0, v0
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES"
}

SubProgram "flash " {
Keywords { }
SetTexture 0 [_MainTex] 2D
"agal_ps
[bc]
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r0, v0, s0 <2d wrap linear point>
adaaaaaaaaaaapacaaaaaaoeacaaaaaaahaaaaoeaeaaaaaa mul r0, r0, v7
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

}

#LINE 54

		 
		}
				
	} 
	FallBack Off
}
