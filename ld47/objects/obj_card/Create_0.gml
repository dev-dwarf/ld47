/// @description variables

//sprite-related
spr_buff = 0;
spr_debuff = 0;
xS = 1;//x scale
scale = 1;//general scale
angle = 0;
y_off = 0;//offset of drawn y compared to actual y
frame_arrow = 0;//frame of selection arrow

//card data
card_buff = 0;
card_debuff = 0;
card_flipped = false;//is the card flipped? if false, it will show the card's "good" side
card_selected = false;//has the player selected this card?
card_priority = 0;//card's priority (mainly just determines its depth & where it moves)

//movement
xT = x;//x target
yT = y;//y target