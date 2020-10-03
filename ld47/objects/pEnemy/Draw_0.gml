/// @description
if (round(i_frames/3) mod 2) {
	shader_set(shFlash);
	draw_self();
	shader_reset();
} else {
	draw_self();
}