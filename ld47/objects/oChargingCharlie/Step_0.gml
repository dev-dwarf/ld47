
// Inherit the parent event
event_inherited();

if (oPlayer.state == player_states.death) {
	image_blend = c_gray;
	exit;
}

//log(string(state));

switch state {
	case enemy_states.idle 	 : #region
	idle_timer--;
	
	if (idle_timer <= 0) {
		idle_timer = idle_time;
		state = enemy_states.attack;
		attack_direction = point_direction(x,y,oPlayer.x,oPlayer.y);
	}
	
	image_xscale = lerp(image_xscale, 0.8, 0.2);
	image_yscale = lerp(image_yscale, 0.8, 0.2);
	
	break; #endregion
	case enemy_states.attack : #region
	
	attack_speed = approach(attack_speed, dash_speed, 1);
	move(attack_speed, attack_direction);
	
	oPlayer.make_dust(x,y,2, attack_speed*0.3);
	
	var x_near = x + lengthdir_x(3,attack_direction);
	var y_near = y + lengthdir_y(3,attack_direction);
	if (place_meeting(x,y,oPlayer) or place_meeting(x_near,y_near,pSolid) or (x == xprevious and y ==yprevious)) {
		state = enemy_states.recover;
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
	image_blend = c_gray;
	image_xscale = lerp(image_xscale, 0.5, 0.2);
	image_yscale = lerp(image_yscale, 0.5, 0.2);
	
	break;
}