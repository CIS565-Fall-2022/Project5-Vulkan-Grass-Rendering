
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout (location = 0) in vec4 v0;
layout (location = 1) in vec4 v1;
layout (location = 2) in vec4 v2;
layout (location = 3) in vec4 v3;

layout (location = 0) out vec3 v0tc;
layout (location = 1) out vec3 v1tc;
layout (location = 2) out vec3 v2tc;
layout (location = 3) out vec3 uptc;
layout (location = 4) out float wtc;


void main() {
	// TODO: Write gl_Position and any other shader outputs
    gl_Position = model * vec4(vec3(v0.x, v0.y, v0.z), 1.0);
    v0tc = vec3(model * vec4(vec3(v0), 1.0));
    v1tc = vec3(model * vec4(vec3(v1), 1.0));
    v2tc = vec3(model * vec4(vec3(v2), 1.0));
    uptc = vec3(model * vec4(vec3(v3), 1.0));
    wtc = v2.w;

    float direction = v0.w;
    uptc = normalize(vec3(wtc * cos(direction), 0.f, wtc * sin(direction))); 
}
