// Returns input string with any necessary line breaks (for drawing wrapped text typewriter style).

//	Basically, we are see if the current string has exceeded the maximum width. 
//	If it has, we will backtrack to the most recent space (" "), and insert a line break there (which is represented as "\n" in the code).

//	!!! - Don't forget to use draw_set_font before using this script! - !!!

///@arg string
///@arg width

function typewriter_text_wrap(_str, _width)
{
	//define some variables
	var _str_length = string_length(_str),
		_last_space = 1;//character position of most recent "space" in the string (note that it starts at 1)
	
	var _substr = "";//we are gonna be copying the current string to this variable in a for loop
	
	for (var i = 1; i < _str_length; i ++)
	{
		_substr = string_copy(_str, 1, i);
		
		//set last_space value, if the current character is a space
		if string_char_at(_substr, i) == " "
			_last_space = i;
		
		//if string width has exceeded maximum width, backtrack to most recent space and add line break
		if string_width(_substr) > _width
		{
			_str = string_delete(_str, _last_space, 1);//remove space from string
			_str = string_insert("\n", _str, _last_space);
		}
	}
	
	//return the edited string
	return _str;
}