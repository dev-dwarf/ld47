/// @description
if (round(i_frames/3) mod 2) and state != enemy_states.dead {
	shader_set(shFlash);
	draw_self();
	shader_reset();
} else {
	draw_self();
}