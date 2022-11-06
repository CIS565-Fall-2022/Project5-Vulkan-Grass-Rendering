
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout(location = 0) in vec4 v0In;
layout(location = 1) in vec4 v1In;
layout(location = 2) in vec4 v2In;
layout(location = 3) in vec4 upIn;

layout(location = 0) out vec4 v0Out;
layout(location = 1) out vec4 v1Out;
layout(location = 2) out vec4 v2Out;
layout(location = 3) out vec3 upOut;

//out gl_PerVertex {
//    vec4 gl_Position;
//};

void main() {
	// TODO: Write gl_Position and any other shader outputs
	gl_Position = model * vec4(v0In.xyz, 1.0);

	v0Out = model * v0In;
	v1Out = model * v1In;
	v2Out = model * v2In;
	upOut = upIn.xyz;
}
