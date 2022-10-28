
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout(location = 0) in vec4 aV0;
layout(location = 1) in vec4 aV1;
layout(location = 2) in vec4 aV2;
layout(location = 3) in vec4 aUp;

layout(location = 0) out vec4 vV0;
layout(location = 1) out vec4 vV1;
layout(location = 2) out vec4 vV2;
layout(location = 3) out vec4 vUp;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
}
