#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

//lists
layout(location = 0) in vec4 v_0[];  
layout(location = 1) in vec4 v_1[];  
layout(location = 2) in vec4 v_2[];  
layout(location = 3) in vec4 up[];  


layout(location = 0) out vec4 position;
layout(location = 1) out vec4 normal;
//v from uv
layout(location = 2) out float uv_h;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    float theta = v_0[0].w;
    float width = v_2[0].w;
    vec3 t1 = vec3(-cos(theta), 0, sin(theta));

    vec3 v0 = v_0[0].xyz;
    vec3 v1 = v_1[0].xyz;
    vec3 v2 = v_2[0].xyz;

    vec3 a  = vec3(v0 + v * (v1 - v0));
    vec3 b  = vec3(v1 + v * (v2 - v1));
    vec3 c  = a + v * (b - a);
    vec3 c0 = c - width * t1;
    vec3 c1 = c + width * t1;
    vec3 t0 = normalize(b - a);          
    vec3 n  = normalize(cross(t0, t1)); 
    //quad
    //float t = u;
    //triangle
    float t = u + 0.5 * v - u * v;
    //quadratic
    //float t = u - u * v * v;
    vec3 p = mix(c0, c1, t);
    //triangle tip
    position = vec4(p, 1.0f);
    normal = vec4(n, 0.0f);
    uv_h = v;
    gl_Position =  camera.proj * camera.view * position;
    
}
