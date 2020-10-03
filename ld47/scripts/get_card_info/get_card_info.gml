// Retrieve card's name/description from card_info.txt

///@desc get_card_info
///@arg pointer

function get_card_info(_pointer)
{
	//get map of all names from file
	var _map = load_json_map("card_info.txt");
	
	//find pointer and return it
	return _map[? _pointer];
}