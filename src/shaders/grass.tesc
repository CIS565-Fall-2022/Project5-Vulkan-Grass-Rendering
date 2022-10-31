#version 450
#extension GL_ARB_separate_shader_objects : enable

# define TESS_LEVEL 20
# define DYNAMIC_TESS 0

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
    layout(location = 0) in vec4 in_v0[];
    layout(location = 1) in vec4 in_v1[];
    layout(location = 2) in vec4 in_v2[];
    layout(location = 3) in vec4 in_up[];

    layout(location = 0) out vec4 out_v0[];
    layout(location = 1) out vec4 out_v1[];
    layout(location = 2) out vec4 out_v2[];
    layout(location = 3) out vec4 out_up[];

    float getLOD(float d)
    {
        float LOD = 20.0;
        if( d > 15.0)
        {
            LOD = 2.0;
        }
        else if (d > 10)
        {
            LOD = 5.0;
        }
        else if (d > 5)
        {
            LOD = 10.0;
        }
        return LOD;
    }

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
    out_v0[gl_InvocationID] = in_v0[gl_InvocationID];
    out_v1[gl_InvocationID] = in_v1[gl_InvocationID];
    out_v2[gl_InvocationID] = in_v2[gl_InvocationID];
    out_up[gl_InvocationID] = in_up[gl_InvocationID];


	// TODO: Set level of tesselation
    vec3 camera_pos = vec3(inverse(camera.view) * vec4(0.f, 0.f, 0.f, 1.f));
    //vec3 view = in_v0[gl_InvocationID].xyz - camera_pos;
    float dist = distance(camera_pos, in_v0[gl_InvocationID].xyz);

    #if DYNAMIC_TESS
     gl_TessLevelInner[0] = getLOD(dist);
     gl_TessLevelInner[1] = getLOD(dist);
     gl_TessLevelOuter[0] = getLOD(dist);
     gl_TessLevelOuter[1] = getLOD(dist);
     gl_TessLevelOuter[2] = getLOD(dist);
     gl_TessLevelOuter[3] = getLOD(dist);
     #else
     gl_TessLevelInner[0] = TESS_LEVEL;
     gl_TessLevelInner[1] = TESS_LEVEL;
     gl_TessLevelOuter[0] = TESS_LEVEL;
     gl_TessLevelOuter[1] = TESS_LEVEL;
     gl_TessLevelOuter[2] = TESS_LEVEL;
     gl_TessLevelOuter[3] = TESS_LEVEL;
     #endif
}
