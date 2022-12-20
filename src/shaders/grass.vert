
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
//descriptorSet layout: camera, model
//vertexInputInfo: Blade

layout(location = 0) in vec4 in_v0;  //v0
layout(location = 1) in vec4 in_v1;  //v1
layout(location = 2) in vec4 in_v2;  //v2
layout(location = 3) in vec4 in_v3;  //up

layout(location = 0) out vec4 out_v0;
layout(location = 1) out vec4 out_v1;
layout(location = 2) out vec4 out_v2;
layout(location = 3) out vec4 out_v3;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
    out_v0 = model * vec4(vec3(in_v0), 1);
    gl_Position = out_v0;
    out_v0.w = in_v0.w;

    out_v1 = model * vec4(vec3(in_v1), 1);
    out_v1.w = in_v1.w;

    out_v2 = model * vec4(vec3(in_v2), 1);
    out_v2.w = in_v2.w;

    out_v3 = model * vec4(vec3(in_v3), 1);
    out_v3.w = in_v3.w;
}
