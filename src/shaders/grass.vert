
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout(location = 0) in vec4 v0;
layout(location = 1) in vec4 v1;
layout(location = 2) in vec4 v2;
layout(location = 3) in vec4 up;

layout(location = 0) out vec4 v0_out;
layout(location = 1) out vec4 v1_out;
layout(location = 2) out vec4 v2_out;
layout(location = 3) out vec4 up_out;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
    v0_out = vec4((model * vec4(v0.xyz, 1.0f)).xyz, v0.w);
    v1_out = vec4((model * vec4(v1.xyz, 1.0f)).xyz, v1.w);
    v2_out = vec4((model * vec4(v2.xyz, 1.0f)).xyz, v2.w);
    up_out = vec4((model * vec4(up.xyz, 1.0f)).xyz, up.w);

    gl_Position = model * vec4(v0.xyz, 1.0f);
        
}
