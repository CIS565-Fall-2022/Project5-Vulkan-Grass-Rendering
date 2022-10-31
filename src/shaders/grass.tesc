#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout(location = 0) in vec4[] in_v0; // just 1 element per arr
layout(location = 1) in vec4[] in_v1;
layout(location = 2) in vec4[] in_v2;
//layout(location = 3) in vec4[] in_up;

layout(location = 0) out vec4[] out_v0;
layout(location = 1) out vec4[] out_v1;
layout(location = 2) out vec4[] out_v2;

float getTessLevel(float dist) {
    if (dist < 2.0) {
        return 20.0;
    } else if (dist < 5.0) {
        return 10.0;
    } else if (dist < 10.0) {
        return 5.0;
    } else if (dist < 15.0) {
        return 3.0;
    } else {
        return 1.0;
    }
}

void main() {
	// Don't move the origin location of the patch
    out_v0[gl_InvocationID] = in_v0[gl_InvocationID];
    out_v1[gl_InvocationID] = in_v1[gl_InvocationID];
    out_v2[gl_InvocationID] = in_v2[gl_InvocationID];

    vec3 camPos = inverse(camera.view)[3].xyz;
    float tessLevel = getTessLevel(length(in_v0[0].xyz - camPos));

    gl_TessLevelInner[0] = tessLevel;
    gl_TessLevelInner[1] = tessLevel;
    gl_TessLevelOuter[0] = tessLevel;
    gl_TessLevelOuter[1] = tessLevel;
    gl_TessLevelOuter[2] = tessLevel;
    gl_TessLevelOuter[3] = tessLevel;
}
