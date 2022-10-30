#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 in_norm;
layout(location = 1) in vec3 in_pos;

layout(location = 0) out vec4 out_color;

void main() {
    // TODO: Compute fragment color
    vec3 grass_color = vec3(86.0, 125.0, 70.0)/255.0;

    vec3 light_pos = vec3(5.0, 5.0, 5.0);
    vec3 light_dir = normalize(vec3(light_pos - in_pos));

    float diffuse_term = clamp(dot(in_norm, light_dir), 0.0, 1.0);
    
    float ambient_term = 0.2;

    float intensity = diffuse_term + ambient_term;

    out_color =  vec4(grass_color * intensity, 1.0);
}
