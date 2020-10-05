/// @description variables

player_hp_c = 0;
player_hp = 0;
player_hpMax = 0;

blink = 0;
blink_max = room_speed * 5;

depth = -room_height * 10;

//get hp
if instance_exists(oPlayer)
{
	player_hp_c = oPlayer.hp;
	player_hpMax = oPlayer.max_hp;
	player_hp = player_hp_c;
}
