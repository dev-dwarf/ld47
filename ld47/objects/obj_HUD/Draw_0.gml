/// @description draw HUD

//HP
//------------------------------------------------------------------------------
var _x = room_width / 2,
	_y = 16,
	_off = 10,
	_bar_h = 4,
	_bar_w_total = 75 + _off,
	_bar_w_fill = _bar_w_total * (player_hp / player_hpMax);
	
//HP bar - outline
//draw_rect_color(_x, _y - 1, _x + _bar_w_total + 1, _y + _bar_h + 1, C_black, 0);

//HP bar - bar base
draw_rect_color(_x, _y, _x + _bar_w_total, _y + _bar_h, C_purple_dark, 0);
draw_rect_color(_x, _y, _x - _bar_w_total, _y + _bar_h, C_purple_dark, 0);

//HP bar - bar fill
draw_rect_color(_x, _y, _x + _bar_w_fill, _y + _bar_h, C_purple_light, 0);
draw_rect_color(_x, _y, _x - _bar_w_fill, _y + _bar_h, C_purple_light, 0);

//HP sprite
var _frame = (blink >= blink_max * 0.95);
if player_hp <= 0
	_frame = 2;

draw_sprite(spr_HUD_heart, _frame, room_width / 2, 20);