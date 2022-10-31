
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

vec4 spaceConvert(vec4 in0) {
    return vec4(vec3(model * vec4(in0.xyz, 1.f)), in0.w);
}

void main() {
	// TODO: Write gl_Position and any other shader outputs
    gl_Position = spaceConvert(in_v0);

    //local space to world space
    out_v0 = spaceConvert(in_v0);
    out_v1 = spaceConvert(in_v1);
    out_v2 = spaceConvert(in_v2);
    out_up = spaceConvert(in_up);
}
