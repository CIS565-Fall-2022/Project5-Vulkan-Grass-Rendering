#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs

out gl_PerVertex {
   vec4 gl_Position;
};

layout(location = 0) in vec4 in_pos0;
layout(location = 1) in vec4 in_pos1;
layout(location = 2) in vec4 in_pos2;
layout(location = 3) in vec4 in_up;

layout(location = 0) out vec4 out_pos0;
layout(location = 1) out vec4 out_pos1;
layout(location = 2) out vec4 out_pos2;
layout(location = 3) out vec4 out_up;

void main() {
	// TODO: Write gl_Position and any other shader outputs
	gl_Position = model * vec4(vec3(in_pos0), 1.0f);
	out_pos0 = model * vec4(vec3(in_pos0), 1.f);
	out_pos1 = model * vec4(vec3(in_pos1), 1.f);
	out_pos2 = model * vec4(vec3(in_pos2), 1.f);
	out_up = model * vec4(vec3(in_up), 1.f);

	out_pos0.w = in_pos0.w;
	out_pos1.w = in_pos1.w;
	out_pos2.w = in_pos2.w;
	out_up.w = in_up.w;
}