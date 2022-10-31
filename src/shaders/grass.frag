#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 n;
layout(location = 1) in float height;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec3 tipCol = vec3(0.0, 1.0, 0.0);
    vec3 bottomCol = vec3(0.0, 0.2, 0.0);

    vec3 lightDir = vec3(0.0, 0.0, 1.0);
    float lightIntensity = 20.0;
    vec3 col = mix(bottomCol, tipCol, height);// * dot(normalize(lightDir), n) * lightIntensity;

    outColor = vec4(col, 1.0);
}
