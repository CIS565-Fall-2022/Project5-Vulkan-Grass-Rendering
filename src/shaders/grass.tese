#version 450
#extension GL_ARB_separate_shader_objects : enable
#define SQRT_OF_ONE_THIRD 0.5773502691896257645091487805019574556476f

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

layout(location = 0) out vec3 normal;
layout(location = 1) out float height;


vec3 localToGlobal(vec3 p, vec3 n){
    vec3 directionNotNormal;
    if (abs(n.x) < SQRT_OF_ONE_THIRD) {
        directionNotNormal = vec3(1, 0, 0);
    }
    else if (abs(n.y) < SQRT_OF_ONE_THIRD) {
        directionNotNormal = vec3(0, 1, 0);
    }
    else {
        directionNotNormal = vec3(0, 0, 1);
    }

    // Use not-normal direction to generate two perpendicular directions
    vec3 perpendicularDirection1 = normalize(cross(n, directionNotNormal));
    vec3 perpendicularDirection2 = normalize(cross(n, perpendicularDirection1));
    return p.x * perpendicularDirection1 + p.y * perpendicularDirection2 + p.z * n;
}

float noise1D(vec3 p)
{
    return fract(sin(dot(p, vec3(135.1, 211.6, 173.3))) * 43758.5453);
}

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    height = v;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec3 v0 = in_v0[0].xyz;
    vec3 v1 = in_v1[0].xyz;
    vec3 v2 = in_v2[0].xyz;
    vec3 up = in_up[0].xyz;
    float angle = in_v0[0].w;
    float height = in_v1[0].w;
    float width = in_v2[0].w;
    vec3 t1 = localToGlobal(vec3(cos(angle), sin(angle), 0), up); 

    vec3 a = v0 + v * (v1 - v0);
    vec3 b = v1 + v * (v2 - v1);
    vec3 c = a + v * (b - a);
    vec3 c0 = c - width * t1;
    vec3 c1 = c + width * t1;
    vec3 t0 = normalize(b-a);
    vec3 norm = normalize(cross(t0, t1));
    normal = norm;

    float rand = noise1D(v0);

    float t;
    if (rand > 0.66) // triangles
    {
        t = u + 0.5 * v - u * v;
    }
    else if (rand > 0.33) // quadratic
    {
        t = u - u * v * v;
    }
    else // triangle-tip
    {
        float tau = noise1D(v0);
        t = 0.5 + (u - 0.5) * (1 - max(v - tau, 0)/(1 - tau));
    }

    // 3D displacement
    vec3 d = width * norm * (0.5 - abs(u - 0.5) * (1 - v));

    gl_Position = camera.proj * camera.view * vec4((1 - t) * c0 + t * c1 + d, 1.f);
}
