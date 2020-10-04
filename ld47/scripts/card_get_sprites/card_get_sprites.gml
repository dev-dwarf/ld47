// Get buff/debuff icon sprites for card.

///@arg buff
///@arg debuff

function card_get_sprites(_buff, _debuff)
{
	var _id_buff = "spr_card_buff_" + string(_buff),
		_id_debuff = "spr_card_debuff_" + string(_debuff),
		_sprite_buff = asset_get_index(_id_buff),
		_sprite_debuff = asset_get_index(_id_debuff);
	
	spr_buff = _sprite_buff;
	spr_debuff = _sprite_debuff;
}