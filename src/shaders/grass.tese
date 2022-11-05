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

layout(location = 0) out vec2 uv;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    uv = vec2(u, v);
    float theta = in_v0[0].w;
    float width = in_v2[0].w;
    //vec3 normal = vec3(sin(theta), 0 , -cos(theta)); 
    //vec3 tangent = vec3(cos(theta), 0, sin(theta));
    vec3 normal = vec3(sin(theta), 1, -cos(theta)); 
    vec3 tangent = vec3(cos(theta), 0, sin(theta));
   // vec3 t1 = normalize(cross(normal, tangent));
   //Looks better?
    vec3 t1 = normalize(vec3(-cos(theta), 0.0f, -sin(theta)));
	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    //0 for 1 vertex hopefully
    vec3 a = in_v0[0].xyz + v*(in_v1[0].xyz - in_v0[0].xyz);
    vec3 b = in_v1[0].xyz + v*(in_v2[0].xyz - in_v1[0].xyz);
    vec3 c = a + v*(b-a);
    vec3 c0 = c - width*t1;
    vec3 c1 = c + width*t1;
    //Maybe distance
    vec3 t0 = (b-a)/distance(b,a);
    vec3 n = cross(t0, t1)/length(cross(t0,t1));
    //Tri Tip
    float tau = 0.75f;
    float t = 0.5f + (u - 0.5f)*(1.0f-max((v-tau), 0)/(1.0f-tau));
    vec3 p = (1-t)*c0 + t *c1;
    vec3 d = width * n * (0.5 - abs(u-0.5) * (1-v));
    p += d;


    gl_Position = camera.proj * camera.view * vec4(p, 1);

}
