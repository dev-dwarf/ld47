/// @description
draw_self();

for (var i = 0; i < 4; i++) {
	draw_sprite_ext(sLightning, image_index, x, y - sprite_height/2, 1.0, 1.0, angle + i * 90, c_white, 1.0);
}
