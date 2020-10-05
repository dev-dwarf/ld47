// 
function tutorial_text_type()
{
	tt_string ++;
	
	var _inc = 2;
	
	if tt_string >= _inc && string_drawn != string_current
	{
		tt_string = 0;
		
		//increment string position
		str_pos ++;
		
		//add next character to string
		var _char = string_char_at(string_current, str_pos);
		
		string_drawn += _char;
	}
	
	if mouse_check_button_released(mb_left) && str_pos >= 10
	{
		str_pos ++;
		for (var i = str_pos; i < string_length(string_current) + 1; i ++)
		{
			var _char = string_char_at(string_current, i);
		
			string_drawn += _char;
			str_pos ++;
		}
	}
}