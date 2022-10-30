#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// DONE: Declare fragment shader inputs
layout(location=1)in float param_height;

layout(location = 0) out vec4 outColor;

void main() {
    // DONE: Compute fragment color
    vec4 lightYellow=vec4(250.f,255.f,11.f,255.f)/255.f;
    vec4 orange=vec4(245.f,122.f,22.f,255.f)/255.f;
    vec4 mergeCol =mix(lightYellow,orange,1-param_height);
    outColor = mergeCol;
}
