#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 in_v0[];
layout(location = 1) in vec4 in_v1[];
layout(location = 2) in vec4 in_v2[];
layout(location = 3) in vec4 in_up[];

layout(location = 0) out vec3 out_normal;
layout(location = 1) out vec3 out_pos;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    vec3 v0 = in_v0[0].xyz;
    vec3 v1 = in_v1[0].xyz;
    vec3 v2 = in_v2[0].xyz;
    vec3 up = in_up[0].xyz;
    float ori = in_v0[0].w;
    float height = in_v1[0].w;
    float width = in_v2[0].w;
    float stiffness = in_up[0].w;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    //de casteljau algo
    vec3 a = mix(v0, v1, v);
    vec3 b = mix(v1, v2, v);
    vec3 c = mix(a, b, v);

    vec3 t0 = normalize(b-a);
    vec3 t1 = normalize(vec3(-cos(ori), 0, sin(ori)));
    out_normal = normalize(cross(t0, t1));

    float t = u + 0.5*v - u*v;
    vec3 pos = mix(c - width * t1, c + width * t1, t);

    out_pos = pos;

    gl_Position = camera.proj * camera.view * vec4(pos, 1.f);
}
