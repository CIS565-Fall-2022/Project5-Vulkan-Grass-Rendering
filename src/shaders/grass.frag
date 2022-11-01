#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 normal;
layout(location = 2) in float v;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec4 grassColor = vec4(52/255.0,  140/255.0, 49/255.0, 1.0);
    outColor =  grassColor * v * 1.8;
}
