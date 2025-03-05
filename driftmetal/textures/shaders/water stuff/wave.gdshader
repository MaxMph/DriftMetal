shader_type spatial;
//uniform vec4 amp = vec4(0.08, 0.06, 0.02, 0.04);
//uniform vec4 freq = vec4(0.8, 1.0, 1.4, 1.2);
//uniform vec4 time_factor = vec4(2.0, 3.0, 4.5, 4.8);
uniform sampler2D noise_texture;
uniform float wave_scale = 0.02;
uniform float wave_strength = 0.2;
uniform float squish = 1.0;

void fragment(){
	ALBEDO = vec3(0.02, 0.06, 0.1);
}

//float height(vec2 pos, float time) {
	//return (amp.x * sin(pos.x * freq.x + time * time_factor.x)) + (amp.z * sin(pos.x * freq.z + time * time_factor.z)) + (amp.y * sin(pos.y * freq.y + time * time_factor.y)) + (amp.w * sin(pos.y * freq.w + time * time_factor.w));
//}

void vertex() {
	//VERTEX.y += height(VERTEX.xz, TIME);
	//TANGENT = normalize(vec3(0.0, height(VERTEX.xz + vec2(0.0, 0.2), TIME) - height(VERTEX.xz + vec2(0.0, -0.2), TIME), 0.4));
	//BINORMAL = normalize(vec3(0.4, height(VERTEX.xz + vec2(0.2, 0.0), TIME) - height(VERTEX.xz + vec2(-0.2, 0.0), TIME ), 0.0));
	//NORMAL = cross(TANGENT, BINORMAL);

	 vec2 global_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xz;
	float noise_value = texture(noise_texture, global_position * wave_scale).r;
	float wave = sin(global_position.x * squish + TIME + noise_value * 10.0) * wave_strength;
	//float wave = sin(global_position.x * squish + TIME) * wave_strength;
	VERTEX.y += wave;
}

//float wave(){
	//return
//}

//uniform vec2 amplitude = vec2(0.2, 0.1);
//uniform vec2 frequency = vec2(3.0, 2.5);
//uniform vec2 time_factor = vec2(2.0, 3.0);
//
//float height(vec2 pos, float time) {
	//return (amplitude.x * sin(pos.x * frequency.x + time * time_factor.x)) + (amplitude.y * sin(pos.y * frequency.y + time * time_factor.y));
//}
//
//void vertex() {
	//VERTEX.y += height(VERTEX.xz, TIME); // sample the height at the location of our vertex
	//TANGENT = normalize(vec3(0.0, height(VERTEX.xz + vec2(0.0, 0.2), TIME) - height(VERTEX.xz + vec2(0.0, -0.2), TIME), 0.4));
	//BINORMAL = normalize(vec3(0.4, height(VERTEX.xz + vec2(0.2, 0.0), TIME) - height(VERTEX.xz + vec2(-0.2, 0.0), TIME ), 0.0));
	//NORMAL = cross(TANGENT, BINORMAL);
//}
