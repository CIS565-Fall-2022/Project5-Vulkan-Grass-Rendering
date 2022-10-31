#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 normal;
layout(location = 1) in vec3 pos;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color

    vec3 lightPos = vec3(0.0, 100.0, 0.0);
    vec3 lightDir = normalize(lightPos - pos);

    vec3 albedo = vec3(0, 1, 0);
    vec3 ambient = vec3(0, 1, 0);
    vec3 color = ambient * 0.3f + albedo * max(dot(lightDir, normal), 0.f);
    outColor = vec4(color.xyz, 1.f);
}
