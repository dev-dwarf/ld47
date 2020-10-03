#region input
var move_x_axis, move_y_axis, input_direction, input_magnitude, attack_button, attack_button_charge, spell_button_released, spell_button_charge, dash_button_released, dash_button_charge;
var key_pause;

if (global.gamepad_connected) {
	move_x_axis = gamepad_axis_value(global.gamepad_slot, gp_axislh) 
	move_y_axis = gamepad_axis_value(global.gamepad_slot, gp_axislv) 

	attack_button = g_check_r(global.gamepad_slot, gp_face3) or g_check_r(global.gamepad_slot, gp_shoulderrb);
	attack_button_charge = g_check(global.gamepad_slot, gp_face3) or g_check(global.gamepad_slot, gp_shoulderrb);
	
	dash_button_released = g_check_p(global.gamepad_slot, gp_face1) or g_check_p(global.gamepad_slot, gp_shoulderlb);
	dash_button_charge = g_check(global.gamepad_slot, gp_face1) or g_check(global.gamepad_slot, gp_shoulderlb);
	//in_control_of_camera = true;
	
	key_pause = g_check_p(global.gamepad_slot, gp_start);
} else {
	move_x_axis = check(vk_d) - check(vk_a);
	move_y_axis = check(vk_s) - check(vk_w);
	
	attack_button = mouse_check_button_released(mb_left);
	attack_button_charge = mouse_check_button(mb_left);
	
	dash_button_released = mouse_check_button_pressed(mb_right);
	dash_button_charge   = mouse_check_button(mb_right);
	//in_control_of_camera = false;
	
	key_pause = check_p(vk_escape);
}

if (check_p(vk_up)) {
	global.sword_count++
	room_restart();	
}

var input_direction = point_direction(0, 0, move_x_axis, move_y_axis);
var input_magnitude = clamp(point_distance( 0, 0, move_x_axis, move_y_axis), 0, 1);

if (can_attack and attack_button) {
	oSword.swing = true;
	oSword.swing_amount = 0.0;
	oSword.swing_flip *= -1;
	
	// TODO: sword swing sound
}

if (dash_not_ready) dash_not_ready--;
if (dash_button_released and dash_not_ready == 0) {
	if (state == player_states.idle and !global.gamepad_connected) {
		move_direction = point_direction(x,y,mouse_x,mouse_y);	
	}
	
	dash_direction = move_direction;
	//log(dash_direction);
	
	state = player_states.dash;	
}
#endregion

#region state
switch state {
	case player_states.idle  : #region idle
	sprite_index = sPlayerIdle;
	
	can_attack = true;
	if (input_magnitude != 0) {
		state = player_states.walk;
		image_index = 0;	
	}
	
	move_speed = lerp(move_speed, 0, move_decel);
	
	break;#endregion
	case player_states.walk  : #region
		sprite_index = sPlayerWalk;

	can_attack = true;
	if (input_magnitude == 0) {
		state = player_states.idle;
		exit;
	}
	
	var dir = sign(dcos(move_direction))
	if (dir != 0)
		image_xscale = dir;
	
	move_speed = approach(move_speed, move_speed_max, move_accel);
	move_direction = angle_lerp(move_direction, input_direction, move_direction_speed);
	
	if (made_footstep) {
		if !(ceil(image_index) == 1 or ceil(image_index) == 5) {
			made_footstep = false;	
		}
	} else {
		if (ceil(image_index) == 1 or ceil(image_index) == 5) {
			made_footstep = true;
			// TODO: footstep sound
			
			make_dust(x,y,2,3);
		}
	}
	
	break; #endregion
	case player_states.dash: #region dash
	
	can_attack = false;
	
	dash_frame_count--;
	switch dash_state {
		case dash_states.start	 : 
		move_speed = approach(move_speed, 0, move_speed_max/dash_start_frames);
		
		draw_scale = 0.9;
		
		if (dash_frame_count == 0) {
			dash_state = dash_states.mid;	
			dash_frame_count = dash_frames;
		}
		break;
		case dash_states.mid	 :
		move_speed = dash_distance/dash_frames;
		
		make_dust(x,y,2, move_speed*0.3);
		
		draw_scale = lerp(draw_scale, 1.5, 0.2);

		if (dash_frame_count == 0) {
			dash_state = dash_states.recover;	
			dash_frame_count = dash_recovery_frames;
		}
		break;
		case dash_states.recover :
		move_speed = lerp(move_speed, move_speed_max*0.2, 0.7*(move_speed/dash_distance));
		
		draw_scale = approach(draw_scale, 1.0, 0.5/dash_recovery_frames);
		
		if (dash_frame_count == 0) {
			dash_state = dash_states.start;	
			state = player_states.idle;
			dash_not_ready = dash_recharge;
			dash_frame_count = dash_start_frames;
			move_speed *= 0.35;
		}
		break;
	}
	
	break; #endregion
	case player_states.freeze: #region freeze
	can_attack = false;
	
	break; #endregion
}
#endregion//log(string(state));

if (state != player_states.dash) {
	move(move_speed, move_direction);
} else {
	move(move_speed, dash_direction);
}