/// @description

var temp_x = x; var temp_y = y;

x += draw_x; y += draw_y;
y += y_off;

// Inherit the parent event
event_inherited();

y -= y_off;
x = temp_x; y = temp_y;