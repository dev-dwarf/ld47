/// @description

if (flash-- > 0) {
	draw_sprite_ext(sExplosion, flash, x, y-z, image_xscale/2, image_yscale/2, image_angle, image_blend, 0.8);
}

draw_sprite_ext(sprite_index, image_index, x, y-z, image_xscale, image_yscale, image_angle, image_blend, 0.8);
draw_sprite_ext(sprite_index, image_index, x, y-z, image_xscale, image_yscale, image_angle, C_black, 0.5);