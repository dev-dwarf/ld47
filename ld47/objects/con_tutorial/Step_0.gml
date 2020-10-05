/// @description tutorial state

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
	
//make player invincible
with oPlayer
	hp = max_hp;

switch tutorial_state
{
	//"hi there!" introduction
	case 1:
	{
		tutorial_text_type();
		move_box_in();
		
		//move on
		if text_is_done() && mouse_check_button_pressed(mb_left)
		{
			tutorial_state ++;
			tutorial_text_next();
			
			//unlock the player!
			oPlayer.player_active = true;
		}
	}
	break;
	
	//controls explanation
	case 2:
	{
		tutorial_text_type();
		
		//move on
		if text_is_done() && keyboard_check_pressed(vk_space)
		{
			tutorial_state ++;
			tutorial_text_next();
		}
	}
	break;
	
	//text before having to fight enemies
	case 3:
	{
		tutorial_text_type();
		
		if text_is_done() && mouse_check_button_pressed(mb_left)
		{
			draw_dialogue = false;
			tutorial_state ++;
		}
	}
	break;
	
	//spawn enemy after a delay
	case 4:
	{
		tt ++;
		
		if tt >= 35
		{
			tt = 0;
			
			//create enemy spawn spot
			with instance_create_layer(room_width / 2, room_height / 2, "Instances", oSpawnSpot)
				object_to_spawn = oBurstingBrian;
				
			//create wave controller
			with instance_create_layer(0, 0, "Instances", oWaveController)
				wave_number = 0;
			
			tutorial_state ++;
		}
	}
	break;
	
	//5 - defeat enemy to continue
	case 5:
	{
		var _en_defeat = false;

		_en_defeat = instance_exists(oBits);
			
		if _en_defeat
		{
			with oWaveController
				state = wave_states.idle;
				
			tt ++;
			if tt >= 45
			{
				tt = 0;
				tutorial_state ++;
				tutorial_text_next();
			}
		}
	}
	break;
	
	//6 - jump into the portal!
	case 6:
	{
		move_box_in();
		tutorial_text_type();
		
		if text_is_done() && mouse_check_button_pressed(mb_left)
		{
			draw_dialogue = false;
			tutorial_state ++;
		}
	}
	break;	
	
	//7 - spawn the portal
	case 7:
	{
		tt ++;
		
		if tt == 30
		{
			instance_create_layer(room_width / 2, room_height / 2, "Instances", oExitPortal);
			
			with oWaveController
				state = wave_states.next;
		}
		
		if !instance_exists(oPlayer)
		{
			tt = 0;
			tutorial_state ++;
			tutorial_text_next();
			
			with con_cardSelection
				cardSel_active = false;
		}
	}
	break;
	
	//8: explanation about upgrades
	case 8:
	{
		tutorial_text_type();
		move_box_in();
		
		var _st = "";
		with con_cardSelection
			_st = cardSel_state;
		
		if text_is_done() && mouse_check_button_pressed(mb_left) && _st = "pause"
		{
			tutorial_state ++;
			draw_dialogue = false;
			
			with con_cardSelection
			{
				cardSel_active = true;
				cardSel_state = "cards_move_up";
				tt = 0;
			}
			
			with spawn_player(room_width / 2, room_height / 2)
				player_active = false;
		}
	}
	break;
	
	//9
	case 9:
	{
		//move on when cards are gone
		var _cardSel_state = "null";
		with con_cardSelection
			_cardSel_state = cardSel_state;
		
		if !instance_exists(obj_card)
		{				
			tutorial_state ++;
			tutorial_text_next();
			draw_dialogue = true;
			
			with oPlayer
				player_active = true;
		}
	}
	break;
	
	//10 - tutorial complete! left click to end the tutorial and start the game
	case 10:
	{
		tutorial_text_type();
		move_box_in();
		
		if text_is_done() && keyboard_check_pressed(vk_space)
		{
			tutorial_state ++;
			draw_dialogue = false;
		}
	}
	break;
	
	//tutorial object is destroyed, tutorial is officially over
	case 11:
	{
		tt ++;
		
		if tt >= room_speed * 1.5
		{
			instance_destroy();
			
			//refer to con_gamestate for game initialization after tutorial ends
			with con_gameState
				gameState = "tutorial_end";
				
			//create save file so player can skip tutorial in future runs
			if !file_exists("tutorial.done")
				saveStringToFile("tutorial.done", "wow nice!");
		}
	}
	break;
}