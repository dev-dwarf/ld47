/// @description
image_xscale *= draw_flip;
y += y_off;
// Inherit the parent event
event_inherited();
y -= y_off;
image_xscale /= draw_flip;
