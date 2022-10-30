#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout (location = 0) in vec3 v0in[];
layout (location = 1) in vec3 v1in[];
layout (location = 2) in vec3 v2in[];
layout (location = 3) in vec3 rightin[];

layout (location = 0) out float uout;
layout (location = 1) out float vout;

vec2 interpolate(vec2 v0, vec2 v1, vec2 v2)
{
    return gl_TessCoord.x * v0 + gl_TessCoord.y * v1 + gl_TessCoord.z * v2;
}

vec3 interpolate(vec3 v0, vec3 v1, vec3 v2)
{
    return gl_TessCoord.x * v0 + gl_TessCoord.y * v1 + gl_TessCoord.z * v2;
}

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    uout = u;
    vout = v;

    vec3 v2orig = v2in[0];
    vec3 v0orig = v0in[0];
    vec3 v1 = v1in[0];
    vec3 right = rightin[0];

    float t = u  - 0.5;
    vec3 v0 = v0orig + right * t;
    vec3 v2 = v2orig + right * t * 0.15;
    t = 1-v;
    vec3 p1 = mix(v0, v1, t);
    vec3 p2 = mix(v1, v2, t);
    vec3 pos = mix(p1, p2, t);
    gl_Position = camera.proj * camera.view * vec4(pos, 1.0);
}
