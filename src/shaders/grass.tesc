#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout(location = 0) in vec4 tcV0[];
layout(location = 1) in vec4 tcV1[];
layout(location = 2) in vec4 tcV2[];

layout(location = 0) out vec4 teV0[];
layout(location = 1) out vec4 teV1[];
layout(location = 2) out vec4 teV2[];

float getTessselLevelOfDetail() {
    return 10.0;
}

void main() {
    teV0[gl_InvocationID] = tcV0[gl_InvocationID];
    teV1[gl_InvocationID] = tcV1[gl_InvocationID];
    teV2[gl_InvocationID] = tcV2[gl_InvocationID];

    float level = getTessselLevelOfDetail();
    gl_TessLevelInner[0] = level;
    gl_TessLevelInner[1] = level;
    gl_TessLevelOuter[0] = level;
    gl_TessLevelOuter[1] = level;
    gl_TessLevelOuter[2] = level;
    gl_TessLevelOuter[3] = level;
}
