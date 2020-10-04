/// @description
if (!instance_exists(oPlayer)) exit;

x = lerp(x, room_width/2  + (oPlayer.x-oPlayer.xstart)*parralax_percent, 0.2);
y = lerp(y, room_height/2 + (oPlayer.y-oPlayer.ystart)*parralax_percent, 0.2);