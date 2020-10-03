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
	
	switch _debuff
	{
		case bad_cards.buzz_saws:
		sd = spr_card_debuff_test;
		break;
	}
	
	//debug/testing
	sb = spr_card_bigSword;
	sd = spr_card_debuff_test;
	
	spr_buff = sb;
	spr_debuff = sd;
}