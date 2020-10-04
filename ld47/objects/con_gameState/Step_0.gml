/// @description game state machine

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
		var _target = room_height - 75;
		if y_title_text != _target
			y_title_text = lerp(y_title_text, _target, 0.15);
				
		//left click - start tutorial
		if mouse_check_button_pressed(mb_left)
		{
			//next state
			gameState_next("tutorial_init");
			
			//spawn player
			spawn_player(room_width / 2, room_height / 2);
		}
	}
	break;
	
	//tutorial_init: move title offscreen, shrink overlay
	case "tutorial_init":
	{
		y_title = lerp(y_title, -room_height, 0.1);
		y_title_text = lerp(y_title_text, room_height + 30, 0.1);
		
		if diff(y_title, -room_height) <= 10
			rad = lerp(rad, 0, 0.15);
	}
	break;
	
	//
}