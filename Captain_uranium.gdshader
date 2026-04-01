shader_type canvas_item;


void vertex() {
	UV.y += TIME * .5;
	UV.x += TIME * -.5;
}
//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
