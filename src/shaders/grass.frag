#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

layout(location = 0) in vec3 n;
layout(location = 1) in vec3 p;
layout(location = 2) in float v;

layout(location = 0) out vec4 outColor;



void main() {
    // TODO: Compute fragment color
    vec3 cam = vec3(0.f, 1.f, 10.f);
    vec3 rayDirection = normalize(cam - p);

    vec3 topColor = vec3(153.f, 204.f, 51.f) / 255.f;
    vec3 botColor = vec3(0.f, 50.f, 0.f) / 255.f;
    
    vec3 color = botColor + v * (topColor - botColor);
    color = color * max(abs(dot(rayDirection, n)), 0.5);


    outColor = vec4(color, 1.f);
}
