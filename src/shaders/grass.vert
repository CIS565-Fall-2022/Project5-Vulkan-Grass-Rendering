
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
// Reference tutorial: https://vulkan-tutorial.com/Vertex_buffers/Vertex_input_description

layout(location = 0) in vec4 v0;
layout(location = 1) in vec4 v1;
layout(location = 2) in vec4 v2;
layout(location = 3) in vec4 up;

layout(location = 0) out vec4 tcs_v1;
layout(location = 1) out vec4 tcs_v2;
layout(location = 2) out vec4 tcs_up;


out gl_PerVertex {
    vec4 gl_Position;
};

vec4 multiply(mat4 m, vec4 v) {
    vec4 ans = m * vec4(v.xyz, 1.0);
    ans.w = v.w;    // copying the 4th value as it is instead of multiplying because it contains additional information like orientation, width, stiffness etc which will be required in evaluation shader
    return ans;
}

void main() {
	// TODO: Write gl_Position and any other shader outputs
    
    /*
    Converting from local space to world space next, we can also do it after tesselation but it might be less efficient as more number of points will have to be transformed. 
    Note how we are not transforming into screen space yet as we will have to use world space positions for positioning tessellated points later in evaluation
    shader.
    We will then have to transform all tessellated and positioned points into screen space.
    */

    tcs_v1 = multiply(model, v1);
    tcs_v2 = multiply(model, v2);
    tcs_up = multiply(model, up);

    // Store v0 as gl_Position - we want to use v0 as our blade position and other points evaluated with respect to it in evaluation shader
    gl_Position = multiply(model, v0);

}
