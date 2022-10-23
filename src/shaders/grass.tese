#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

// NOTE: The length of the input array is the size of the input patch.
// here they all have a size of 1
layout(location = 0) in vec4 in_v0[];
layout(location = 1) in vec4 in_v1[];
layout(location = 2) in vec4 in_v2[];
layout(location = 3) in vec4 in_up[];

layout(location = 0) out vec3 out_normal;
layout(location = 1) out vec3 out_pos;
layout(location = 2) out vec2 out_uv;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    out_uv = vec2(u, v);

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade

    // fetch data according to how they were set up in Blades.cpp
    float theta = in_v0[0].w;
    float height = in_v1[0].w;
    float width = in_v2[0].w;
    float stiffness = in_up[0].w;

    vec3 v0 = in_v0[0].xyz;
    vec3 v1 = in_v1[0].xyz;
    vec3 v2 = in_v2[0].xyz;
    vec3 up = in_up[0].xyz;


    // De Casteljau algorithm to calculate a point on the Bezier
    // Jahrmann 2017 6.3
    vec3 a = mix(v0, v1, v);
    vec3 b = mix(v1, v2, v);
    vec3 c = mix(a, b, v);

    // tangent direction
    vec3 t0 = normalize(b - a);
    // bitangent direction (assuming up is (0,1,0))
    vec3 t1 = normalize(vec3(-cos(theta), 0, sin(theta)));
    out_normal = normalize(cross(t0, t1));

    float blend = u + 0.5f * v - u * v;
    vec3 p = mix(c - width * t1, c + width * t1, blend);

    gl_Position = camera.proj * camera.view * vec4(p, 1.f);
    out_pos = vec3(gl_Position);
}
