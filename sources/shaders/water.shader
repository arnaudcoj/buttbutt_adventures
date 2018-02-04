shader_type canvas_item;
render_mode skip_vertex_transform;

void vertex() {
	VERTEX = (EXTRA_MATRIX * (WORLD_MATRIX * vec4(VERTEX, 0.0, 1.0))).xy;
	VERTEX.y += sin(TIME) * 10.0 - 10.0;
	VERTEX.x += sin(TIME * 2.0) * 2.0;
}