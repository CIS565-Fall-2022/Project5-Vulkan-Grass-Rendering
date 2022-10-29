#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
    vec3 pos;
} camera;

layout(location = 0) in vec4 tcV0[];
layout(location = 1) in vec4 tcV1[];
layout(location = 2) in vec4 tcV2[];
layout(location = 3) in vec3 tcUp[];

layout(location = 0) out vec4 teV0[];
layout(location = 1) out vec4 teV1[];
layout(location = 2) out vec4 teV2[];

float getTessselLevelOfDetail(float d) {
    if (d < 5.0) {
        return 10.0;
    }
    else if (d < 20.0) {
        return 5.0;
    }
    else {
        return 3.0;
    }
}

void main() {
    teV0[gl_InvocationID] = tcV0[gl_InvocationID];
    teV1[gl_InvocationID] = tcV1[gl_InvocationID];
    teV2[gl_InvocationID] = tcV2[gl_InvocationID];

    vec3 v0 = tcV0[gl_InvocationID].xyz;
    vec3 up = tcUp[gl_InvocationID];
    vec3 view = v0 - camera.pos;

    float level = getTessselLevelOfDetail(length(view - up * dot(view, up)));
    gl_TessLevelInner[0] = level;
    gl_TessLevelInner[1] = level;
    gl_TessLevelOuter[0] = level;
    gl_TessLevelOuter[1] = level;
    gl_TessLevelOuter[2] = level;
    gl_TessLevelOuter[3] = level;
}
