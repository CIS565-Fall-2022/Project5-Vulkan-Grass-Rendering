#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout(location = 0) in vec3 norm;
layout(location = 1) in float mixFactor;

layout(location = 0) out vec4 outColor;

void main() {
    vec3 lightDir = normalize(vec3(1.0, 1.0, 1.0));
    vec3 topColor = vec3(1.0, 1.0, 0.2);
    vec3 bottomColor = vec3(0.5, 1.0, 0.3);

    vec3 color = mix(bottomColor, topColor, mixFactor) * max(abs(dot(lightDir, norm)), 0.1);
    color = pow(color, vec3(1.0 / 2.2));
    outColor = vec4(color, 1.0);
}