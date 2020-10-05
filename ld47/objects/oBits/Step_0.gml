/// @description
speed = lerp(speed, 0, 0.2);

if (z_dir == 1) {
	z = approach(z, 0, z_speed);
	z_speed*=0.5;
} else {
	z = approach(z, z_speed*3, z_speed);	
}

image_angle += z_speed;