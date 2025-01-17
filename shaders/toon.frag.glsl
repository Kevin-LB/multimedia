#version 150 core

in vec4 color;

out vec4 frag_color;

in vec3 lightDir;
in vec3 eyeVec;
in vec3 out_normal;

vec4 toonify(float intensity) {
    if (intensity > 0.98)
        return vec4(0.8, 0.8, 0.8, 1.0);
    else if (intensity > 0.5)
        return vec4(0.4, 0.4, 0.8, 1.0);
    else if (intensity > 0.25)
        return vec4(0.2, 0.2, 0.4, 1.0);
    else
        return vec4(0.1, 0.1, 0.1, 1.0);
}

void main(void)
{
    vec3 L = normalize(lightDir);
    vec3 N = normalize(out_normal);

    float intensity = max(dot(L, N), 0.0);

    vec3 E = normalize(eyeVec);
    vec3 R = reflect(-L, N);
    float specular = pow(max(dot(R, E), 0.0), 2.0);

    vec4 toon_color = toonify(intensity);
    vec4 final_color = vec4(0.2, 0.2, 0.2, 1.0);
    final_color += toon_color * specular;
    final_color += 0.6 * intensity * toon_color;

    frag_color = final_color;
}