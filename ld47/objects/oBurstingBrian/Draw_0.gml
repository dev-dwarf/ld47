/// @description

var temp_x = x; var temp_y = y;

x += draw_x; y += draw_y;

// Inherit the parent event
event_inherited();

x = temp_x; y = temp_y;