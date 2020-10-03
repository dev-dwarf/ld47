
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

	
	instance_create_depth(0,0,0,oGamepadManager);
}