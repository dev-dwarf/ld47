/// @description draw card

//get card side to draw
var _sprite = spr_buff,
	_frame = 0;
	
if card_flipped
{
	_sprite = spr_debuff;
	_frame = 0;
}
	
//card base
draw_sprite_ext(spr_card_base, _frame, round(x), y, xS * scale, scale, angle, c_white, 1);

//card icon
draw_sprite_ext(_sprite, 0, round(x), y, xS * scale, scale, angle, c_white, 1);