#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in float fs_V;
layout(location = 1) in vec3 fs_Nor;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec3 colorBottom = vec3(14, 56, 25) / 255.0;
    vec3 colorTop = vec3(50, 201, 90) / 255.0;
    vec4 diffuseColor = vec4(mix(colorBottom, colorTop, fs_V), 1.0);
    vec3 lightDir = vec3(0.0, 1.0, 0.0);

    float diffuseTerm = dot(normalize(fs_Nor), normalize(lightDir));
    diffuseTerm = clamp(diffuseTerm, 0, 1);

    float ambientTerm = 1.0;

    float lightIntensity = diffuseTerm + ambientTerm;
    outColor = diffuseColor * lightIntensity;
}
