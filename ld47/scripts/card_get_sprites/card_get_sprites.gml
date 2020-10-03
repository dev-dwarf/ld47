// Get buff/debuff icon sprites for card.

///@arg buff
///@arg debuff

function card_get_sprites(_buff, _debuff)
{
	var sb = 0,//buff sprite
		sd = 0;//debuff sprite
		
	switch _buff
	{
		case good_cards.bigger_swords:
		sb = spr_card_bigSword;
		break;
		
		//
	}
	
	/*
	switch _debuff:
	{
		//
	}
	*/
	
	//debug/testing
	sb = spr_card_bigSword;
	sd = sb;
	
	spr_buff = sb;
	spr_debuff = sd;
}