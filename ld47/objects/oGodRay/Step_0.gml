/// @description
image_angle = angle_start + sin(2*pi*current_time * 0.0001/image_xscale + offset);
image_alpha = 0.1 + 0.1 *	sin(2*pi*current_time * 0.0002/image_xscale + offset);

if (image_alpha < 0.01) {
	if (set_new_pos == false) {
		set_new_pos = true;
		x = xstart + random_range(-range, range)
		y = ystart + random_range(-range, range)
	}
} else {
	set_new_pos = false;	
}