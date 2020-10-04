/// @description
i_frames = 0;

image_yscale = lerp(image_yscale, 1.0, 0.5);

if (!set_xscale) {
	while (!place_meeting(x,y,pSolid) and image_xscale < 800) {
		image_xscale++;	
	}
}

life--;
if (life <= 0) {
	image_alpha = approach(image_alpha, 0, 0.25);
	if (image_alpha == 0) instance_destroy();
}