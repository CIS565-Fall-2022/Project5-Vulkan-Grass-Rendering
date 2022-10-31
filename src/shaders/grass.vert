
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

// Outputs are passed to tessellation shaders
layout(location = 0) out vec4 v0Out;
layout(location = 1) out vec4 v1Out;
layout(location = 2) out vec4 v2Out;
layout(location = 3) out vec4 upOut;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs

    gl_Position = model * vec4(v0.xyz, 1.f);
    v0Out = vec4((model * vec4(v0.xyz, 1.f)).xyz, v0.w);
    v1Out = vec4((model * vec4(v1.xyz, 1.f)).xyz, v1.w);
    v2Out = vec4((model * vec4(v2.xyz, 1.f)).xyz, v2.w);
    upOut = vec4((model * vec4(up.xyz, 0.f)).xyz, up.w);
}
