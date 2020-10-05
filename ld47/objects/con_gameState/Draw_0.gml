/// @description game overlay

if rad > 0
{
	draw_circle_color(room_width / 2, room_height / 2, rad, C_black, C_black, 0);
	
	//draw_rectangle_color(-room_width, -room_height, room_width * 2, room_height * 2,
	//C_black, C_black, C_black, C_black, 0);
}

//draw title
if gameState == "title" or gameState == "startup" or gameState == "tutorial_init" or gameState == "game_init"
{
	var _shift = 5 * dsin(tt_float),
		_y = y_title + _shift,
		_x = room_width / 2;
		
	//gear 1
	draw_sprite_ext(sGear1, 0, _x - 50, _y - 25, 1, 1, rot_title + 5, c_white, 1);
	//gear 2
	draw_sprite_ext(sGear2, 0, _x + 100, _y - 45, 1, 1, rot_title + 25, c_white, 1);
	
	
	//title text
	draw_sprite(spr_title_text, 0, _x, _y);
	
	
	//instructions
	var _y_text = y_title_text,
		_space = 25,
	
	if tutorial_completeted
		_y_text -= _space;
		
	if tutorial_completeted
	{
		draw_text_float(_x, _y_text, true, "left click to start", global.font_large, tt_float + 90, 1);
		draw_text_float(_x, _y_text+_space, true, "right click for tutorial", global.font_large, tt_float, 1);

	} else {
		draw_text_float(_x, _y_text, true, "left click to start", global.font_large, tt_float, 1);
		
	}
}

//draw defeat screen
if gameState == "defeat_init" or gameState == "defeat" or gameState == "defeat_exit"
{
	var _xx = room_width / 2;
	draw_sprite_ext(sGear3, 0, _xx, y_title + 25, 1, 1, rot_title + 25, c_white, 1);
	
	draw_text_float(_xx, y_title, 1, "Game Over", global.font_large_outline, tt_float, 1);
	draw_text_float(_xx, y_title + string_height("Ag"), 1, "left click to try again!", global.font_large_outline, tt_float, 1);
}