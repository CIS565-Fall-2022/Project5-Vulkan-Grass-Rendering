#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

layout(location = 0) in vec4 pos;
layout(location = 1) in vec4 nor;
layout(location = 2) in vec2 uv;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    //vec3 tipColor = vec3(0.19, 0.73, 0.34);
    vec3 bottomColor = vec3(0.03, 0.34, 0.11);
    vec3 tipColor = vec3(0.01, 0.91, 0.31);

    vec3 color = mix(tipColor, bottomColor, uv.y);

    vec3 lightPos = inverse(camera.view)[3].xyz;

    float ambient = 0.4;
    float lambert = clamp(dot(normalize(nor.xyz), normalize(lightPos - pos.xyz)), 0.0, 1.0);

    float lighting = clamp(lambert + ambient, 0.0, 1.0);

    outColor = vec4(color * lighting, 1.0);
}
