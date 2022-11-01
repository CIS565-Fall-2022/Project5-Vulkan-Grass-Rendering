#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout (location = 0) in vec3 norm;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    mat4 viewModel = inverse(camera.view);
    vec3 cameraPos = vec3(viewModel[3]); 
    vec3 forward = normalize(vec3(cameraPos.x, cameraPos.y, cameraPos.z));
    outColor = vec4(0.0, .80, 0.0, 1.0) * abs(dot(forward, norm));
}
