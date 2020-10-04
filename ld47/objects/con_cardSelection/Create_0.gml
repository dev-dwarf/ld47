/// @description variables

oCamera.subpixel_level = 2;
oCamera.alarm[0] = 1;

transition_radius = 0;//radius of transition circle
cardSel_state = "startup_transition";//current state of card selection screen
tt = 0;//generic timer variable
tt_text = 0;//timer for text floating
tt_flash = 0;//timer for flash
error_off = 0;
depth = -(room_height * 1.5);

//particles
sys = part_system_create();
part_system_depth(sys, depth - 1);

part_star = part_type_create();
part_type_sprite(part_star, spr_part_sparkle, 1, 1, 0);
part_type_life(part_star, 30, 60);