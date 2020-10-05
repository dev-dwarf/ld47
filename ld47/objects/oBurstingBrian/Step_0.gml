/// @description

if (oPlayer.state == player_states.death) {
	image_blend = global.that_one_purple;
	y_off = 0;
	exit;
}

y_off = sin(current_time*0.01) * 3;


switch state {
	case enemy_states.idle 	 : #region
	idle_timer--;
	
	var r = 3*idle_timer/idle_time
	draw_x = random_range(r,-r)
	draw_y = random_range(r,-r)	
	
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
	
	image_xscale = 0.25 + 0.75 * (1-attack_timer/attack_time);
	image_yscale = image_xscale;
	
	y = ystart - 4 * (1-attack_timer/attack_time);
	
	if (attack_timer <= 0) {
		var dir = point_direction(x,y,oPlayer.x,oPlayer.y);
		for (var i = 0; i < 360; i += 360/projectile_number) {
			with instance_create_layer(x + lengthdir_x(sprite_width/2, i+dir),
								  y-sprite_height/2 + lengthdir_y(sprite_width/2, i+dir)
			,layer,oBurstingBrianProjectile) {
				direction = i+dir;	
				parent = other.id;
			}
		}
		
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
	image_blend = global.that_one_purple;
	image_xscale = lerp(image_xscale, 0.5, 0.2);
	image_yscale = lerp(image_yscale, 0.5, 0.2);
	
	break;
}

