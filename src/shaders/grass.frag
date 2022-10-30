#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout (location = 0) in float u;
layout (location = 1) in float v;

// TODO: Declare fragment shader inputs

layout(location = 0) out vec4 outColor;

vec4 interpolate(vec4 c1, vec4 c2, float x){
    return x * c1 + (1-x) * c2;
}

void main() {
    // TODO: Compute fragment color

    vec4 topColor = vec4(0.18, 0.6, 0.12, 1);
    vec4 centerColor = vec4(0.14, 0.45, 0.091, 1.0);
    vec4 edgeColor = vec4(0.05, 0.18, 0.04, 1);
    float top = 1-v;
    float edge = abs(0.5-u) + abs(0.5-v);
    outColor = interpolate(topColor, interpolate(edgeColor, centerColor, edge), top);
}
