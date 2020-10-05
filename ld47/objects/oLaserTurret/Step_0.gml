/// @description

if (instance_exists(oExitPortal) or (instance_exists(oPlayer) and oPlayer.state == player_states.death)) {
	image_blend = global.that_one_purple;
	image_speed = 0;
	exit;	
}


shoot_timer--;

image_xscale = lerp(image_xscale, 1.0 + 0.1 * image_index/5, 0.2);
image_yscale = lerp(image_yscale, 1.0 + 0.1 * image_index/5, 0.2);

if (!instance_exists(oPlayer)) exit;

x = lerp(x, xstart + (oPlayer.x-oPlayer.xstart)*parralax_percent, 0.2);
y = lerp(y, ystart + (oPlayer.y-oPlayer.ystart)*parralax_percent, 0.2);


if (shoot_timer <= 0) {
	image_speed = 1;

	if (ceil(image_index) == image_number-9 and !instance_exists(preview)) {
		preview =
		instance_create_layer(x + lengthdir_x(sprite_width*0.5, image_angle),
							  y + lengthdir_y(sprite_width*0.5, image_angle),	
							  layer, oTurretLaserPreview);
							  
		preview.image_angle = image_angle;
	} else 
	if (ceil(image_index) == image_number) {
		shoot_timer = shoot_cooldown;
		
		laser =
		instance_create_layer(x + lengthdir_x(sprite_width*0.5, image_angle),
							  y + lengthdir_y(sprite_width*0.5, image_angle),	
							  layer, oTurretLaser);
							  
		laser.image_angle = image_angle;
		
		image_xscale = 1.25;
		image_yscale = 0.75;
	} 
} else {
	image_speed = 0;
	image_index = 0;
	
	if (!instance_exists(laser)) {
		angle_speed = approach(angle_speed, 0.2, 0.03);
		image_angle = angle_lerp(image_angle, point_direction(x,y,oPlayer.x,oPlayer.y-oPlayer.sprite_height/2), angle_speed);
	} else {
		x += random_range(-2,2)
		y += random_range(-2,2)
	}
}