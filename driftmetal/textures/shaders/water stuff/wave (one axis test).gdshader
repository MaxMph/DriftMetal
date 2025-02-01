shader_type spatial;
uniform vec4 amp = vec4(0.08, 0.06, 0.02, 0.04);
uniform vec4 freq = vec4(2.0, 2.5, 4.2, 3.1);
uniform vec4 time_factor = vec4(2.0, 3.0, 4.5, 4.8);

void fragment(){
	ALBEDO = vec3(0.1, 0.2, 0.4);
}

float height(vec2 pos, float time) {
	return (amp.x * sin(pos.x * freq.x + time * time_factor.x)) + (amp.z * sin(pos.x * freq.z + time * time_factor.z)) + (amp.y * sin(pos.x * freq.y + time * time_factor.y)) + (amp.w * sin(pos.x * freq.w + time * time_factor.w)) + (amp.x * sin(pos.y * freq.x + time * time_factor.x)) + (amp.z * sin(pos.y * freq.z + time * time_factor.z)) + (amp.y * sin(pos.x * freq.y + time * time_factor.y)) + (amp.w * sin(pos.y * freq.w + time * time_factor.w));
}

void vertex() {
	VERTEX.y += height(VERTEX.xz, TIME);
	TANGENT = normalize(vec3(0.0, height(VERTEX.xz + vec2(0.0, 0.2), TIME) - height(VERTEX.xz + vec2(0.0, -0.2), TIME), 0.4));
	BINORMAL = normalize(vec3(0.4, height(VERTEX.xz + vec2(0.2, 0.0), TIME) - height(VERTEX.xz + vec2(-0.2, 0.0), TIME ), 0.0));
	NORMAL = cross(TANGENT, BINORMAL);


}


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
