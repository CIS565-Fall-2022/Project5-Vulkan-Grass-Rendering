#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 normal;
layout(location = 1) in float height;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec3 lightDir = normalize(vec3(1, -1, 1));
    vec3 grassColor = vec3(.24, .59, .09);
    float diffuse = abs(dot(lightDir, normal));
    
    outColor = vec4(grassColor * (0.4 + 0.4 * height + 0.2 * abs(dot(lightDir, normal))), 1.0);
}
