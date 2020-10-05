/// @description HUD behavior

blink ++;

if blink > blink_max
	blink = 0;

if instance_exists(oPlayer)
{
	var _hp = 0,
		_hpMax = 0,
		_laser = 0;
	
	with oPlayer
	{
		_hp = hp;
		_hpMax = max_hp;
		_laser = laser_available;
	}
	
	//laser bounce
	if player_laser < _laser && _laser == 1
	{
		laser_off = 8;
		laser_flash = 10;
		
		//play laser charged up sound
		play_sound(sndLaser, 10, 0, 1, 0.04, global.sound_volume);
	}
	
	player_hp_c = _hp;
	player_hpMax = _hpMax;
	player_laser = _laser;
}
if instance_exists(oBoss)
{
	boss_hp_c = oBoss.hp;
	boss_hpMax = oBoss.hpMax;
}

player_hp = lerp(player_hp, player_hp_c, 0.1);
boss_hp = lerp(boss_hp, boss_hp_c, 0.1);

if laser_off > 0
	laser_off = lerp(laser_off, 0, 0.15);
if laser_flash > 0
	laser_flash --;