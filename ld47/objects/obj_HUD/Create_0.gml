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

//boss hp
boss_hp_c = 0;
boss_hp = 0;
boss_hpMax = 0;

depth = -room_height * 10;

//get variables from player && boss
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
if instance_exists(oBoss)
{
	boss_hp_c = oBoss.hp;
	boss_hp = boss_hp_c;
	boss_hpMax = oBoss.hpMax;
}
