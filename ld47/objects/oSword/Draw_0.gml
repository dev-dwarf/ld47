/// @description

var y_off = 8;

if (oPlayer.state == player_states.walk) {
	if (number mod 2) {
		y_off += round(1 * dcos((oPlayer.image_index) * 90));		
	} else {
		y_off += round(1 * dsin((oPlayer.image_index) * 90));
	}
}


draw_sprite_ext(sprite_index, image_index, 
x, y - y_off,
abs(image_xscale), image_yscale, 
angle, 
c_white, image_alpha
);
