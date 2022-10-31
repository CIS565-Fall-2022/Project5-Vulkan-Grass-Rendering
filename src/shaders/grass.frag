#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 in_norm;
layout(location = 1) in vec3 in_pos;

layout(location = 0) out vec4 out_color;

float noise_gen3_1(vec3 p)
{
    return fract(sin((dot(p, vec3(127.1, 311.7, 191.999)))) * 43758.5453);
}

float interpNoise3D(vec3 noise)
{
    int intX = int(floor(noise.x));
    float fractX = fract(noise.x);
    int intY = int(floor(noise.y));
    float fractY = fract(noise.y);
    int intZ = int(floor(noise.z));
    float fractZ = fract(noise.z);

    float v1 = noise_gen3_1(vec3(intX, intY, intZ));
    float v2 = noise_gen3_1(vec3(intX + 1, intY, intZ));
    float v3 = noise_gen3_1(vec3(intX, intY + 1, intZ));
    float v4 = noise_gen3_1(vec3(intX + 1, intY + 1, intZ));
    float v5 = noise_gen3_1(vec3(intX, intY, intZ + 1));
    float v6 = noise_gen3_1(vec3(intX+1, intY, intZ + 1));
    float v7 = noise_gen3_1(vec3(intX, intY + 1, intZ + 1));
    float v8 = noise_gen3_1(vec3(intX+1, intY+1, intZ + 1));

    float i1 = mix(v1, v2, fractX);
    float i2 = mix(v3, v4, fractX);
    float i3 = mix(v5, v6, fractX);
    float i4 = mix(v7, v8, fractX);

    float ii1 = mix(i1, i2, fractY);
    float ii2 = mix(i3, i4, fractY);

    return mix(ii1, ii2, fractZ);
}

float fbm3D(vec3 noise)
{
    float total = 0.0f;
    float persistence = 0.5f;
    int octaves = 8;
    float freq = 1.0f;
    float amp = 2.0f;
    for (int i=1; i<=octaves; i++)
    {
        total += interpNoise3D(noise * freq) * amp;
        freq *= 2.f;
        amp *= persistence;
    }
    return total;
}


void main() {
    // TODO: Compute fragment color
    vec3 grass_color = vec3(132.0, 192.0, 17.0) / 255.0;
    vec3 grass_color2 = vec3(126.0, 200.0, 80.0) / 255.0;


    vec3 light_pos = vec3(10.0, 20.0, 0.0);
    vec3 light_dir = normalize(light_pos - in_pos);

    float diffuse_term = clamp(dot(in_norm, light_dir), 0.0, 1.0);
    
    float ambient_term = 0.3;

    float intensity = diffuse_term + ambient_term;

    out_color =  vec4(mix(grass_color, grass_color2, fbm3D(in_pos)) * intensity, 1.0);
}
