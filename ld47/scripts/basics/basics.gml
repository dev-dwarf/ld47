///@desc angle_lerp
///@param in
///@param target
///@param percent
function angle_lerp(argument0, argument1, argument2) {
	var angle = (argument0 - angle_difference(argument0, argument1) * argument2)

	while(angle < 0) angle+=360;
	while(angle >= 360) angle -= 360;

	return angle;
}
///@desc approach
///@param in
///@param target
///@param difference
function approach(argument0, argument1, argument2) {
	var start, ending, difference, result;
	start = argument0;
	ending = argument1;
	difference = argument2;
	if (start < ending){
	    result = min(start + difference, ending);
	} else {
	    result = max(start - difference, ending);
	}
	return result;
}

///@param percent
function chance(argument0) {
	return (irandom(100) < argument0);
}

///@param char
function char_is_grammar(argument0) {
	return argument0 == " " or argument0 == "." or argument0 == "," or argument0 == "'" or argument0 == "?";
}

///@desc gamepad_anykey
///@param slot
function gamepad_anykey(argument0) {
	for ( var i = gp_face1; i < gp_axisrv; i++ ) {
	    if ( gamepad_button_check( argument0, i ) ) return i;
	}

	if (abs(gamepad_axis_value(argument0, gp_axislh) != 0) or
		abs(gamepad_axis_value(argument0, gp_axislv) != 0) or 
		abs(gamepad_axis_value(argument0, gp_axisrh) != 0) or 
		abs(gamepad_axis_value(argument0, gp_axisrv) != 0)) {
		return true;	
	}
	return false;
}


///@desc ds_grid_delete_row(grid index, row)
///@param index
///@param row
function ds_grid_delete_row() {
	//Deletes the row in the given grid and resizes the grid appropriately
	//WILL NOT WORK IF THERE IS ONLY 1 ROW IN YOUR GRID.  Thanks for the stupid change, Yoyo.
	// Big thanks to Pixelated Pope: https://old.reddit.com/r/gamemaker/comments/1wi4vy/helpgml_deleting_a_row_from_ds_grid/

	var grid = argument[0];
	var row = argument[1];
	var grid_width=ds_grid_width(grid);
	var grid_height=ds_grid_height(grid);

	ds_grid_set_grid_region(grid, grid, 0, row+1, grid_width-1, grid_height-1, 0,row);
	ds_grid_resize(grid,grid_width,grid_height-1);


}
///@desc play_sound
function play_sound() {
	var _sound		= argument[0];///@param id
	var _priority	= argument[1];///@param priority
	var _loop		= argument[2];///@param loops
	// optional params
	var _id = audio_play_sound(_sound, _priority, _loop);
	var _modify_pitch = argument_count > 3;
	if (_modify_pitch) {
		var _pitch			= argument[3];///@param pitch?
		var _pitch_variance	= argument[4];///@param variance?
		audio_sound_pitch(_id, _pitch + random_range(-_pitch_variance, _pitch_variance))	
	}
	var _modify_gain = argument_count > 5;
	if (_modify_gain) {	
		var _gain = argument[5];  ///@param gain?
		audio_sound_gain(_id, _gain, 0);
	}
	return _id;
}
///@param string
function split_string(argument0) {

	var list = ds_list_create();
	var str = ""; var char = ""

	for (var i = 1; i < string_length(argument0); i++) {
		char = string_char_at(argument0, i);
	
		if (char == " ") {
			ds_list_add(list, str);
			//log(str);
			str = "";
		} else {
			str += char;
		}	
	}

	ds_list_add(list,str); // add last entry

	return list;
}
