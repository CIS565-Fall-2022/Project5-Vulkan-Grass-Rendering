#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 in_norm;
layout(location = 1) in vec3 in_pos;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec3 grass_color = vec3(86.0, 125.0, 70.0)/255.0;

    outColor = vec4(grass_color, 1.0);
}
