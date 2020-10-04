/// @description

if (oPlayer.state == player_states.death) {
	image_blend = c_gray;
	exit;
}

switch state {
	case enemy_states.idle 	 : #region
	idle_timer--;
	
	if (idle_timer <= 0) {
		idle_timer = idle_time;
		state = enemy_states.attack;
	}
	
	image_xscale = lerp(image_xscale, 1.0, 0.2);
	image_yscale = lerp(image_yscale, 1.0, 0.2);
	
	y = lerp(y,ystart,0.2);
	
	break; #endregion
	case enemy_states.attack : #region
	attack_timer--;
	
	image_xscale = 0.25 + 0.75 * attack_timer/attack_time;
	image_yscale = image_xscale;
	
	y = ystart - 4 * (1-attack_timer/attack_time);
	
	if (attack_timer <= 0) {
		instance_create_layer(x,y-sprite_height,layer,oProjectilePaulProjectile);
		
		attack_timer = attack_time;
		state = enemy_states.idle;
	}
	break; #endregion
	// UNUSED FOR THIS ENEMY
	//case enemy_states.recover: 
	
	//break;
	//case enemy_states.hit	 :
	
	//break;
	case enemy_states.dead	 : 
	image_blend = c_gray;
	image_xscale = lerp(image_xscale, 0.5, 0.2);
	image_yscale = lerp(image_yscale, 0.5, 0.2);
	
	break;
}