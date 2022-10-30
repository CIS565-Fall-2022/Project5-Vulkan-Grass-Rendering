
#version 450
#extension GL_ARB_separate_shader_objects : enable

#define INV_SQRT_THREE 0.577350269189625764509148780501957456

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
} model;

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

// TODO: Declare vertex shader inputs and outputs
layout (location = 0) in vec4 v0in;
layout (location = 1) in vec4 v1in;
layout (location = 2) in vec4 v2in;
layout (location = 3) in vec4 upin;

layout (location = 0) out vec3 v0out;
layout (location = 1) out vec3 v1out;
layout (location = 2) out vec3 v2out;
layout (location = 3) out vec3 rightout;

void main() {
    vec4 v0tmp = model.model * vec4(v0in.xyz, 1.0);
    vec4 v1tmp = model.model * vec4(v1in.xyz, 1.0);
    vec4 v2tmp = model.model * vec4(v2in.xyz, 1.0);
    v0tmp /= v0tmp.w;
    v1tmp /= v1tmp.w;
    v2tmp /= v2tmp.w;
    v0out = v0tmp.xyz;
    v1out = v1tmp.xyz;
    v2out = v2tmp.xyz;

    vec3 up = normalize((model.model * vec4(upin.xyz, 1.0)).xyz);
    
    float theta = v0in.w;
	vec3 T = getDifferentDir(up);
	T = normalize(cross(T, up));
	vec3 B = normalize(cross(T, up));
    vec3 fwd = T * cos(theta) + B * sin(theta);
    vec3 right = cross(fwd, up);
    rightout = right * v2in.w;
}
