/// @description draw transition

//draw circle
var _col = C_black;	
draw_circle_color(room_width / 2, room_height / 2, transition_radius, _col, _col, 0);

//draw instruction text
if cardSel_state == "cards_view_debuff" or cardSel_state == "card_select"
{
	var _sel_count = 0;
	with obj_card
		_sel_count += card_selected;
		
	var _str = "(right-click to confirm selected cards)";
	if cardSel_state == "cards_view_debuff"
		_str = "(right-click to continue)";
		
	if _sel_count <= 0
		_str = "(left-click cards to select them)";
	
	draw_text_float(room_width / 2, room_height - 65, true, _str, global.font_large, tt_text, 3);
}

if tt_flash > 0 && cardSel_state == "card_select"
{
	draw_set_color(C_yellow);
	draw_text_float(room_width / 2, (room_height - 85) + error_off, true, "!! - select at least one card - !!", global.font_large, tt_text, 3);
	draw_set_color(c_white);
}