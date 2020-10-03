// Applies a card's buff and debuff.

function apply_card()
{
	var _buff = card_buff,
		_debuff = card_debuff;
		
	with oCardHolder
	{
		counts[card.good][_buff] ++;
		counts[card.bad][_debuff] ++;
	}
}