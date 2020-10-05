function tutorial_text_next()
{
	with con_tutorial
	{
		text_state ++;
		
		var _string = tutorial_text[? string(text_state)];
		
		tt_string = 0;
		string_current = _string;
		string_drawn = "";
		str_pos = 0;		
		draw_dialogue = true;
		box_off = 5;
		
		draw_set_font(global.font_large);
		string_current = typewriter_text_wrap(string_current, tut_string_w);
	}
}