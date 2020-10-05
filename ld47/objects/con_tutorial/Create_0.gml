/// @description variables

tutorial_state = 0;//current tutorial state

tt_blink = 0;
tt_blink_max = room_speed * 5;
tt_float = 0;
tt_string = 0;
tt = 0;
string_current = "";//current string that is being drawn from
string_drawn = "";//actual string that is being drawn
str_pos = 0;//position in string

frame_arrow = 0;
x_portrait_start = -100;
x_portrait = x_portrait_start;
box_y = room_height + 100;
box_off = 0;
tut_string_w = sprite_get_width(spr_tut_dialogue) - 80;

draw_dialogue = true;
text_state = -1;
tutorial_text = load_json_map("tutorial_text.txt");

function text_is_done()
{
	return string_drawn == string_current;
}