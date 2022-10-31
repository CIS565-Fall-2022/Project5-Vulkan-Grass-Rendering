#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 pos;
layout(location = 1) in vec4 nor;
layout(location = 2) in vec2 uv;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec3 darkGreen = vec3(0.11f, 0.25f, 0.01f);
    vec3 lightGreen = vec3(0.6f, 0.97f, 0.39f);
    vec3 grassColor = mix(darkGreen, lightGreen, uv.y);
    
    outColor = vec4(grassColor, 1.f);
}
