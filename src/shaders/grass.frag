#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 pos;
layout(location = 1) in vec3 nor;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    
    // Lighting Parameters
    vec3 albedo = vec3(0.1, 0.5, 0.0);
    vec3 lightPos = vec3(0.0, 100.0, 0.0);

    // Diffuse Lighting
    vec3 l = normalize(lightPos - pos);
    float lambert = max(dot(l, normalize(nor)), 0.0);

    vec3 result = albedo + lambert * vec3(0.3);

    outColor = vec4(result, 1.0);
}
