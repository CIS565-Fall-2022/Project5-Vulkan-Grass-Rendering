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

layout(location = 0) out vec3 pos;
layout(location = 1) out vec3 nor;


// Reference: Responsive Real-Time Grass Rendering for General 3D Scenes
// https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf
void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for
    //each vertex of the grass blade
    

    //De Casteljau's algorithm
    vec3 a  = vec3(in_v0[0] + v * (in_v1[0] - in_v0[0]));
    vec3 b  = vec3(in_v1[0] + v * (in_v2[0] - in_v1[0]));
    vec3 c  = a + v * (b - a);

    float theta = in_v0[0].w;
    vec3 t1 = vec3(sin(theta), 0.f, cos(theta));
    t1 = normalize(t1);
    vec3 t0 = normalize(b - a); 

    vec3 c0 = c - in_v2[0].w * t1;
    vec3 c1 = c + in_v2[0].w * t1;
             
    float t = u + 0.5 * v - u * v;
    pos  = mix(c0, c1, t);
    nor  = normalize(cross(t0, t1)); 
    gl_Position = camera.proj * camera.view * vec4(pos, 1.0); 
}
