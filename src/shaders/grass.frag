

#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

layout(location = 0) in vec3 in_pos;
layout(location = 1) in vec3 in_nor;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color

    float ambient = 0.15;

    vec3 lightPos = vec3(100.0, 100.0, 0.0);
    vec3 dir = normalize(lightPos - in_pos);
    float lambert = max(dot(dir, normalize(in_nor)), 0.0);

    float cofficient = min(lambert + ambient, 1.0);
    vec3 col = cofficient * vec3(0.0, 1.0, 0.0);

    outColor = vec4(col, 1.0);
}