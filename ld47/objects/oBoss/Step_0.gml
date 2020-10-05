/// @description
if (oPlayer.state == player_states.death) {
	image_blend = global.that_one_purple;
	exit;
}

if state != enemy_states.dead and (place_meeting(x,y,oPlayer) and oPlayer.i_frames <= 0 and oPlayer.dash_state != dash_states.mid) {
	
	hit_player();
}


switch state {
	case boss_states.spawn	: #region 
	spawn_timer--;
	
	draw_scale = lerp(draw_scale, 1.0, 0.1);	
	
	if (spawn_timer <= 0) {
		state = boss_states.charger;
	}
	break; #endregion
	case boss_states.charger: #region 
	
	switch sub_state {
		case boss_sub_states.target	: #region 
		charge_timer--;
		
		if (charge_timer <= 0) {
			charge_timer = charge_time;
			sub_state = boss_sub_states.attack;
			move_direction = shoot_direction;
		}
	
		if (charge_timer < 20) {
			draw_scale = lerp(draw_scale, 1.0, 0.2);
			shoot_direction = angle_lerp(shoot_direction, point_direction(x,y,oPlayer.x,oPlayer.y), 0.5);
		} else if (charge_timer < charge_time*0.75) {
			shoot_direction = angle_lerp(shoot_direction, 0, 0.3);
		
		} else {
			draw_scale = lerp(draw_scale, 0.8, 0.2);
		}		
		break; #endregion
		case boss_sub_states.attack	: #region 
		move_speed = approach(move_speed, charge_speed, 1);
		move(charge_speed, move_direction);
	
		oPlayer.make_dust(x,y,2, charge_speed*0.3);
	
		var x_near = x + lengthdir_x(3,move_direction);
		var y_near = y + lengthdir_y(3,move_direction);
		if (place_meeting(x_near,y_near,pSolid) or place_meeting(x,y,oPlayer) or (x == xprevious and y == yprevious)) {
			sub_state = boss_sub_states.recover;
		}
		break; #endregion
		case boss_sub_states.recover: #region 
		move_speed = approach(move_speed, 0, 2);
		move(move_speed, move_direction);
	
		oPlayer.make_dust(x,y,2, move_speed*0.7);
	
		if (move_speed == 0) {
			sub_state = boss_sub_states.target;	
			
			charges--;
			
			if (charges == 0) {
				state = boss_states.avoid;
				charges = avoid_count;
			}
		}
		break; #endregion
	}
	
	break; #endregion
	case boss_states.avoid	: #region 
	switch sub_state {
		case boss_sub_states.target	: #region 
		move_direction = angle_lerp(move_direction, point_direction(oPlayer.x,oPlayer.y,x,y), 0.4);
	
		if (distance_to_object(oPlayer) < avoid_range) {
			move_speed = approach(move_speed, avoid_speed, 0.1);	
			move(move_speed, move_direction);
		} else {
			move_speed = approach(move_speed, 0, 0.4);	
			move(move_speed, move_direction);
		}
		oPlayer.make_dust(x,y,1, move_speed*0.3);
	
		avoid_shoot_timer--;
		if (avoid_shoot_timer <= 0) {
			avoid_shoot_timer = avoid_shoot_time;
			draw_scale = 0.8;
		
			var dir = point_direction(x,y,oPlayer.x, oPlayer.y) - avoid_spread/2;
			var r = sprite_width;
			for (var i = 0; i < avoid_pellets; i++) {
				var d = dir+i*avoid_spread/avoid_pellets+random_range(-5,5);
				with instance_create_layer( x + lengthdir_x(r, d),
											y - sprite_height/2 + lengthdir_y(r, d),
											layer, oShotgunShitleyProjectile) 
				{			
					parent = other.id;
					final_speed = 7;
					direction = d;					
				}
			}
		}
		break; #endregion
		case boss_sub_states.attack	: #region 
	
		break; #endregion
		case boss_sub_states.recover: #region 

		break; #endregion
	}
	break; #endregion
	case boss_states.burst	: #region 
	
	break; #endregion
	case boss_states.dead	: #region 
	
	break; #endregion
}