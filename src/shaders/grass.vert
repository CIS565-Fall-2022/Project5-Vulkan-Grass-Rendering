
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs

layout(location = 0) in vec4 v0_in;
layout(location = 1) in vec4 v1_in;
layout(location = 2) in vec4 v2_in;
layout(location = 3) in vec4 up_in;

layout(location = 0) out vec4 v0_out;
layout(location = 1) out vec4 v1_out;
layout(location = 2) out vec4 v2_out;
layout(location = 3) out vec4 up_out;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
    gl_Position = model * vec4(v0_in.xyz, 1.0);
    v0_out = model * v0_in;
    v1_out = model * v1_in;
    v2_out = model * v2_in;
    up_out = model * up_in;
}
