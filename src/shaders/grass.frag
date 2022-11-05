#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout (location = 0) in vec2 uv;
layout(location = 0) out vec4 outColor;
//vec3 bottom = normalize(vec3(179, 255, 174));
//vec3 top = normalize(vec3(255, 100, 100));
vec3 bottom = vec3(13./255.,10./255.,75./255.);
vec3 top = normalize(vec3(102, 154, 27));
void main(){
    // DONE: Compute fragment color

   outColor.w = 1;
   outColor.xyz = mix(bottom, top, uv.y);
}
