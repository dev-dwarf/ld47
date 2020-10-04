/// @description
image_angle = angle_lerp(image_angle, -360 * (global.wave_count mod 12)/12, 0.2);

x =  room_width/2 - oCamera.screenshake_x;
y = room_height/2 - oCamera.screenshake_y;