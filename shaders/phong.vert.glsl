#version 150 core

// Matrices uniformes
uniform mat4 mvp;
uniform mat4 model;
uniform mat4 view;
uniform mat4 proj;

// Entrées des sommets
in vec3 in_pos;
in vec3 in_normal;

// Variables de sortie pour le fragment shader
out vec4 color;
out vec3 lightDir;
out vec3 eyeVec;
out vec3 out_normal;

void main(void)
{
    vec3 inverted_normal = -in_normal;
    color = vec4(inverted_normal, 0.0);

    gl_Position = proj * view * model * vec4(in_pos, 1.0);

    vec4 vVertex = view * model * vec4(in_pos, 1.0);
    eyeVec = -vVertex.xyz;
    vec4 LightSource_position = vec4(0.0, 0.0, 10.0, 0.0);
    lightDir = vec3(LightSource_position.xyz - vVertex.xyz);

    out_normal = vec3(view * model * vec4(in_normal, 0.0));
}