#version 450
#extension GL_ARB_separate_shader_objects : enable

#define INV_SQRT_THREE 0.577350269189625764509148780501957456

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout (location = 0) in vec4 v0in[];
layout (location = 1) in vec4 v1in[];
layout (location = 2) in vec4 v2in[];
layout (location = 3) in vec4 upin[];

layout (location = 0) out vec4 v0out[];
layout (location = 1) out vec4 v1out[];
layout (location = 2) out vec4 v2out[];
layout (location = 3) out vec4 rightout[];

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

    gl_TessLevelInner[0] = 5;
    gl_TessLevelInner[1] = 5;
    gl_TessLevelOuter[0] = 5;
    gl_TessLevelOuter[1] = 5;
    gl_TessLevelOuter[2] = 5;
    gl_TessLevelOuter[3] = 5;

    // gl_InvocationID is 0 for all tesc actuallyx
    v0out[gl_InvocationID] = v0in[gl_InvocationID];
    v1out[gl_InvocationID] = v1in[gl_InvocationID];
    v2out[gl_InvocationID] = v2in[gl_InvocationID];

    float theta = v0in[gl_InvocationID].w;
    vec3 up = upin[gl_InvocationID].xyz;
    
	vec3 T = getDifferentDir(up);
	T = normalize(cross(T, up));
	vec3 B = normalize(cross(T, up));

    vec3 fwd = T * cos(theta) + B * sin(theta);
    vec3 right = cross(fwd, up) * (v2in[gl_InvocationID].w);
    rightout[gl_InvocationID] = vec4(right, upin[gl_InvocationID].w);
    // rightout[gl_InvocationID] = vec4(upin[gl_InvocationID].xyz * v2in[gl_InvocationID].w, upin[gl_InvocationID].w);
    
}
