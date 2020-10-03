
function globals(){
	gml_pragma("global", "globals()")
	
	#region gamepad
	global.gamepad_connected	= false;
	global.gamepad_slot			= false;
	global.gamepad_is_xbox		= false;
	#endregion
	
	global.set_window = false;
	global.fullscreen = false;
	
	global.master_volume = 0.75; 
	global.sound_volume = 1.0 * global.master_volume;
	global.music_volume = 1.0 * global.master_volume;
	
	global.sword_count = 1;
	global.sword_id = 0;
	
	global.gui_scale = 0;
	global.set_window= false;
	
	//fonts
	global.font_large = font_add_sprite_ext(spr_font_large,
	" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.,!?*()-+", 1, 0);

	
	instance_create_depth(0,0,0,oGamepadManager);
}