function draw_text_float(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {
	//draw_text_float

	///@param x
	///@param y
	///@param centered?
	///@param string
	///@param font
	///@param time_var
	///@param amplitude

	var _x = argument0,
		_y = argument1,
		_centered = argument2,
		_string = argument3,
		_font = argument4,
		_tt = argument5,
		_amp = argument6;
	
	draw_set_font(_font);

	if (_centered)
		_x -= round(string_width(_string) / 2)

	var _len = string_length(_string),
		_ii = 1,
		_tt_offset = 25;
	
	repeat(_len)
	{
		var _char = string_char_at(_string, _ii),
			_charStr = string(_char),
			_char_w = string_width(_charStr);
		
		var _shift = _amp + dsin(_tt + (_tt_offset * _ii)),
			_yy = _y + _shift;
		
		draw_text(_x, _yy, _charStr);
	
		_x += _char_w;
		_ii ++;
	}

	draw_set_halign(fa_left);
}
