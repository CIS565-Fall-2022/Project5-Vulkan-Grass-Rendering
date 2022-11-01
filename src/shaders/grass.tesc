#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout (location = 0) in vec3 v0tc[];
layout (location = 1) in vec3 v1tc[];
layout (location = 2) in vec3 v2tc[];
layout (location = 3) in vec3 uptc[];
layout (location = 4) in float wtc[];

layout (location = 0) out vec3 v0te[];
layout (location = 1) out vec3 v1te[];
layout (location = 2) out vec3 v2te[];
layout (location = 3) out vec3 upte[];
layout (location = 4) out float wte[];

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
    v0te[gl_InvocationID] = v0tc[gl_InvocationID];
    v1te[gl_InvocationID] = v1tc[gl_InvocationID];
    v2te[gl_InvocationID] = v2tc[gl_InvocationID];
    upte[gl_InvocationID] = uptc[gl_InvocationID];
    wte[gl_InvocationID] = wtc[gl_InvocationID];
	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = 4.0;
    gl_TessLevelInner[1] = 4.0;
    gl_TessLevelOuter[0] = 4.0;
    gl_TessLevelOuter[1] = 4.0;
    gl_TessLevelOuter[2] = 4.0;
    gl_TessLevelOuter[3] = 4.0;
}
