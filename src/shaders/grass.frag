#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 position;
layout(location = 1) in vec3 normal;
layout(location = 2) in float height;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    // Lighting Parameters
    vec3 green = vec3(0.25, 0.75, 0.0);
    vec3 darkGreen = vec3(0.1, 0.4, 0.0);

    float t = (height - 1.3f) / 2.5f;
    vec3 color = mix(green, darkGreen, t);

    vec3 lightPos = vec3(10.0, 50.0, 0.0);

    // Diffuse Lighting
    vec3 lightDir = normalize(lightPos - position);
    float lambert = max(dot(lightDir, normalize(normal)), 0.0);

    vec3 result = color + lambert * vec3(0.3);

    outColor = vec4(result, 1.0);
}
