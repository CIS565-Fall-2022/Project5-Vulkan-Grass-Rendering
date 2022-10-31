#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

layout(location = 0) in vec4 tes_v1[];
layout(location = 1) in vec4 tes_v2[];
layout(location = 2) in vec4 tes_up[];

// The evaluation shader will set frag position for each tessellated vertex point
// The rasterizer will take care of interpolating between these values to get position per fragment, as input to fragment shader
layout(location = 0) out vec3 fs_pos;
layout(location = 1) out vec3 fs_nor;


vec3 lerp(vec3 v1, vec3 v2, float u){
    return (1 - u) * v1 + u * v2;
}

void main() {

    /*
    We know that TCS does not give positions to points it generates.
    gl_TessCoord.x and gl_TessCoord.y will give you a fraction of how far away a point is with respect to another point in the imaginary quad patch.
    It will allow us to use these values to position each tessellated point wrt each other along the cure using lerp.
    */

    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    
    /*
    Since the layout in control shader generated only one blade per patch, see how the number of elements
    in each array input is just one and can be accessed directly by accessing index 0 of input arrays
    */

    vec3 v0 = gl_in[0].gl_Position.xyz;
    float orientation = gl_in[0].gl_Position.w;

    vec3 v1 = tes_v1[0].xyz;
    vec3 v2 = tes_v2[0].xyz;
    vec3 up = tes_up[0].xyz;
    float width = tes_v2[0].w; //width

    // De Casteljau's Algorithm
    vec3 a = lerp(v0, v1, v);
    vec3 b = lerp(v1, v2, v);
    vec3 c = lerp(a, b, v);

    // Calculate bitangent vector along the width of the blade
    vec3 t1 = vec3(-cos(orientation), 0, sin(orientation));
    normalize(t1);

    vec3 t0 = normalize(b - a);

    fs_nor = normalize(cross(t0, t1));

    vec3 c0 = c - width * t1;
    vec3 c1 = c + width * t1;

    float t = u + 0.5*v - u*v;
    vec3 pos = lerp(c0, c1, t);

    fs_pos = pos;  // vertex position in world space

    gl_Position = camera.proj * camera.view * vec4(pos, 1.0);  // transform to clip space
}
