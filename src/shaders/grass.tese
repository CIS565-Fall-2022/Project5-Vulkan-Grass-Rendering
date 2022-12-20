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

layout(location = 0) out vec3 out_pos;
layout(location = 1) out vec3 out_nor;


void main() {
    //gl_TessCoord: The uv coordinates of the current vertex within the patch
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec3 v0 = vec3(in_v0[0]);
    vec3 v1 = vec3(in_v1[0]);
    vec3 v2 = vec3(in_v2[0]);

    float dir = in_v0[0].w;
    vec3 dirVec = normalize(vec3(cos(dir), 0, sin(dir))); 
    vec3 t1 = dirVec;

    //This will make all grass point at vec3(1, 0, 0)
    //float dirDot = dot(dirVec, vec3(1, 0, 0));
    //if(dirDot > 0){
    //    t1 = vec3(1, 0, 0);
    //}else{
    //    t1 = vec3(-1, 0, 0);
    //}

    float w = in_v2[0].w;

    vec3 a = v0 + v * (v1 - v0);
    vec3 b = v1 + v * (v2 - v1);
    vec3 c = a + v * (b - a);
    vec3 c0 = c - w * t1;
    vec3 c1 = c + w * t1;
    vec3 t0 = normalize(b - a);
    vec3 n = normalize(cross(t0, t1));

    //De Casteljau, quadratic
    float t = u - (u * v * v);
    vec3 p = (1 - t) * c0 + t * c1;
   
    out_pos = p;
    out_nor = n;

    gl_Position = camera.proj * camera.view * vec4(p, 1.0f);
}
