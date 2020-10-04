

if (oPlayer.state == player_states.death) {
	image_blend = c_gray;
	exit;
}

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
	offset_direction =  oPlayer.move_direction;
	
	attack_direction = angle_lerp(attack_direction, offset_direction, 0.5);
	
	if (distance_to_object(oPlayer) < range) {
		move_speed = approach(move_speed, attack_speed, 0.1);	
		move(attack_speed, attack_direction);
	} else {
		move_speed = approach(move_speed, 0, 0.2);	
	}
	

	
	oPlayer.make_dust(x,y,1, attack_speed*0.3);
	
	idle_timer--;
	if (idle_timer <= 0) {
		idle_timer = idle_time;
		image_xscale = 0.5;
		image_yscale = 0.5;	
		
		var dir = point_direction(x,y,oPlayer.x, oPlayer.y) - spread/2;
		var r = sprite_width;
		for (var i = 0; i < pellets; i++) {
			var d = dir+i*spread/pellets+random_range(-5,5);
			with instance_create_layer( x + lengthdir_x(r, d),
										y - sprite_height/2 + lengthdir_y(r, d),
										layer, oShotgunShitleyProjectile) 
			{			
				parent = other.id;
				direction = d;					
			}
		}
	}
	
	image_xscale = lerp(image_xscale, 1.0, 0.2);
	image_yscale = lerp(image_yscale, 1.0, 0.2);
	break; #endregion
	
	case enemy_states.dead	 : 
	image_blend = c_gray;
	image_xscale = lerp(image_xscale, 0.5, 0.2);
	image_yscale = lerp(image_yscale, 0.5, 0.2);
	
	break;
}