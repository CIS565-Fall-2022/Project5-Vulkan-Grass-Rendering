#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
    vec3 pos;
} camera;

layout(location = 0) in vec4 teV0[];
layout(location = 1) in vec4 teV1[];
layout(location = 2) in vec4 teV2[];

layout(location = 0) out vec3 norm;
layout(location = 1) out float mixFactor;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

    vec3 v0 = teV0[0].xyz;
    vec3 v1 = teV1[0].xyz;
    vec3 v2 = teV2[0].xyz;

    float phi = teV0[0].w;
    float width = teV2[0].w;

    vec3 a = mix(v0, v1, v);
    vec3 b = mix(v1, v2, v);
    vec3 c = mix(a, b, v);

    vec3 t0 = normalize(b - a);
    vec3 t1 = vec3(cos(phi), 0.0, sin(phi));

    vec3 c0 = c - width * t1;
    vec3 c1 = c + width * t1;

    norm = normalize(cross(t0, t1));
    mixFactor = 2 * v - v * v;

    float t = u + 0.5 * v - u * v;
    gl_Position = camera.proj * camera.view * vec4(mix(c0, c1, t), 1.0);
}
