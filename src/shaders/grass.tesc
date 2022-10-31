#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs

layout(location = 0) in vec4 tcV0in[];
layout(location = 1) in vec4 tcV1in[];
layout(location = 2) in vec4 tcV2in[];
layout(location = 3) in vec3 tcUpin[];

layout(location = 0) out vec4 teV0out[];
layout(location = 1) out vec4 teV1out[];




layout(location = 2) out vec4 teV2[];
void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
    vec3 camPos = vec3(camera.view[3][0], camera.view[3][1], camera.view[3][2]);
    float z = length(tcV0in[gl_InvocationID].xyz - camPos);

	int level;
	if (z < 4.0)
		level = 16;
	else if (z < 8.0)
		level = 12;
	else if (z < 16.0)
		level = 8;
	else if (z < 32.0)
		level = 4;
	else
		level = 2;

    gl_TessLevelInner[0] = level;
    gl_TessLevelInner[1] = level;
    gl_TessLevelOuter[0] = level;
    gl_TessLevelOuter[1] = level;
    gl_TessLevelOuter[2] = level;
    gl_TessLevelOuter[3] = level;

    // gl_InvocationID is 0 for all te

	// TODO: Set level of tesselation
    // gl_TessLevelInner[0] = ???
    // gl_TessLevelInner[1] = ???
    // gl_TessLevelOuter[0] = ???
    // gl_TessLevelOuter[1] = ???
    // gl_TessLevelOuter[2] = ???
    // gl_TessLevelOuter[3] = ???
}
