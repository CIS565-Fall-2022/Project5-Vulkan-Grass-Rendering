#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
    vec3 eye;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 in_v0[];
layout(location = 1) in vec4 in_v1[];
layout(location = 2) in vec4 in_v2[];
layout(location = 3) in vec4 in_up[];

layout(location = 0) out vec4 out_v0[];
layout(location = 1) out vec4 out_v1[];
layout(location = 2) out vec4 out_v2[];
layout(location = 3) out vec4 out_up[];

void main() {
	// TODO: Write any shader outputs
    out_v0[gl_InvocationID] = in_v0[gl_InvocationID];
    out_v1[gl_InvocationID] = in_v1[gl_InvocationID];
    out_v2[gl_InvocationID] = in_v2[gl_InvocationID];
    out_up[gl_InvocationID] = in_up[gl_InvocationID];

	// TODO: Set level of tesselation
    int TL = 5;
    if (gl_InvocationID == 0) {
        gl_TessLevelOuter[0] = TL;
        gl_TessLevelOuter[1] = TL;
        gl_TessLevelOuter[2] = TL;
        gl_TessLevelOuter[3] = TL;
        gl_TessLevelInner[0] = TL;
        gl_TessLevelInner[1] = TL;
    }
}
