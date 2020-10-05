/// @description draw tutorial stuff

//draw dialogue box
var _shift = 5 * dsin(tt_float),
	_blinkTime = tt_blink_max * 0.95,
	_y = box_y + box_off;
	
draw_sprite(spr_tut_dialogue, 0, room_width / 2, _y);
draw_sprite_ext(spr_tut_portrait, (tt_blink >= _blinkTime), 35, (_y - 37) + _shift, 1, 1, _shift * 2, c_white, 1);
	
draw_set_font(global.font_large);
draw_text(70, (_y - sprite_get_height(spr_tut_dialogue)) + 10, string_drawn);

//continue arrow
if string_drawn == string_current && (frame_arrow >= 30)
	draw_sprite(spr_tut_arrow, 0, room_width - 10, _y - 15);