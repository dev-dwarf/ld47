mask_index = sPlayerIdle;

shield_angle = (shield_angle + 0.5) mod 360;

#region input
var move_x_axis, move_y_axis, input_direction, input_magnitude, attack_button, attack_button_charge, spell_button_released, spell_button_charge, dash_button_released, dash_button_charge;
var key_pause;

//if (check_p(vk_e)) {
//	var inst = instance_create_layer(x,y,layer,oPlayerLaser);
//	inst.image_angle = move_direction;
//}

if (global.gamepad_connected) {
	move_x_axis = gamepad_axis_value(global.gamepad_slot, gp_axislh) 
	move_y_axis = gamepad_axis_value(global.gamepad_slot, gp_axislv) 

	attack_button = g_check_p(global.gamepad_slot, gp_face3) or g_check_p(global.gamepad_slot, gp_shoulderrb);
	attack_button_charge = g_check(global.gamepad_slot, gp_face3) or g_check(global.gamepad_slot, gp_shoulderrb);
	
	dash_button_released = g_check_p(global.gamepad_slot, gp_face1) or g_check_p(global.gamepad_slot, gp_shoulderlb);
	dash_button_charge = g_check(global.gamepad_slot, gp_face1) or g_check(global.gamepad_slot, gp_shoulderlb);
	//in_control_of_camera = true;
	
	key_pause = g_check_p(global.gamepad_slot, gp_start);
} else {
	move_x_axis = check(vk_d) - check(vk_a);
	move_y_axis = check(vk_s) - check(vk_w);
	
	attack_button = mouse_check_button_pressed(mb_left);
	attack_button_charge = mouse_check_button(mb_left);
	
	if (attack_button_charge and !attack_button) {
		auto_click--;
		if (auto_click == 0) {
			attack_button = true;
			auto_click = auto_click_delay;
		}
	} else {
		auto_click = auto_click_delay;
	}
	
	dash_button_released = mouse_check_button_pressed(mb_right);
	dash_button_charge   = mouse_check_button(mb_right);
	//in_control_of_camera = false;
	
	key_pause = check_p(vk_escape);
}

var input_direction = point_direction(0, 0, move_x_axis, move_y_axis);
var input_magnitude = clamp(point_distance( 0, 0, move_x_axis, move_y_axis), 0, 1);

if player_active
{
	if (can_attack and attack_button) {
		if (instance_exists(oSword)) {
			oSword.swing = true;
			oSword.swing_amount = 0.2;
			oSword.swing_flip *= -1;
		}
	
		if (hits_this_time > 0) {
			consecutive_sword_hits++;
			hits_this_time = 0;
		} else {
			consecutive_sword_hits = 0;
		}
	
	if (has_laser and laser_available == 1.0) {
		laser_available = 0.0;
		oCamera.set_shake(0.25);
		var dir = point_direction(x,y,mouse_x,mouse_y) + irandom_range(-5, 5);
		var inst = instance_create_layer(x,
										 y-sprite_height/2,
										layer,oPlayerLaser);
		inst.image_angle = dir;
		play_sound(sndLaser, 0, false, 1.2, 0.04, 1.0);
	}
	
	play_sound(sndSwingMiss, 0, false, 0.8, 0.02, 1.0);
}

laser_available = approach(laser_available, 1.0, laser_regen_speed);

if (!oSword.swing) consecutive_sword_hits = lerp(consecutive_sword_hits, 0, 0.04);

	if (dash_not_ready) dash_not_ready--;
	if (can_attack and dash_button_released and dash_not_ready == 0) {	
		if (!global.gamepad_connected) {
			move_direction = point_direction(x,y,mouse_x,mouse_y);	
			
			//dash i frames
			var _dash_i = 10;
			//if player has teleport, give them a little more i frames
			with oCardHolder
				if counts[card.good][good_cards.teleport_dash] > 0
					_dash_i = 15;
			
			//set i frames
			i_frames = clamp(i_frames + _dash_i, 0, _dash_i);
		}
	
		dash_direction = move_direction;
		dash_start_x = x;
		dash_start_y = y;
	
		play_sound(sndDashStrike, 0, false, 2.0, 0.02, 1.0);
		play_sound(sndDashStrike, 0, false, 1.0, 0.02, 0.7);
	
		state = player_states.dash;	
	}
} else state = player_states.idle;

#endregion

if (!has_shield) {
	shield_radius = lerp(shield_radius, 0, 0.1);	
	shield_regen = approach(shield_regen, 1.0, shield_regen_speed);
	
	if (shield_regen == 1.0) {
		has_shield = true;
		shield_regen = false;
	}
} else {
	shield_radius = lerp(shield_radius, 24, 0.5);	
}

mask_index = sPlayerIdle

hp = approach(hp, max_hp, heal_overtime);

if (heal_overtime > 0) {
	if (chance(10)) {
		var inst = instance_create_layer(x+random_range(-8,8),y-8+random_range(-8,8),layer,oHealParticle);	
		inst.image_xscale *= 0.3; inst.image_yscale *= 0.3;

	}
}

hp = clamp(hp, 0, max_hp)

if (hp == 0 and state != player_states.death) {
	state = player_states.death;	
}
//log(string(hp));

if (check_p(vk_r)) {
	game_restart();
}

#region state
switch state {
	
	case player_states.victory:
	{
		sprite_index = sPlayerIdle;
		can_attack = false;
		move_speed = 0;
		speed = 0;
		direction = 0;
	}
	break;
	
	case player_states.idle: #region idle
	sprite_index = sPlayerIdle;
	
	can_attack = true;
	if (input_magnitude != 0) {
		state = player_states.walk;
		image_index = 0;	
	}
	
	if (!global.gamepad_connected) {
		move_direction = point_direction(x,y,mouse_x,mouse_y);	
	}
	
	move_speed = lerp(move_speed, 0, move_decel);
	
	if (made_eyeflap) {
		if !(ceil(image_index) == 7 or ceil(image_index) == 15 or ceil(image_index) == 17) {
			made_eyeflap = false;	
		}
	} else {
		if (ceil(image_index) == 7 or ceil(image_index) == 15 or ceil(image_index) == 17) {
			made_eyeflap = true;
			play_sound(sndEyeFlap, 10, false, 1.7, 0.05, 0.15);
			
		}
	}
	
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
			play_sound(sndFootstep, 10, false, 1.3, 0.01, 0.4);
			
			make_dust(x,y,2,3);
		}
	}
	
	break; #endregion
	case player_states.dash: #region dash
	
	can_attack = false;
	dash_frame_count--;
	
	if (dash_is_teleport) {
		switch dash_state {
			case dash_states.start	 : 
			move_speed = 0;
		
			draw_scale = 0.8;
		
			if (dash_frame_count == 0) {
				oCamera.set_shake( 0.1);
				dash_state = dash_states.mid;	
				dash_frame_count = dash_frames;
				
				with instance_create_layer(	x, y, "FX", oPlayerTeleportSpot) {
					mask_index = other.mask_index;
					move(other.dash_distance, other.dash_direction, false);	
				}
										
					
			}
			break;
			case dash_states.mid	 :
			image_xscale = 0;
			image_yscale = 0;
			draw_scale = 0;
			i_frames = 1;

			oPlayerTeleportSpot.image_speed = 0;
			oPlayerTeleportSpot.image_index = 3*(1.0-dash_frame_count/dash_frames);
			
			if (dash_frame_count == 0) {
				dash_state = dash_states.recover;	
				dash_frame_count = dash_recovery_frames;
				
				hurt_line(x, y, oPlayerTeleportSpot.x, oPlayerTeleportSpot.y);
				
				image_xscale = 1;
				image_yscale = 1;
				move(dash_distance, dash_direction, false);	
				instance_destroy(oPlayerTeleportSpot);
			}
			break;
			case dash_states.recover :
			var dir = sign(dcos(move_direction))
			if (dir != 0) {
				image_xscale = dir;
			} else {
				image_xscale = 1;	
			}
			image_yscale = 1.0;
			draw_scale = 1.0;
			
			make_dust(x,y,2, move_speed*0.3);
			
			move_speed = lerp(move_speed, move_speed_max*0.2, 0.7*(move_speed/dash_distance));	
		
			if (dash_frame_count == 0) {
				dash_state = dash_states.start;	
				state = player_states.idle;
				dash_not_ready = dash_recharge;
				dash_frame_count = dash_start_frames;
				move_speed *= 0.35;
			}
			break;
		}
	} else {
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
			i_frames = 7;
			make_dust(x,y,2, move_speed*0.3);
		
			draw_scale = lerp(draw_scale, 1.5, 0.2);

			if (dash_frame_count == 0) {
				dash_state = dash_states.recover;	
				dash_frame_count = dash_recovery_frames;
				
				//hurt_line(x,y,dash_start_x,dash_start_y);
			}
			break;
			case dash_states.recover :
			move_speed = lerp(move_speed, move_speed_max*0.2, 0.85);
		
			draw_scale = approach(draw_scale, 1.0, 0.5/dash_recovery_frames);
			
			make_dust(x,y,2, move_speed*0.3);
		
			if (dash_frame_count == 0) {
				dash_state = dash_states.start;	
				state = player_states.idle;
				dash_not_ready = dash_recharge;
				dash_frame_count = dash_start_frames;
				move_speed *= 0.35;
			}
			break;
		}
	}
	
	break; #endregion
	case player_states.freeze: #region freeze
	can_attack = false;
	move_speed = 0;
	
	break; #endregion
	case player_states.death: #region
	can_attack = false;
	move_speed = lerp(move_speed, 0, 0.5);
	
	image_blend = global.that_one_purple;

	break; #endregion
}
#endregion

if (state != player_states.dash) {
	move(move_speed, move_direction);
} else {
	move(move_speed, dash_direction);
}

move(knockback,knockback_dir);
knockback = lerp(knockback, 0, 0.9);
