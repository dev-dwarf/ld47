/// @description card selection state machine

//text float timer
tt_text = (tt_text + 3) mod 360;

//flash timer
if tt_flash > 0
	tt_flash --;
if error_off > 0
	error_off = lerp(error_off, 0, 0.15);

//particles
if irandom(1000) <= 90
	part_particles_create(sys, irandom_range(10, room_width - 10), irandom_range(10, room_height - 10), part_star, 1);

//state machine 
switch cardSel_state
{
	//startup_transition: black circle grows to encompass screen
	case "startup_transition":
	{
		var _t = room_width;
		transition_radius = lerp(transition_radius, _t, 0.05);
		
		if transition_radius >= (_t * 0.95)
		{
			cardSel_state = "startup";
		}
	}
	break;
	
	//startup: spawn cards. Buffs and debuffs associated with the cards are chosen here!
	case "startup":
	{
		//x/y positions where cards are spawned
		var _x = room_width / 2,
			_y = room_height + 150;
			
		//now we're gonna make 2 temporary lists representing the possible buffs/debuffs that can be chosen
		var _buffs = ds_list_create(),
			_debuffs = ds_list_create();
			
		_buffs = oCardHolder.generate_card_list(card.good, 5);
		_debuffs = oCardHolder.generate_card_list(card.bad, 5);

			
		//spawn 5 cards at the above x/y coordinates
		for (var i = 0; i < 5; i ++)
		{
			//choose random buff/debuff to give player
			var _buff = _buffs[| i];
			var	_debuff = _debuffs[| i];
				
			//spawn the card!
			spawn_card(_x, _y, i + 1, _buff, _debuff);
		}
		
		//destroy temporary lists
		ds_list_destroy(_buffs);
		ds_list_destroy(_debuffs);
		
		//move on to next state
		cardSel_state = "cards_move_up";
		play_sound(sndCardsSwingUp, 0, false, 1.0, 0.00, 1.0);
		
		if !cardSel_active
			cardSel_state = "pause";
	}
	break;
	
	//cards_move_up: cards move up from bottom of screen (after a brief delay)
	case "cards_move_up":
	{
		tt ++;
		if tt >= 15
		{
			var _yt = room_height - 75,
				_moveon = true;
				
			with obj_card
			{
				y = lerp(y, _yt, 0.15);
				
				if point_distance(x, y, x, _yt) > 0.1
					_moveon = false;
				else y = _yt
			}
			
			//move on to next state
			if _moveon
			{
				tt = 0;
				cardSel_state = "cards_fan";
				play_sound(sndCardsUnfold, 0, false, 1.0, 0.00, 1.0);
			}
		}
	}
	break;
	
	//cards_fan: cards fan out
	case "cards_fan":
	{
		var _moveon = true;
		
		with obj_card
		{
			var	_inc = 60,//angle space between card
				_angle_target = 45 - ((_inc / 2) * (card_priority - 2));
			
			angle = langle(angle, _angle_target, 0.15);
			
			if abs(angle_difference(angle, _angle_target)) > 0.5
				_moveon = false;
			else angle = _angle_target
		}
		
		//move on to next state
		if _moveon
		{
			play_sound(sndEnterCardSelect, 0, false, 1.0, 0.00, 1.0);
			cardSel_state = "cards_move_to_place";
			
			//set cards' x/y targets, for when they start to move into place
			var _yt = room_height / 2,
				_xt_o = room_width / 2,
				_card_space = sprite_get_width(spr_card_base) * 2.5;//space b/w cards
				
			with obj_card
			{
				xT = _xt_o + ((_card_space / 2) * (card_priority - 3));
				yT = _yt;
			}
		}
	}
	break;
	
	//cards_move_to_place: cards move into place!
	case "cards_move_to_place":
	{
		//move cards
		var _lerp = 0.15,
			_move_on = true;
			
		with obj_card
		{
			x = lerp(x, xT, _lerp);
			y = lerp(y, yT, _lerp);			
			angle = langle(angle, 0, _lerp);
			
			if point_distance(x, y, xT, yT) <= 0.5 && abs(angle) <= 0.5
			{
				x = xT;
				y = yT;
				angle = 0;
				
			} else _move_on = false;			
		}
		
		if _move_on
			cardSel_state = "card_select";
	}
	break;
	
	//card_select: player selects their cards
	case "card_select":
	{
		//card selection
		with obj_card
		{
			if point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom)
			{
				if mouse_in_box()
				{					
					//make the card move up a bit when moused over
					if !card_selected {
						if (y_off < 1) 
						{
							play_sound(sndSwingMiss, 0, false, 1.0, 0.09, 0.5);
						}	
						y_off = lerp(y_off, 5, 0.25);
							
					}
						
					//select card when clicking
					if mouse_check_button_pressed(mb_left) 
					{
						play_sound(sndSwordHit, 0, false, 1.0 + 0.5 * card_selected, 0.02, 0.6);
						card_selected = !card_selected;
					}
				}
			}
		}
		
		//confirmation
		if mouse_check_button_pressed(mb_right)
		{
			//check that there is at LEAST one selected card
			var _selCount = 0;
			
			with obj_card
				_selCount += card_selected;
				
			if _selCount > 0
			{
				cardSel_state = "cards_flip";
				play_sound(sndCardsUnfold, 0, false, 2.0, 0.09, 1.0);
				
			}
			else
			{
				tt_flash = room_speed * 1.5;//***
				error_off = 5;
				oCamera.set_shake(0.5);
				play_sound(sndPlayerHurt, 0, false, 1.5, 0.02, 1.0);
			}
		}
	}
	break;
	
	//cards_flip: flip selected cards over to reveal debuffs, destroy non-selected cards
	case "cards_flip":
	{		
		var _move_on = true;
		var flipped_the_thang = false;
		with obj_card
		{
			//flip selected cards
			if card_selected
			{
				//squash cards until they are ready to flip
				if !card_flipped
				{
					var _target = 0.005;
					xS = lerp(xS, _target, 0.15);
				
					if xS <= _target * 1.5
					{
						card_flipped = true;
						flipped_the_thang = true;
						xS = _target;
					}
				} else xS = lerp(xS, 1, 0.35);
				
				if !card_flipped or (card_flipped && xS != 1)
					_move_on = false;
			}
			//move non-selected cards offscreen
			else
			{
				y = lerp(y, room_height * 1.25, 0.15);
				if y >= (room_height * 1.15)
					instance_destroy();
			}
		}
		
		if (flipped_the_thang) play_sound(sndCardsFlip, 0, false, 1.0, 0.00, 1.0);	
		
		if _move_on {
			cardSel_state = "cards_view_debuff";
			
		}
	}
	break;
	
	//cards_view_debuff: player can view which debuffs they've received. 
	case "cards_view_debuff":
	{
		//move on when right clicking, and apply buffs/debuffs
		if mouse_check_button_pressed(mb_right)
		{
			//move on
			cardSel_state = "cards_destroy";
			play_sound(sndClockBigTick, 1, false, 1.0, 0.0, 1.0)

			
			//apply buffs & debuffs
			with obj_card
				apply_card();
		}
		
		with obj_card
			if mouse_in_box() {
				if (y_off < -9) 
				{
					play_sound(sndSwingMiss, 0, false, 0.7, 0.09, 0.5);
				}	
				y_off = lerp(y_off, 5, 0.15);
				
			}
	}
	break;
	
	//cards_destroy: move cards offscreen
	case "cards_destroy":
	{
		con_gameState.target_track_index	= sndBattleMusic;
		with obj_card
		{
			y = lerp(y, room_height * 1.25, 0.15);
			if y >= (room_height * 1.15)
				instance_destroy();
		}

		if !instance_exists(obj_card) 
		{
			cardSel_state = "cards_wrapup";
			part_particles_clear(sys);
			part_system_destroy(sys);
		}
	}
	break;
	
	case "cards_wrapup":
	{
		transition_radius = lerp(transition_radius, 0, 0.15);
		
		if transition_radius <= 1
		{
			instance_destroy();

			oCamera.set_shake(0.5);
			
			if !instance_exists(con_tutorial)
				with con_gameState
					gameState = "game_init";
		}
			
	}
	break;
}