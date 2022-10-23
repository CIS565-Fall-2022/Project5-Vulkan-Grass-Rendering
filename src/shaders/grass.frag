#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 in_normal;
layout(location = 1) in vec3 in_pos;
layout(location = 2) in vec2 in_uv;

layout(location = 0) out vec4 outColor;

#define BOTTOM_COLOR (vec3(0,74,0) / 255.f)
#define TOP_COLOR (vec3(76,255,0) / 255.f)

void main() {
    // TODO: Compute fragment color
    outColor = vec4(mix(BOTTOM_COLOR, TOP_COLOR, in_uv.y), 1.f);

    /*
    vec3 lightPos = vec3(0, 20, 0);
    vec3 lightDir = normalize(lightPos - in_pos);
    
    vec3 diffuseColor = vec3(0, 1, 0);
    vec3 ambientColor = vec3(0, 1, 0);
    vec3 color = 0.3f * ambientColor + diffuseColor * max(dot(lightDir, in_normal), 0.f);
    outColor = vec4(color.xyz, 1.f);
    */
}
