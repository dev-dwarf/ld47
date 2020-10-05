/// @description variables

//hp
player_hp_c = 0;
player_hp = 0;
player_hpMax = 0;

//laser
player_has_laser = false;
player_laser = 0;
laser_off = 0;
laser_flash = 0;

//blinking heart
blink = 0;
blink_max = room_speed * 5;

depth = -room_height * 10;

//get variables from player
if instance_exists(oPlayer)
{
	//hp
	player_hp_c = oPlayer.hp;
	player_hpMax = oPlayer.max_hp;
	player_hp = player_hp_c;
	
	//laser
	player_has_laser = oPlayer.has_laser;
	player_laser = oPlayer.laser_available;
}
