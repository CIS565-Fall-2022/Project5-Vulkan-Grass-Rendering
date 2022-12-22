#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4[] in_v0;
layout(location = 1) in vec4[] in_v1;
layout(location = 2) in vec4[] in_v2;
layout(location = 3) in vec4[] in_up;

layout(location = 0) out vec4 pos;
layout(location = 1) out vec4 nor;
layout(location = 2) out vec2 uv;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec3 v0 = in_v0[0].xyz;
    vec3 v1 = in_v1[0].xyz;
    vec3 v2 = in_v2[0].xyz;

    float w = in_v2[0].w;
    float angle = in_v0[0].w;

    vec3 a = mix(v0, v1, v);
    vec3 b = mix(v1, v2, v);
    vec3 c = mix(a, b, v);

    vec3 t0 = (b - a) / length(b - a);
    vec3 t1 = normalize(vec3(cos(angle), 0, sin(angle)));

    vec3 c0 = c - w * t1;
    vec3 c1 = c + w * t1;

    nor = vec4(normalize(cross(t0, t1)), 0.0);
    
    float tau = 0.5;
    float t = 0.5 - (u - 0.5) * (1 - (max(v - tau, 0.0)/(1.0 - tau)));

    vec3 p = (1.0 - t) * c0 + t * c1;
    pos = vec4(p, 1.0);

    uv = vec2(u, v);

    gl_Position = camera.proj * camera.view * vec4(p, 1.0);
}
