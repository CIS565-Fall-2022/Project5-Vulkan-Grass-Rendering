#version 450
#extension GL_ARB_separate_shader_objects : enable

#define INV_SQRT_THREE 0.577350269189625764509148780501957456

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout (location = 0) in vec3 v0in[];
layout (location = 1) in vec3 v1in[];
layout (location = 2) in vec3 v2in[];
layout (location = 3) in vec3 rightin[];

layout (location = 0) out vec3 v0out[];
layout (location = 1) out vec3 v1out[];
layout (location = 2) out vec3 v2out[];
layout (location = 3) out vec3 rightout[];

vec3 getDifferentDir(vec3 dir) {
	// Find a direction that is not the dir based of whether or not the
	// dir's components are all equal to sqrt(1/3) or whether or not at
	// least one component is less than sqrt(1/3). Learned this trick from
	// Peter Kutz.

	vec3 T;
	if (abs(dir.x) < INV_SQRT_THREE) {
		T = vec3(1, 0, 0);
	}
	else if (abs(dir.y) < INV_SQRT_THREE) {
		T = vec3(0, 1, 0);
	}
	else {
		T = vec3(0, 0, 1);
	}
	return T;
}

void main() {
	vec3 camPos = vec3(camera.view[3][0], camera.view[3][1], camera.view[3][2]);
    float z = length(v0in[gl_InvocationID].xyz - camPos);
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

    // gl_InvocationID is 0 for all tesc actuallyx
    v0out[gl_InvocationID] = v0in[gl_InvocationID];
    v1out[gl_InvocationID] = v1in[gl_InvocationID];
    v2out[gl_InvocationID] = v2in[gl_InvocationID];
    rightout[gl_InvocationID] = rightin[gl_InvocationID];
    
}
