//	Creates a card at the specified x/y coordinates with a random buff/debuff associated with it.

//	Script also needs the card's "priority" as an input, which essentially tells us where it's gonna
//	move to once the cards fan out after spawning.

///@arg x
///@arg y
///@arg priority
///@arg buff
///@arg debuff

function spawn_card(_x, _y, _pri, _buff, _debuff)
{
	var _d = -(room_height * 2) + _pri;//depth to spawn card at
	
	with instance_create_depth(_x, _y, _d, obj_card)
	{
		card_buff = _buff;
		card_debuff = _debuff;
		card_priority = _pri;
		
		//get card sprites
		card_get_sprites(_buff, _debuff);
	}
}