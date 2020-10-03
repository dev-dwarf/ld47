/// @description

var blend = image_blend;
if (state == player_states.dash or dash_not_ready) blend = c_red;

draw_sprite_ext(sprite_index, image_index, x, y, draw_scale*image_xscale, draw_scale*image_yscale, image_angle, blend, image_alpha);
