/// @description game overlay

if rad > 0
{
	draw_circle_color(room_width / 2, room_height / 2, rad, C_black, C_black, 0);
	
	//draw_rectangle_color(-room_width, -room_height, room_width * 2, room_height * 2,
	//C_black, C_black, C_black, C_black, 0);
}

//draw title
if gameState == "title" or gameState == "startup" or gameState == "tutorial_init"
{
	var _shift = 5 * dsin(tt_float),
		_y = y_title + _shift,
		_x = room_width / 2;
		/*
	//gear 1
	draw_sprite_ext(sGear1, 0, _x - 50, _y + 10, 1, 1, rot_title + 5, c_white, 1);
	//gear 2
	draw_sprite_ext(sGear2, 0, _x + 100, _y - 45, 1, 1, rot_title + 25, c_white, 1);
	//gear 3
	draw_sprite_ext(sGear3, 0, _x, _y + 10, 1, 1, rot_title + 10, c_white, 1);
	//gear 4
	draw_sprite_ext(sGear3, 0, _x + 50, _y + 10, 1, 1, rot_title + 5, c_white, 1);
	*/
	
	//title text
	draw_sprite(spr_title_text, 0, _x, _y);
	
	
	//instructions
	var _y_text = y_title_text,
		_space = 25,
		_quick_restart = file_exists("tutorial.done");
	
	if _quick_restart
		_y_text -= _space;
		
	draw_text_float(_x, _y_text, true, "left click to start", global.font_large, tt_float, 1);
	
	if _quick_restart
	{
		_y_text += _space;
		draw_text_float(_x, _y_text, true, "right click to quickstart", global.font_large, tt_float + 90, 1);
	}
}