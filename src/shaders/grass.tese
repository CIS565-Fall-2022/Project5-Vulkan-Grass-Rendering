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

layout(location = 0) out vec4 finalPos;
layout(location = 1) out vec4 finalNor;
layout(location = 2) out float verticality;

void main() {
    // Attempt to rotate using theta
    float theta = in_v0[0].w;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    verticality = v;

    // Using barycentric output coordinates from the control shader, figure out what the value of the surface is at this bary centric point.
    // Assuming they're just triangles... have current position of the grass blade, and the up vector defines the up, then how do we get the width??
    // How do we parametrize the damn blade itself?

    // The blade parametrization is in the grass paper I'm stupid
    vec3 v0 = vec3(in_v0[0]);
    vec3 v1 = vec3(in_v1[0]);
    vec3 v2 = vec3(in_v2[0]);

    // for now, set width of blade to a constant
    float width = 0.2f;

    // for now, set tangent of blade to x
    vec3 t1 = normalize(vec3(width * cos(theta), 0.f, width * sin(theta))); //vec3(1, 0, 0); // tangent

    vec3 a = v0 + v * (v1 - v0);
    vec3 b = v1 + v * (v2 - v1);
    vec3 c  = a + v * (b - a);

    vec3 c0 = c - width * t1;
    vec3 c1 = c + width * t1;

    vec3 t0 = (b - a) / length(b - a);
    vec3 n = cross(t0, t1) / length(cross(t0, t1));

    // calculate position for a quadric grass shape
    float t = u - (u * v * v);

    // Displace the center of the blade by a little bit
    vec3 nor = vec3(0.f, 0.f, 1.f);
    vec3 displace = width * nor * (0.5 - abs(u - 0.5) * (1 - v));

    // for now, hard code finalNor
    finalPos = vec4((1 - t) * c0 + t * c1 + displace, 1.f);
    finalNor = vec4(nor, 0.f);
    
    gl_Position = camera.proj * camera.view * finalPos;
}