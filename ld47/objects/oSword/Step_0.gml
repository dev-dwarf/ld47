/// @description

if (oPlayer.state == player_states.death) {
	image_blend = global.that_one_purple;
	exit;
}

if (oPlayer.state == player_states.freeze) {
	sprite_index = sSwordPurple;
	exit;
}

mask_index = sSwordOrange;
if (swing) {
	sprite_index = sSwordPurple;
	swing_amount = lerp(swing_amount, 1.0, 0.9);
	offset_boost = 7;
	
	image_xscale =    (oPlayer.image_xscale) * (oPlayer.sword_size + swing_scale * swing_amount);
	image_yscale =     oPlayer.image_yscale  * (oPlayer.sword_size + swing_scale * swing_amount);
	
	var xx = x + lengthdir_y(sprite_height*0.75, angle);
	var yy = y - lengthdir_x(sprite_height*0.75, angle);
	
	if (!global.gamepad_connected) {
		var dir = point_direction(oPlayer.x,oPlayer.y,mouse_x,mouse_y);
	} else {
		var dir = oPlayer.move_direction;		
	}
	
	with instance_create_depth(x,y,-1000,oObjPari){ sprite_index = sSwordSlash; image_angle = dir; lock = true; parent = oPlayer.id} 
	//part_type_direction(oPlayer.sword_dust, dir, dir, 0, 5);
	//part_particles_create(oPlayer.dust, xx, yy, oPlayer.sword_dust, 1)
	
	if (swing_amount > .99) {
		swing = false;
	}
} else {
	sprite_index = sSwordOrange;
	offset_boost = lerp(offset_boost, 0, 0.2);	
	
	image_xscale =    (oPlayer.image_xscale)  * (oPlayer.sword_size)
	image_yscale =     oPlayer.image_yscale   * (oPlayer.sword_size)
}


var off = 0;
//if (oPlayer.image_xscale == -1) {
//	off = 180;
//}
if (i_frames) i_frames--;

offset_angle = offset_angle mod 360;
//if (offset_angle == 90) {
//	cos_offset_angle = 1;
//} else if (offset_angle == 270) {
//	cos_offset_angle = -1;
//} else {
//	cos_offset_angle = sign(dcos(offset_angle));
//}
cos_offset_angle = dcos(offset_angle);

x = lerp(x, oPlayer.x + lengthdir_x(offset_amount+offset_boost, offset_angle), 0.8);
y = lerp(y, oPlayer.y - 4 + lengthdir_y(offset_amount+offset_boost, offset_angle)*0.5, 0.8);

var target_angle; var targ_offset;
targ_offset = 360 * number/instance_number(oSword)  + off;

if (oPlayer.state == player_states.dash or oPlayer.dash_not_ready) {
	sprite_index = sSwordPurple;

	target_angle = oPlayer.dash_direction - 90;
	image_xscale =    (oPlayer.image_xscale) * (oPlayer.sword_size*1.2);
	image_yscale =     oPlayer.image_yscale  * (oPlayer.sword_size*1.2);
	
	offset_amount = lerp(offset_amount, offset_far, 0.8);
	
	var p = 0.93;
	targ_offset  = oPlayer.dash_direction*p + targ_offset*(1-p)
} else if oPlayer.player_active {	
	offset_amount = lerp(offset_amount, offset_close, 0.2);
	
	if (!global.gamepad_connected) {
		target_angle = point_direction(oPlayer.x,oPlayer.y,mouse_x,mouse_y)- 90 + swing_angle*swing_flip*swing_amount;
		targ_offset += point_direction(oPlayer.x,oPlayer.y,mouse_x,mouse_y)
	} else {
		target_angle = oPlayer.move_direction- 90 + swing_angle*swing_flip*swing_amount;
		targ_offset += oPlayer.move_direction
	}
}
else target_angle = -45;

offset_angle = round(angle_lerp(offset_angle, targ_offset, 0.75));
angle = angle_lerp(angle, target_angle, 0.9);

image_angle = angle;
