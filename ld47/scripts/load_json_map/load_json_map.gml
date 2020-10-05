///@param filename

function load_json_map(_filename) 
{
	var file = file_text_open_read(_filename);
	var _string = "";

	while !file_text_eof(file)
	{
	    _string += file_text_read_string(file);
	    file_text_readln(file);
	}

	file_text_close(file);
	
	var _json = json_decode(_string);
	
	return _json;
}