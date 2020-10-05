/// @description
if (i_frames > 0) i_frames -= 1;

var inst = instance_place(x,y,oSword);
if (inst and ((inst.swing) or (oPlayer.state == player_states.dash or oPlayer.dash_not_ready)) and i_frames <= 0) and state != enemy_states.dead {
	oPlayer.hits_this_time++;
	
	if (state == enemy_states.dead) {
		play_sound(sndSwordHit, 0, false, 1.0 + 0.075 * oPlayer.consecutive_sword_hits, 0.02, 0.2);
	
	} else {
		play_sound(sndSwordHit, 0, false, 1.0 + 0.075 * oPlayer.consecutive_sword_hits, 0.02, 1.0);
		
	}
	
	var yy = irandom_range(sprite_height/2,-sprite_height/2);
	var xx = irandom_range(sprite_width/2,-sprite_width/2);
	
	with instance_create_layer(x+xx,y+yy,-1000,oObjPari){ image_angle = irandom_range(0,360); sprite_index = sHit;}
	
	hp -= oPlayer.hit_damage;
	knockback = 4 + oPlayer.sword_size;
	knockback_dir = point_direction(oPlayer.x, oPlayer.y, x,y);
	
	if (hp <= 0) {
		i_frames = 10;
		state = enemy_states.dead;
		
		
		
		if (can_explode) {
			play_sound(sndEnemyDeath, 0, false, 0.8, 0.2, 0.8);	
			
			oPlayer.make_dust(x,y,8,sprite_width);
			
			var c= 4-irandom(2);
			for(var i = 0; i < c;i++) {
				with instance_create_layer(x,y - sprite_height*0.5,layer,oBits) {
					sprite_index = other.bits_index;
					image_index = i;
				}
			}
			instance_destroy();
		}
		
		if (oCardHolder.counts[card.good][good_cards.bomb_slice]) and can_explode {
			with instance_create_layer(x,y - sprite_height*0.5,layer,oExplosion) {
				image_xscale = 1 + 0.1 * 
				oCardHolder.counts[card.good][good_cards.bomb_slice];
				
				image_yscale = image_xscale;
			}
		}
	
	} else {
		i_frames = 10;
		inst.i_frames = 10;
		oCamera.set_shake( 0.1);
		
		if oPlayer.leach > 0 {
			oPlayer.hp += oPlayer.leach*oPlayer.hit_damage;	
		}
	}
}

move(knockback,knockback_dir);
knockback = lerp(knockback, 0, 0.7);