shader_type canvas_item;

uniform float speed = .3;

void vertex() {
	UV.y += TIME * speed;
	UV.x += TIME * speed;
}
