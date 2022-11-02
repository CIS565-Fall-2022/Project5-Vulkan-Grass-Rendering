#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec2 in_uv;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec3 root = vec3(0.0, 0.3, 0.0);
    vec3 tip =  vec3(0.3, 1, 0.0);

    outColor = vec4(mix(root, tip, in_uv.y), 1.);
}
