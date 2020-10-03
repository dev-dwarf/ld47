/// @description draw transition

var _col = make_color_rgb(17, 1, 27);
draw_circle_color(room_width / 2, room_height / 2, transition_radius, _col, _col, 0);

if cardSel_state == "cards_view_debuff" or cardSel_state == "card_select"
{
	var _str = "Right-click to confirm selected cards";
	if cardSel_state == "cards_view_debuff"
		_str = "Right-click to continue";
	
	draw_text_float(room_width / 2, room_height - 65, true, _str, global.font_large, tt_text, 3);
}