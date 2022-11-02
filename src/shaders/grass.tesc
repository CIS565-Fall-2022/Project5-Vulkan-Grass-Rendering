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
layout(location = 2) out vec4 teV2out[];


void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
    teV0out[gl_InvocationID] = tcV0in[gl_InvocationID]; 
    teV1out[gl_InvocationID] = tcV1in[gl_InvocationID]; 
    teV2out[gl_InvocationID] = tcV2in[gl_InvocationID]; 

	// TODO: Set level of tesselation
    vec3 camPos = inverse(camera.view)[3].xyz;

    float z = length(tcV0in[gl_InvocationID].xyz - camPos);

	int LOD;
	if (z < 4.0)
		LOD = 16;
	else if (z < 8.0)
		LOD = 12;
	else if (z < 16.0)
		LOD = 8;
	else if (z < 32.0)
		LOD = 4;
	else
		LOD = 1;

    gl_TessLevelInner[0] = LOD;
    gl_TessLevelInner[1] = LOD;

    gl_TessLevelOuter[0] = LOD;
    gl_TessLevelOuter[1] = LOD;
    gl_TessLevelOuter[2] = LOD;
    gl_TessLevelOuter[3] = LOD;

    // gl_InvocationID is 0 for all te

}
