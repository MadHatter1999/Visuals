precision highp float;

// Time uniform to animate the effect
uniform float time;

// Function to generate a noise pattern
float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
    float a = dot(i, vec2(12.9898, 78.233));
    float b = dot(i + vec2(1.0, 0.0), vec2(12.9898, 78.233));
    float c = dot(i + vec2(0.0, 1.0), vec2(12.9898, 78.233));
    float d = dot(i + vec2(1.0, 1.0), vec2(12.9898, 78.233));
    vec4 v = vec4(a, b, c, d);
    v = fract(sin(v) * 43758.5453);
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(mix(v.x, v.y, u.x), mix(v.z, v.w, u.x), u.y);
}

void main() {
    // Normalize coordinates
    vec2 st = gl_FragCoord.xy / vec2(800.0, 600.0);
    st = st * 2.0 - 1.0;

    // Apply time-varying distortion
    vec2 q = vec2(noise(st + time * 0.1), noise(st - time * 0.1));
    vec2 r = vec2(noise(st + q), noise(st - q));

    // Generate the color pattern
    vec3 color = vec3(noise(r * 2.0), noise(r * 3.0), noise(r * 4.0));

    // Output the final color
    gl_FragColor = vec4(color, 1.0);
}
