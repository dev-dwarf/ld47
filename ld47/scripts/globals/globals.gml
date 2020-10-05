
function globals(){
	gml_pragma("global", "globals()")
	
	#region gamepad
	global.gamepad_connected	= false;
	global.gamepad_slot			= false;
	global.gamepad_is_xbox		= false;
	#endregion
	
	global.set_window = true;
	global.fullscreen = false;
	
	global.master_volume = 0//0.75; 
	global.sound_volume = 1.0 * global.master_volume;
	global.music_volume = 1.0 * global.master_volume;
	
	global.that_one_purple = make_color_rgb(213, 137, 229);
	
	//global.fullscreen = true;
	global.wave_count = 0;
	//global.wave_count = 11;//skip to boss
	
	global.sword_count = 1;
	global.sword_id = 0;
	
	global.gui_scale = 0;
	
	//fonts
	global.font_large = font_add_sprite_ext(spr_font_large,
	" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.,!?*()-+'", 1, 2);
	
	global.font_large_outline = font_add_sprite_ext(spr_font_large_outline,
	" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.,!?*()-+", 1, 0);
	
	global.font_small = font_add_sprite_ext(spr_font_small,
	" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.,!?*()-+'", 1, 2);
	
	//colors
	#macro C_black make_color_rgb(31, 26, 46)
	#macro C_white make_color_rgb(255, 243, 212)
	#macro C_yellow make_color_rgb(237, 162, 59)
	#macro C_purple_light make_color_rgb(164, 134, 166)
	#macro C_purple_dark make_color_rgb(83, 73, 95)
	#macro C_orange_dark make_color_rgb(143, 43, 23)

	
	instance_create_depth(0,0,0,oGamepadManager);
}