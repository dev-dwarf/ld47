/// @description

var temp_yscale = image_yscale;

image_yscale = 1.0;

draw_self();

image_yscale = temp_yscale;

draw_sprite_ext(sPlayerLaserEnd, image_index, x + lengthdir_x(sprite_width, image_angle), y + lengthdir_y(sprite_width, image_angle), 1.0, 1.0, image_angle, image_blend, image_alpha);