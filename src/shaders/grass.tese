#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout (location = 0) in vec3 v0te[];
layout (location = 1) in vec3 v1te[];
layout (location = 2) in vec3 v2te[];
layout (location = 3) in vec3 upte[];
layout (location = 4) in float wte[];

layout (location = 0) out vec3 norm;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

    vec3 v0 = v0te[0];
    vec3 v1 = v1te[0];
    vec3 v2 = v2te[0];
    vec3 up = upte[0];
    float w = wte[0];
    //w = 10.0;


	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec3 a = v0 + v * (v1 - v0);
    vec3 b = v1 + v * (v2 - v1);
    vec3 c = a + v * (b - a);
    //up is bitangent...
    vec3 c0 = c - w * up;
    vec3 c1 = c + w * up;
    float t = u + .5 * v - u * v;
    //float t = v;
    vec3 p = (1 - t) * c0 + t * c1;

    //p = (1-t) * v0 + t * v2;
    gl_Position = camera.proj * camera.view * vec4(p, 1.0);
    //gl_Position = gl_Position + vec4(u, v, 0.0, 0.0);

    vec3 t0 = b - a;
    norm = normalize(cross(t0, up));
}
