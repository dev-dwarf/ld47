/// @description
if (oPlayer.state == player_states.death) {
	image_blend = global.that_one_purple;
	exit;
}

var inst = instance_place(x,y,oSword);
if (inst and ((inst.swing) or (oPlayer.state == player_states.dash or oPlayer.dash_not_ready)) and i_frames <= 0) and state != enemy_states.dead {
	oPlayer.hits_this_time++;
	play_sound(sndSwordHit, 0, false, 1.0 + 0.075 * oPlayer.consecutive_sword_hits, 0.02, 1.0);
	
	var yy = irandom_range(sprite_height/2,-sprite_height/2);
	var xx = irandom_range(sprite_width/2,-sprite_width/2);
	
	with instance_create_layer(x+xx,y+yy,-1000,oObjPari){ image_angle = irandom_range(0,360); sprite_index = sHit;}
	
	hp -= oPlayer.hit_damage;
	
	i_frames = 10;
	inst.i_frames = 10;
	oCamera.set_shake( 0.2);
		
	if oPlayer.leach > 0 {
		oPlayer.hp += oPlayer.leach*oPlayer.hit_damage;	
		repeat(irandom(3)+2)
				instance_create_layer(x+random_range(-8,8),y+random_range(-8,8),layer,oHealParticle);
	}
	
	if hp <= 0 {
		state = boss_states.dead;	
	}

}

switch state {
	case boss_states.spawn	: #region 
//	image_blend = global.that_one_purple;
	image_speed = 1;
	sprite_index = sPlayerIdle;	
	if state != enemy_states.dead and (place_meeting(x,y,oPlayer) and oPlayer.i_frames <= 0 and oPlayer.dash_state != dash_states.mid) {
	
		hit_player();
	}

	spawn_timer--;
	
	draw_scale = lerp(draw_scale, 1.0, 0.1);	
	
	if (spawn_timer <= 0) {
		state = boss_states.transform;
		next_state = boss_states.charger;
	}
	break; #endregion
	case boss_states.charger: #region 
	image_index = 1;
	image_speed = 0;
	image_angle = shoot_direction;
	image_blend = c_white;
	
	if state != enemy_states.dead and (place_meeting(x,y,oPlayer) and oPlayer.i_frames <= 0 and oPlayer.dash_state != dash_states.mid) {
	
		hit_player();
	}

	
	switch sub_state {
		case boss_sub_states.target	: #region 
		charge_timer--;
		
		if (charge_timer <= 0) {			
			if (charges == 0) {
				charge_timer = charge_time;
				sub_state = boss_sub_states.target;	
				
				next_state = boss_states.avoid;
				state = boss_states.transform;
				
				charges = avoid_count;
				avoid_gone_to_center = false;
			} else {
				charge_timer = charge_time;
				sub_state = boss_sub_states.attack;
				move_direction = shoot_direction;
				play_sound(sndCharger, 0, false, 1.0, 0.04, 1.0);
			}
		}
	
		if (charge_timer < 20) {
			draw_scale = lerp(draw_scale, 1.0, 0.2);
			shoot_direction = angle_lerp(shoot_direction, point_direction(x,y,oPlayer.x,oPlayer.y), 0.5);
		} else if (charge_timer < charge_time*0.75) {
			shoot_direction = angle_lerp(shoot_direction, new_dir, 0.3);
		
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
			new_dir = choose(0, 180);
		}
		break; #endregion
		case boss_sub_states.recover: #region 
		move_speed = approach(move_speed, 0, 2);
		move(move_speed, move_direction);
	
		oPlayer.make_dust(x,y,2, move_speed*0.7);
	
		if (move_speed == 0) {
			sub_state = boss_sub_states.target;	
			charges--;
			
		}
		break; #endregion
	}
	
	break; #endregion
	case boss_states.avoid	: #region 
	image_index = 3;
	image_angle = angle_lerp(image_angle, 0, 0.1);
	image_speed = 0;
	image_blend = c_white;
	
	var p_dir = point_direction(x,y,oPlayer.x, oPlayer.y);

	switch ceil((p_dir-1)/90) {
		case 1:
		image_index = 4;
		draw_flip = 1;
		break;
		case 0: case 4:
		image_index = 3;
		draw_flip = 1;
		break;
		case 2: 
		image_index = 3;
		draw_flip = -1;
		break;
		case 3: 
		image_index = 3;
		draw_flip = -1;
		break;
	}

	switch sub_state {
		case boss_sub_states.target	: #region 
		if (distance_to_object(oPlayer) < avoid_range) {
			move_direction = angle_lerp(move_direction, point_direction(oPlayer.x,oPlayer.y,x,y), 0.4);
		} else {
			move_direction = angle_lerp(move_direction, point_direction(x,y,oPlayer.x,oPlayer.y), 0.4);
		}
		
		if (abs(distance_to_object(oPlayer) - avoid_range) > 10) {
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
			charges--;
			draw_scale = 0.8;
			play_sound(sndShotgun, 0, false, 1.0, 0.09, 1.0);	
			var dir = point_direction(x,y,oPlayer.x, oPlayer.y) - avoid_spread/2;
			var r = sprite_width;
			for (var i = 0; i < avoid_pellets; i++) {
				var d = dir+i*avoid_spread/avoid_pellets+random_range(-5,5);
				with instance_create_layer( x + lengthdir_x(r, d),
											y + lengthdir_y(r, d),
											layer, oShotgunShitleyProjectile) 
				{			
					parent = other.id;
					final_speed = 7;
					direction = d;					
				}
			}
			
			if (charges <= 0) {
				sub_state = boss_sub_states.target;	
				next_state = boss_states.burst;
				state = boss_states.transform;
				

				charges = burst_shoot_count;
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
	image_index = 0;
	image_angle = angle_lerp(image_angle, 0, 0.1)
	image_speed = 0;
	image_blend = c_white;


	switch sub_state {
		case boss_sub_states.target	: #region 
		burst_shoot_timer--;
	
		var r = 3*burst_shoot_timer/burst_shoot_time
		draw_x = random_range(r,-r)
		draw_y = random_range(r,-r)	
	
		if (burst_shoot_timer <= 0) {
			burst_shoot_timer = burst_shoot_time;
			sub_state = boss_sub_states.attack;
		}
	
		draw_scale = lerp(draw_scale, 1.0, 0.2);
		break; #endregion
		case boss_sub_states.attack	: #region 
		image_angle = 90;
		var dir = point_direction(x,y,oPlayer.x,oPlayer.y);
		for (var i = 0; i < 360; i += 360/projectile_number) {
			with instance_create_layer(x + lengthdir_x(sprite_width/2, i+dir),
									y + lengthdir_y(sprite_width/2, i+dir)
			,layer,oBurstingBrianProjectile) {
				direction = i+dir;	
				parent = other.id;
			}
		}
		
		burst_shoot_timer = burst_shoot_time;
		sub_state = boss_sub_states.target;
		charges--;
		
		play_sound(sndBurstingBrian, 0, false, 0.8, 0.09, 1.0);
			
		if (charges <= 0) {
			sub_state = boss_sub_states.recover;	
			after_burst_recovery_timer = after_burst_recovery_time;
		}
			
		break; #endregion
		case boss_sub_states.recover: #region 
		after_burst_recovery_timer--;
		if(after_burst_recovery_timer <= 0) {
			sub_state = boss_sub_states.target;	
			next_state = boss_states.charger;
			state = boss_states.transform;
			charges = charge_count;
		}
		break; #endregion
		
	}
	break; #endregion
	case boss_states.dead	: #region 
	image_blend = global.that_one_purple;
	sprite_index = sPlayerIdle;	
	image_angle = 0;
	draw_scale = 1;
	break; #endregion
	case boss_states.transform: #region
	if (place_meeting(x,y,oPlayer) and oPlayer.i_frames <= 0 and oPlayer.dash_state != dash_states.mid) {
		hit_player();
	}
	sprite_index = sBoss;	
	image_blend = global.that_one_purple;
	image_speed = 1;
	image_angle = angle_lerp(image_angle, 0, 0.2);
	
	draw_scale = 0.5;
	draw_flip = 1;
	
	
	x = lerp(x,room_width /2,0.11);
	y = lerp(y,room_height/2,0.11);
		
	if (point_distance(x,y,room_width/2,room_height/2) < 1 and transition_timer-- <= 0) {
		state = next_state;
		transition_timer = min_transition_time;

		sprite_index = sBoss;	
		image_speed = 0;
	} 
	break; #endregion
}

	draw_scale = lerp(draw_scale, 1.0, 0.1);
