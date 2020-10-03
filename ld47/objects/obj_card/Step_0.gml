/// @description card behavior

//offset management
if !card_selected
{
	if y_off > 0 && !mouse_in_box()
		y_off = lerp(y_off, 0, 0.15);
} else if y_off > -10
	y_off = lerp(y_off, -10, 0.15);
	
//selection arrow animation
if frame_arrow > sprite_get_number(spr_card_base_selected)
	frame_arrow = 0;

frame_arrow += (15 / room_speed);

if tt_draw > 0
	tt_draw --;
	
if mouse_in_box()
{
	tt_draw = 10;
	
	var _me = id;
	with obj_card
		if id != _me
			tt_draw = 0;
}