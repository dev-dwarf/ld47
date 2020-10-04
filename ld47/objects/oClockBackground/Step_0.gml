/// @description


var ga = 0;
if (instance_exists(oExitPortal)) {
	active = lerp(active, 1.5, 0.1);
	var ga = glow_alpha_base + glow_alpha_vary * sin(current_time*0.001*3);

} else {	 
	active = lerp(active, 0.0, 0.1);
}

if (instance_exists(con_cardSelection)) ga = 0;

glow_alpha = lerp(glow_alpha, ga, 0.5);

if (!instance_exists(oPlayer)) exit;

x = lerp(x, room_width/2  + (oPlayer.x-oPlayer.xstart)*parralax_percent, 0.2);
y = lerp(y, room_height/2 + (oPlayer.y-oPlayer.ystart)*parralax_percent, 0.2);
