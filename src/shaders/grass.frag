#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 in_pos;
layout(location = 1) in vec4 in_nor;
layout(location = 2) in float verticality;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec4 green = vec4(0.34, 0.64, 0.0, 1.0);

    vec3 lightPos = vec3(20.0, 20.0, 20.0);

    // Lambertian reflection
    vec3 lightVec = normalize(lightPos - vec3(in_pos));
    float diffuseTerm = dot(normalize(vec3(in_nor)), normalize(lightVec));

    // Avoid negative lighting values
    diffuseTerm = clamp(diffuseTerm, 0, 1);

    float ambientTerm = 0.2;

    float lightIntensity = diffuseTerm + ambientTerm;

    float heightLerp = (1 - verticality) * 0.3 + verticality * 0.8;
    outColor = heightLerp * green; // vec4(vec3(green) * lightIntensity, green.w);

}