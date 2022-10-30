
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
} model;

// TODO: Declare vertex shader inputs and outputs
layout (location = 0) in vec4 v0in;
layout (location = 1) in vec4 v1in;
layout (location = 2) in vec4 v2in;
layout (location = 3) in vec4 upin;

layout (location = 0) out vec4 v0out;
layout (location = 1) out vec4 v1out;
layout (location = 2) out vec4 v2out;
layout (location = 3) out vec4 upout;

void main() {
    vec4 v0tmp = model.model * vec4(v0in.xyz, 1.0);
    vec4 v1tmp = model.model * vec4(v1in.xyz, 1.0);
    vec4 v2tmp = model.model * vec4(v2in.xyz, 1.0);
    vec4 uptmp = model.model * vec4(upin.xyz, 1.0);
    v0tmp /= v0tmp.w;
    v1tmp /= v1tmp.w;
    v2tmp /= v2tmp.w;
    v0out = vec4(v0tmp.xyz, v0in.w);
    v1out = vec4(v1tmp.xyz, v1in.w);
    v2out = vec4(v2tmp.xyz, v2in.w);
    upout = vec4(normalize(uptmp.xyz), upin.w);
}
