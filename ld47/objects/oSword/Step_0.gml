/// @description

if (swing) {
	swing_amount = lerp(swing_amount, 1.0, 0.9);
	offset_boost = lerp(offset_boost, 5, 0.8);
	
	image_xscale = oPlayer.image_xscale * (oPlayer.sword_size + swing_scale * swing_amount);
	image_yscale = oPlayer.image_yscale * (oPlayer.sword_size + swing_scale * swing_amount);

	
	if (swing_amount > .99) {
		swing = false;
	}
} else {
	offset_boost = lerp(offset_boost, 0, 0.2);	
	
	image_xscale = lerp(image_xscale, oPlayer.image_xscale, 0.3);
	image_yscale = lerp(image_yscale, oPlayer.image_yscale, 0.3);
}


var off = 0;
if (oPlayer.image_xscale == -1) {
	off = 180;
}

offset_angle = offset_angle mod 360;
if (offset_angle == 90) {
	cos_offset_angle = 1;
} else if (offset_angle == 270) {
	cos_offset_angle = -1;
} else {
	cos_offset_angle = sign(dcos(offset_angle));
}

x = lerp(x, oPlayer.x + lengthdir_x(offset_amount+offset_boost, offset_angle), 0.8);
y = lerp(y, oPlayer.y + lengthdir_y(offset_amount+offset_boost, offset_angle), 0.8);

var target_angle; var targ_offset;
targ_offset = 360 * number/instance_number(oSword)  + off;

if (oPlayer.state == player_states.dash or oPlayer.dash_not_ready) {
	target_angle = oPlayer.dash_direction - 90;
	image_xscale = oPlayer.image_xscale*1.2;
	image_yscale = oPlayer.image_yscale*1.2;
	
	offset_amount = lerp(offset_amount, offset_far, 0.8);
	
	var p = 0.93;
	targ_offset  = oPlayer.dash_direction*p + targ_offset*(1-p)
} else {
	offset_amount = lerp(offset_amount, offset_close, 0.2);
	target_angle = -cos_offset_angle*swing_angle*swing_flip*swing_amount - 67 * cos_offset_angle
}

offset_angle = round(angle_lerp(offset_angle, targ_offset, 0.75));
angle = angle_lerp(angle, target_angle, 0.9);
