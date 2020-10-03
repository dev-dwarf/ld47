/// @description

var y_off = 8;

if (oPlayer.state == player_states.walk) {
	y_off += 4 * (oPlayer.image_index mod 4 - 2)/2;
}


draw_sprite_ext(sprite_index, image_index, 
x, y - y_off,
image_xscale, image_yscale, 
angle, 
c_white, image_alpha
);
