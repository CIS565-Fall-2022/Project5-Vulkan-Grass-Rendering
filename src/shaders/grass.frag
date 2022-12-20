#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 in_pos;
layout(location = 1) in vec3 in_nor;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec3 albedo = vec3(0.56, 0.93, 0.56);
    
    vec3 lightPos = vec3(10, 20, 10);
    vec3 toLight = normalize(lightPos - in_pos);
    vec3 nor = in_nor;
    float lambert = dot(toLight, nor);

    vec3 ambient = vec3(0.18, 0.31, 0.18);

    outColor = vec4(ambient + (lambert * albedo), 1);
}
