///@description save string to file
///@param filename
///@param string

function saveStringToFile(argument0, argument1) {

	var _filename = argument0,
		_string = argument1;

	//do other stuff (i don't really get how this part works)
	var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, _filename);
	buffer_delete(_buffer);
}
