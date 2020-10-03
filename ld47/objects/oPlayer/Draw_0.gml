/// @description

var blend = image_blend;
//if (state == player_states.dash or dash_not_ready) blend ;

//draw_sprite_ext(sPlayerShadow, image_index, x, y, draw_scale*image_xscale, draw_scale*image_yscale, image_angle, blend, image_alpha*0.3);

// Draw Dash Fade
if (i_frames > 1 and round(i_frames/3) mod 2) {
	shader_set(shFlash);
	draw_self();	
	draw_sprite_ext(sprite_index, image_index, x, y, draw_scale*image_xscale, draw_scale*image_yscale, image_angle, blend, image_alpha);
	shader_reset();
	instance_create_layer(x,y,"FX",oHurtShadow)
} else
if (state == player_states.dash or dash_not_ready){
	shader_set(shFlash);
	draw_self();	
	draw_sprite_ext(sprite_index, image_index, x, y, draw_scale*image_xscale, draw_scale*image_yscale, image_angle, blend, image_alpha);
	shader_reset();
	instance_create_layer(x,y,"FX",oDashShadow)
} else {
	draw_sprite_ext(sprite_index, image_index, x, y, draw_scale*image_xscale, draw_scale*image_yscale, image_angle, blend, image_alpha);
}