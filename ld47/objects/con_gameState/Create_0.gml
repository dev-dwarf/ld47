/// @description variables
if (instance_number(object_index) > 1) instance_destroy();

rad = room_width;//overlay radius
gameState = "startup";//current state of the game
y_title = -room_height;//y to draw title screen at
y_title_text = room_height + 30;
tt_float = 0;//floating variable for title
tt = 0;//generic timer variable
rot_title = 0;

tutorial_completeted = file_exists("tutorial.done");