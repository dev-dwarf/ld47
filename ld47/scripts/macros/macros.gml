function MACROS() {
	#macro DEFAULT_WIDTH 552	
	#macro DEFAULT_HEIGHT 361

	#region input stuff
	#macro vk_a ord("A")
	#macro vk_s ord("S")
	#macro vk_d ord("D")
	#macro vk_f ord("F")
	#macro vk_w ord("W")
	#macro vk_r ord("R")
	#macro vk_z ord("Z")
	#macro vk_x ord("X")
	#macro vk_c ord("C")
	#macro vk_v ord("V")
	#macro vk_e ord("E")
	#macro vk_q ord("Q")
	#macro vk_j ord("J")
	#macro vk_k ord("K")
	#macro vk_l ord("L")
	#macro vk_colon 186
	#macro NEWLINE chr(10)

	#macro check keyboard_check
	#macro check_p keyboard_check_pressed
	#macro check_r keyboard_check_released
	
	#macro gp_a gp_face1
	#macro gp_b gp_face2
	#macro gp_x gp_face3
	#macro gp_y gp_face4
	#macro gp_lb gp_shoulderlb
	#macro gp_l gp_shoulderl
	#macro gp_rb gp_shoulderrb
	#macro gp_r gp_shoulderr

	#macro g_check gamepad_button_check
	#macro g_check_p gamepad_button_check_pressed
	#macro g_check_r gamepad_button_check_released
	
	#macro m_check mouse_check_button
	#macro m_check_p mouse_check_button_pressed
	#macro m_check_r mouse_check_button_released
	#endregion

	#macro log show_debug_message
	#macro show show_message

	#macro LEVEL_EDITOR_ENABLED false
	#macro SAVEFILE "save.ini"
}