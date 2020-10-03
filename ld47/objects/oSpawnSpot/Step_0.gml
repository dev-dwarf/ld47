/// @description
if (create and !destroy) {
	instance_create_layer(x,y,layer,object_to_spawn);
	destroy = true;
}

if (destroy) {
	image_xscale = approach(image_xscale, 0, 0.1);	
	image_yscale = approach(image_yscale, 0, 0.1);	
	
	if (image_xscale == 0) instance_destroy();
}