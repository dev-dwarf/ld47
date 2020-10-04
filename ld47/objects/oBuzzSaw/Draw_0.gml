/// @description
for (var i = 0; i < image_number; i++) {
	draw_sprite_ext(sprite_index, i, x, y-i*0.5,image_xscale, image_yscale, image_angle, image_blend, image_alpha);	
}