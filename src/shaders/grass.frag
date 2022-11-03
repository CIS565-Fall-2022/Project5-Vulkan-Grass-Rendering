#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

layout(location = 0) in vec2 in_uv;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color

    vec3 rootColor = vec3(0.1, 0.4, 0.2);
    vec3 tipColor =  vec3(0.1, 0.8, 0.1);

    outColor = vec4(1.0);
    
    outColor = vec4(mix(rootColor, tipColor, in_uv.y), 1.);
}
