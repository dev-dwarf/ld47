/// @description

var y_off = 3;

if (oPlayer.state == player_states.walk) {
	if (number mod 2) {
		y_off += round(1 * dcos((oPlayer.image_index) * 90));		
	} else {
		y_off += round(1 * dsin((oPlayer.image_index) * 90));
	}
}

var sprite = sprite_index;

if (oPlayer.i_frames > 1 and round(oPlayer.i_frames/3) mod 3) or i_frames > 0 {
	sprite = sSwordWhite;
}


draw_sprite_ext(sprite, image_index, 
x, y - y_off,
abs(image_xscale), image_yscale, 
angle, 
image_blend, image_alpha
);
