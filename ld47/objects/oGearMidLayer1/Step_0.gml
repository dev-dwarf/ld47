/// @description
image_angle += 20/sprite_width;

if (!instance_exists(oPlayer)) exit;

x = lerp(x, xstart + (oPlayer.x-oPlayer.xstart)*parralax_percent, 0.2);
y = lerp(y, ystart + (oPlayer.y-oPlayer.ystart)*parralax_percent, 0.2);
