
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

out gl_PerVertex {
    vec4 gl_Position;
};

vec4 multiply(mat4 m, vec4 v) {
    return vec4((m * vec4(v.xyz, 1.0)).xyz, v.w);
}

void main() {
	// TODO: Write gl_Position and any other shader outputs
    gl_Position = multiply(model, in_v0);
    out_v0 = multiply(model,in_v0);
    out_v1 = multiply(model,in_v1);
    out_v2 = multiply(model,in_v2);
    out_up = multiply(model,in_up);
}
