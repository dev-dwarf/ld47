/// @description game state machine

//flotation and rotation
rot_title = (rot_title + 1) mod 360;
tt_float = (tt_float + 3) mod 360;

switch gameState
{
	//startup: move the title into place
	case "startup":
	{
		tt ++;
		
		if tt >= room_speed
		{
			var _t = room_height / 2;
		
			y_title = lerp(y_title, _t, 0.15);
			if diff(y_title, _t) <= 0.1
			{
				y_title = _t;
				gameState_next("title");
			}
		}
	}
	break;
	
	//title: player is on the title screen
	case "title":
	{
		//instructional text lerp
		var _target = room_height - 40;
		if y_title_text != _target
			y_title_text = lerp(y_title_text, _target, 0.15);
				
		if (tutorial_completeted) {
			//left click - start tutorial
			if mouse_check_button_pressed(mb_right)
			{
				//next state
				gameState_next("tutorial_init");
			
				//spawn player
				with spawn_player(room_width / 2, room_height / 2)
					player_active = false;
				
				//spawn tutorial manager
				instance_create_depth(0, 0, -room_height * 2, con_tutorial);
			}
		
			if mouse_check_button_pressed(mb_left)
			{
				//next state
				gameState_next("game_init");
			}
		} else {
			if mouse_check_button_pressed(mb_left)
			{
				//next state
				gameState_next("tutorial_init");
			
				//spawn player
				with spawn_player(room_width / 2, room_height / 2)
					player_active = false;
				
				//spawn tutorial manager
				instance_create_depth(0, 0, -room_height * 2, con_tutorial);
			}
		}
	}
	break;
	
	//tutorial_init: move title offscreen, shrink overlay
	case "tutorial_init":
	{
		y_title = lerp(y_title, -room_height, 0.1);
		y_title_text = lerp(y_title_text, room_height + 30, 0.15);
		
		if diff(y_title, -room_height) <= 10
		{
			rad = lerp(rad, 0, 0.15);
			if rad <= 0.5
			{
				rad = 0;
				gameState_next("tutorial");
				with con_tutorial
				{
					tutorial_state = 1;
					text_state_next();
				}
			}
		}
	}
	break;
	
	//tutorial
	case "tutorial":
	{
		//***
	}
	break;
	
	//tutorial_end: end tutorial, move on to starting the game
	case "tutorial_end":
	{
		rad = lerp(rad, room_width, 0.15);
		if rad >= (room_width * 0.99)
		{
			rad = room_width;
			gameState = "game_init";
			reset_card_counts();
			room_restart();
		}
	}
	break;
	
	//game_init: whatever needs to happen to start a round of gameplay happens here
	case "game_init":
	{
		y_title = lerp(y_title, -room_height, 0.1);
		y_title_text = lerp(y_title_text, room_height + 30, 0.15);
		
		if diff(y_title, -room_height) <= 10
		{
			//switch gamestate to active
			gameState = "game_active";
		
			//spawn wave controller
			instance_create_layer(0,0, "Instances", oWaveController);
		}
	}
	break;
	
	//game_active: round of normal gameplay is running
	case "game_active":
	{
		//lerp out gameState overlay	
		if rad > 0
			rad = lerp(rad, 0, 0.15);
		
		//check for defeat conditions
		var _player_defeat = false;
		with oPlayer
			_player_defeat = (hp <= 0);
		
		//initiate defeat state
		if _player_defeat
		{
			gameState_next("defeat_init");
			y_title = -room_height;
			
			with oPlayer
				sprite_index = sPlayerIdle;
		}
		
		//check for victory conditions
		var _player_victory = false;
		with oBoss
			_player_victory = (state == boss_states.dead);
			
		//initiate victory state
		if _player_victory && !_player_defeat
		{
			//create dialogue object
			 instance_create_depth(0, 0, -room_height * 2, con_dialogue);
		 
			 //move on
			 gameState_next("victory_dialogue_init");
			
			//switch player to victory state
			with oPlayer
			{
				speed = 0;
				direction = 0;
				state = player_states.victory;
			}
		}
				
	}
	break;
	
	//initialize defeat state
	case "defeat_init":
	{
		var _delay = room_speed;
		
		if tt < _delay
			tt ++;
		else
		{
			var _t = (room_height / 2) - 35;
			
			y_title = lerp(y_title, _t, 0.15);
				
			if diff(y_title, _t) <= 0.1
			{
				y_title = _t;
				gameState_next("defeat");
			}
		}	
	}
	break;
	
	//defeat: player has lost the game
	case "defeat":
	{
		//click to restart
		if mouse_check_button_pressed(mb_left)
		{
			//clear out room
			room_restart();
			instance_destroy(oCardHolder);
			
			//reset cards
			reset_card_counts();
			
			//move on to next game state
			gameState_next("defeat_exit");
		}
	}
	break;
	
	//defeat_exit: move defeat offscreen
	 case "defeat_exit":
	 {
		 rad = lerp(rad, room_width, 0.15);
		 y_title = lerp(y_title, -room_height, 0.1);
		
		if diff(y_title, -room_height) <= 10 && diff(rad, room_width) <= 5
			gameState_next("game_init");
	 }
	 break;
	 
	 //victory_dialogue_init: delay before initializing victory dialogue. any effects you want to add for the boss being defeated should go here
	 case "victory_dialogue_init":
	 {
		 tt ++;
		 if tt >= room_speed
			gameState_next("victory_dialogue");
	 }
	 break;
	 
	 //victory_dialogue: player is chatting with the boss
	 case "victory_dialogue":
	 {
		 //
	 }
	 break;
	
	//victory: player has beaten the boss and completed dialogue
	case "victory":
	{
		var _t = (room_height / 2) - 35;
			
		y_title = lerp(y_title, _t, 0.15);
			
		if diff(y_title, _t) <= 1 && mouse_check_button_pressed(mb_left)
			gameState_next("victory_exit");
	}
	break;
	
	 case "victory_exit":
	 {
		 rad = lerp(rad, room_width, 0.15);
		 y_title = lerp(y_title, -room_height, 0.1);
		
		if diff(y_title, -room_height) <= 10 && diff(rad, room_width) <= 5
		{
			room_restart();			
			global.wave_count = 0;
			
			gameState_next("game_init");
		}
	 }
	 break;
}