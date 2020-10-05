/// @description draw HUD

var _xc = (room_width / 2) + 50,
	_HUD_y = 15;

//HP
//------------------------------------------------------------------------------
var _x = _xc,
	_y = _HUD_y - 5,
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

draw_sprite(spr_HUD_heart, _frame, _xc, _HUD_y);

//Laser
//------------------------------------------------------------------------------
if player_has_laser
{
	_HUD_y += 17;
	
	//laser bars
	var _laser_w = 50,
		_laser_w_drawn = _laser_w * player_laser,
		_h = sprite_get_height(spr_HUD_laser_bar);

	//laser base
	var _ly = (_HUD_y - 3) + laser_off;
	
	draw_rect_color(_xc, _ly, _xc + (_laser_w - 1), _ly + (_h - 1), C_black, 0);
	draw_rect_color(_xc, _ly, (_xc - _laser_w) - 1, _ly + (_h - 1), C_black, 0);
	
	if laser_flash <= 0
	{
		//laser fill
		draw_sprite_stretched(spr_HUD_laser_bar, 0, _xc, _ly, _laser_w_drawn, _h);
		draw_sprite_stretched(spr_HUD_laser_bar, 0, _xc - _laser_w_drawn, _ly, _laser_w_drawn, _h);
	
		//sword icon
		draw_sprite(spr_HUD_sword, 0, _xc, _HUD_y + laser_off);
	} 
	else
	{
		shader_set(shFlash);
		
		//laser fill
		draw_sprite_stretched(spr_HUD_laser_bar, 0, _xc, _ly, _laser_w_drawn, _h);
		draw_sprite_stretched(spr_HUD_laser_bar, 0, _xc - _laser_w_drawn, _ly, _laser_w_drawn, _h);
	
		//sword icon
		draw_sprite(spr_HUD_sword, 0, _xc, _HUD_y + laser_off);
		
		shader_reset();
	}
}