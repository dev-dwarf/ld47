
// Inherit the parent event
event_inherited();

if (oPlayer.state == player_states.death) {
	image_blend = global.that_one_purple;
	exit;
}

//log(string(state));

switch state {
	case enemy_states.idle 	 : #region
	idle_timer--;
	
	
	
	if (idle_timer <= 0) {
		idle_timer = idle_time;
		state = enemy_states.attack;
		attack_direction = image_angle;
	}
	
	if (idle_timer < 20) {
		draw_scale = lerp(draw_scale, 1.0, 0.2);
		image_angle = angle_lerp(image_angle, point_direction(x,y,oPlayer.x,oPlayer.y), 0.3);
	} else if (idle_timer < idle_time*0.75) {
		image_angle = angle_lerp(image_angle, new_dir, 0.3);
		
	} else {
		draw_scale = lerp(draw_scale, 0.8, 0.2);
	}
	
	break; #endregion
	case enemy_states.attack : #region
	
	attack_speed = approach(attack_speed, dash_speed, 1);
	move(attack_speed, attack_direction);
	
	oPlayer.make_dust(x,y,2, attack_speed*0.3);
	
	var x_near = x + lengthdir_x(3,attack_direction);
	var y_near = y + lengthdir_y(3,attack_direction);
	if (place_meeting(x,y,oPlayer) or place_meeting(x_near,y_near,pSolid) or (x == xprevious and y ==yprevious)) {
		state = enemy_states.recover;
		new_dir = choose(0, 180);
	}

	break; #endregion
	case enemy_states.recover: 
	attack_speed = approach(attack_speed, 0, 6);
	move(attack_speed, attack_direction);
	
	oPlayer.make_dust(x,y,2, attack_speed*0.7);
	
	if (attack_speed == 0) {
		state = enemy_states.idle;	
	}
	
	break;
	case enemy_states.hit	 :
	
	break;
	case enemy_states.dead	 : 
	image_blend = global.that_one_purple;
	draw_scale = lerp(draw_scale, 0.5, 0.2);
	
	break;
}