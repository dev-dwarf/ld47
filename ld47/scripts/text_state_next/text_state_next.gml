function text_state_next()
{
	text_state ++;
		
	var _string = dialogue_text[? string(text_state)];
	
	if _string == undefined
		_string = "null";
		
	tt_string = 0;
	string_current = _string;
	string_drawn = "";
	str_pos = 0;		
	draw_dialogue = true;
	box_off = 5;
		
	draw_set_font(global.font_large);
	string_current = typewriter_text_wrap(string_current, tut_string_w);
}