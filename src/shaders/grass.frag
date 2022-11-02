#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 ps_position;
layout(location = 1) in vec3 ps_normal;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color

    vec3 base = vec3(0.45, 0.74, 0.28);
    vec3 ambient = vec3(0.2, 0.3, 0.1);
    vec4 light_pos = vec4(0.0, 100.0, 0.0, 1.0);
    vec4 normal = vec4(normalize(ps_normal), 0.0);
    vec4 L = normalize(light_pos - vec4(ps_position, 1.0f));
    float diffuse = max(dot(L, normal), 0.0);

    vec3 color = ambient + diffuse  * base;
    outColor = vec4(color, 1.0);
    }
