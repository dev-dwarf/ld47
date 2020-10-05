/// @description blink timer

blink ++;

if blink > blink_max
	blink = 0;

if instance_exists(oPlayer)
{
	var _hp = 0,
		_hpMax = 0;
	
	with oPlayer
	{
		_hp = hp;
		_hpMax = max_hp;
	}
	
	player_hp_c = _hp;
	player_hpMax = _hpMax;
}

player_hp = lerp(player_hp, player_hp_c, 0.1);