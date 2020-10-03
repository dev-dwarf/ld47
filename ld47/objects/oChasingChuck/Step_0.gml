
// Inherit the parent event
event_inherited();

switch state {
	#region unused
	case enemy_states.idle 	 : #region 
	break; #endregion
	case enemy_states.recover: 
	break;
	case enemy_states.hit	 :
	break;
	#endregion
	case enemy_states.attack : #region
	
	var new_attack_dir = angle_lerp(attack_direction, point_direction(x,y,oPlayer.x, oPlayer.y), 0.7);
	var dif = abs(angle_difference(new_attack_dir, attack_direction)/120);
	attack_direction = new_attack_dir;
	attack_speed = lerp(attack_speed, 0, dif);
	
	attack_speed = approach(attack_speed, dash_speed, attack_accel);
	move(attack_speed, attack_direction);
	
	oPlayer.make_dust(x,y,1, attack_speed*0.3);
	break; #endregion
	
	case enemy_states.dead	 : 
	image_blend = c_gray;
	image_xscale = lerp(image_xscale, 0.5, 0.2);
	image_yscale = lerp(image_yscale, 0.5, 0.2);
	
	break;
}