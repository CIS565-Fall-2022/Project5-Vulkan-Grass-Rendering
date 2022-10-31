#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs

layout(location = 0) in vec4 in_v0;
layout(location = 1) in vec4 in_v1;
layout(location = 2) in vec4 in_v2;
layout(location = 3) in vec4 in_up;

layout(location = 0) out vec4 out_v0;
layout(location = 1) out vec4 out_v1;
layout(location = 2) out vec4 out_v2;
layout(location = 3) out vec4 out_up;

void main() {
	// TODO: Write gl_Position and any other shader outputs
	gl_Position = model * vec4(vec3(in_v0), 1.0f);
	out_v0 = model * vec4(vec3(in_v0), 1.f);
	out_v1 = model * vec4(vec3(in_v1), 1.f);
	out_v2 = model * vec4(vec3(in_v2), 1.f);
	out_up = model * vec4(vec3(in_up), 1.f);

	out_v0.w = in_v0.w;
	out_v1.w = in_v1.w;
	out_v2.w = in_v2.w;
	out_up.w = in_up.w;
}