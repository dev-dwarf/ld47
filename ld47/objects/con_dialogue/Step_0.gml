/// @description boss dialogue

tt_float = (tt_float + 3) mod 360;

tt_blink ++;
if tt_blink > tt_blink_max
	tt_blink = 0;
	
if box_off != 0
	box_off = lerp(box_off, 0, 0.15);
	
if !draw_dialogue
	box_y = lerp(box_y, room_height + 100, 0.15);
	
frame_arrow ++;
if frame_arrow >= room_speed
	frame_arrow = 0;
		
switch dialogue_state
{
	case "startup":
	{
		move_box_in();
		
		if diff(box_y, room_height - 10) <= 1
		{
			tt_delay ++;
			
			if tt_delay >= 15
			{
				//get initial text
				text_state_next();
			
				//move on to drawing the dialogue
				dialogue_state = "dialogue";
			}
		}
	}
	break;
	
	//advance text, if applicable
	case "dialogue":
	{
		advance_dialogue();
		move_box_in();

		if text_is_done() && mouse_check_button_pressed(mb_left)
		{
			box_off = 10;
			text_state_next();
			
			//move on fully if text is done
			if string_current == "null"
				dialogue_state = "destroy";
		}
	}
	break;
	
	//destroy the dialogue
	case "destroy":
	{
		var _t = room_height + 100;		
		box_y = lerp(box_y, _t, 0.15);
		
		if diff(box_y, _t) <= 1
		{
			//destroy object
			instance_destroy();
			
			//intiate "victory" state
			with con_gameState
				gameState_next("victory");
		}
	}
	break;
}