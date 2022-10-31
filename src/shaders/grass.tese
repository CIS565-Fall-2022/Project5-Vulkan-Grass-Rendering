#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 v0[];
layout(location = 1) in vec4 v1[];
layout(location = 2) in vec4 v2[];
layout(location = 3) in vec4 up[];

layout(location = 0) out vec4 pos;
layout(location = 1) out vec4 nor;
layout(location = 2) out vec2 uv;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade

    // De Casteljau¡¯s algorithm

    // bitangent
    vec3 t1 = vec3(-cos(v0[0].w), 0.f, sin(v0[0].w));

    vec3 a = vec3(v0[0] + v * (v1[0] - v0[0]));
    vec3 b = vec3(v1[0] + v * (v2[0] - v1[0]));
    vec3 c = a + v * (b - a);
    vec3 c0 = c - v2[0].w * t1;
    vec3 c1 = c + v2[0].w * t1;

    // tangent
    vec3 t0 = normalize(b - a);
    // normal
    vec3 n = normalize(cross(t0, t1));
    
    // vertex position (triangle-tip)
    float threshold = 0.2f; // This value is between 0 and 1
    float t = 0.5f + (u - 0.5f) * (1.f - max(v - threshold, 0.f) / (1.f - threshold));
    vec3 p = mix(c0, c1, t);

    pos = vec4(p, 1.f);
    nor = vec4(n, 0.f);
    uv = vec2(u, v);

    gl_Position = camera.proj * camera.view * pos;

}
