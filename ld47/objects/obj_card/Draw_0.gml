/// @description draw card

//get card side to draw
var _sprite = spr_buff,
	_y = y - y_off;
	
if card_flipped
	_sprite = spr_debuff;

//card base
draw_sprite_ext(spr_card_base, card_flipped, x, _y, xS * scale, scale, angle, c_white, 1);

//card icon
draw_sprite_ext(_sprite, 0, x, _y, xS * scale, scale, angle, c_white, 1);

//selection arrow
if card_selected && !card_flipped
{
	var _frame_arrow = clamp(frame_arrow, 0, sprite_get_number(spr_card_base_selected) - 1);	
	draw_sprite_ext(spr_card_base_selected, _frame_arrow, x + 1, _y - 78, xS * scale, scale, angle, c_white, 1);
}

//draw card information
if (con_cardSelection.cardSel_state == "card_select" or con_cardSelection.cardSel_state == "cards_view_debuff")
&& (mouse_in_box() or tt_draw > 0)
{
	var _buff_pointer = "buff_" + string(card_buff) + "_",
		_debuff_pointer = "debuff_" + string(card_debuff) + "_",
		_name_pointer = "",
		_desc_pointer = "",
		_name = "",
		_desc = "";
		
	//get name/desc
	if !card_flipped
	{
		_name_pointer = _buff_pointer + "name";
		_desc_pointer = _buff_pointer + "desc";
	}
	else
	{
		_name_pointer = _debuff_pointer + "name";
		_desc_pointer = _debuff_pointer + "desc";
	}
	
	_name = get_card_info(_name_pointer);	
	_desc = get_card_info(_desc_pointer);	
	
	var _tx = round(room_width / 2);//text x
	
	//set halign to center
	draw_set_halign(fa_center);
	
	//draw name
	draw_set_font(global.font_large);
	draw_text(_tx, (bbox_top - 25) - clamp(y_off, 0, 10), _name);
	
	//draw description
	draw_set_font(global.font_small);
	draw_text_ext(_tx, round(y) + 16, _desc, string_height("Ag") + 3, 350);
	
	//reset halign
	draw_set_halign(fa_left);
}