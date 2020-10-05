/// @description
i_frames = 0;

image_yscale = lerp(image_yscale, 1.0, 0.5);

if (!set_xscale) {
	var inst = noone;
	while (!(inst and inst != first_solid) and image_xscale < 800) {
		inst = instance_place(x,y,pSolid);
		
		if (first_solid == noone and inst != noone) first_solid = inst;
		image_xscale++;	
		
	}
}

life--;
if (life <= 0) {
	image_alpha = approach(image_alpha, 0, 0.25);
	if (image_alpha == 0) instance_destroy();
}

