/// @description game state machine

if gameState == "startup" or gameState == "title" or gameState == "tutorial_init"
	rot_title = (rot_title + 1) mod 360;

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
		//float timer
		tt_float = (tt_float + 3) mod 360;
		
		//instructional text lerp
		var _target = room_height - 40;
		if y_title_text != _target
			y_title_text = lerp(y_title_text, _target, 0.15);
				
		//left click - start tutorial
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
					tutorial_text_next();
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
		}
	}
	break;
	
	//game_init: whatever needs to happen to start a round of gameplay happens here
	case "game_init":
	{
		//***
	}
	break;
	
	//
}