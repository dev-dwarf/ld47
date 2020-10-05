/// @description

switch state {
	case wave_states.spawn	: #region 
	spawn_timer--;
	
	if (spawn_timer == 0) {
		oSpawnSpot.create = true;
		state = wave_states.battle;	
	}
	break; #endregion
	case wave_states.battle	: #region 
	
	var live_enemies = 0;
	with pEnemy {
		if (state != enemy_states.dead) live_enemies++;	
	}
	live_enemies += instance_exists(oBoss);
	
	if (live_enemies == 0) {
		if (wave_number <= 0) {
			instance_create_layer(room_width/2,room_height/2,layer,oExitPortal);

			state = wave_states.next;
		} else {
			state = wave_states.spawn;
			spawn_timer = spawn_time;
			
			create_wave();
		}
	}	
	break; #endregion
	
	case wave_states.next	: #region 
	if (instance_exists(oExitPortal) && oExitPortal.player) {
		instance_create_layer(0,0,layer,con_cardSelection);
		instance_destroy(oBuzzSaw);
		instance_destroy(oExitPortal);
		instance_destroy(pEnemy);	
		instance_destroy(oSword);
		instance_destroy();
		instance_destroy(oPlayer);
	} 
	break; #endregion
}