/// @desc draw_billboard_sprite
/// @param sprite_index	
/// @param image_index
/// @param x				
/// @param y			
/// @param z
/// @param image_xscale	
/// @param image_yscale	
/// @param image_blend	
/// @param image_alpha	
/// @param orthog_z?
function draw_billboarded_sprite() {
	var _sprite_index	= argument[0];
	var _image_index	= argument[1];
	var _x				= argument[2];
	var _y				= argument[3];
	var _z				= argument[4]  * oCamera.image_zscale;
	var _image_xscale	= argument[5];
	var _image_yscale	= argument[6];
	var _image_blend	= argument[7];
	var _image_alpha	= argument[8];
	
	var _z_orthog = 0;
	if (argument_count > 9) {
		_z_orthog = argument[9] * -1;	
	}
							   
	var _camera_stretch = oCamera.stretch_factor;
	var _adjusted_angle = -oCamera.angle 

	_image_yscale *= _camera_stretch;

	draw_sprite_ext(_sprite_index, _image_index, _x - _z * oCamera.x_step - _z_orthog * oCamera.y_step, _y - _z * oCamera.y_step + _z_orthog * oCamera.x_step, _image_xscale, _image_yscale, _adjusted_angle, _image_blend, _image_alpha);
}

/// @desc draw_stacked_sprite_ext
/// @param sprite_index
/// @param x
/// @param y
/// @param z
/// @param image_xscale
/// @param image_yscale
/// @param image_zscale
/// @param image_angle
/// @param wobble?
/// @param wind?
/// @param height?
function draw_stacked_sprite_ext() {
	var _sprite_index	= argument[0];
	var _x				= argument[1];
	var _y				= argument[2];
	var _z				= argument[3];
	var _image_xscale	= argument[4];
	var _image_yscale	= argument[5];
	var _image_zscale	= argument[6];
	var _image_angle	= argument[7];
	//var image_alpha //making alpha work with sprite stacking is out of scope of this tutorial

	var _shake = 0;
	if (argument_count > 8) {
		_shake = argument[8];
	} 

	var wind = 0;
	if (argument_count > 9) {
		wind = argument[9];
	} 
	
	if (argument_count > 10) {
		var _z_height = argument[10]	
	} else {
		var _z_height = sprite_get_number(_sprite_index);
	
	}

	_image_zscale *= oCamera.image_zscale;

	// compute the amount we move each layer by
	// default direction is up (90*), and from there we want the opposite of the camera angle
	var _x_step = oCamera.x_step * _image_zscale;
	var _y_step = oCamera.y_step * _image_zscale;
	var _z_step = oCamera.z_step;
	
	var _xz = _x_step * _z;
	var _yz = _y_step * _z;
	
	_x_step *= _z_step;
	_y_step *= _z_step;

	// loop through each slice of the sprite, moving by x and y step each time
	for (var i = 0; i < _z_height; i += _z_step) {
		draw_sprite_ext(_sprite_index, i, _x - _xz + random_range(-_shake, _shake), _y - _yz + random_range(-_shake, _shake), _image_xscale, _image_yscale, _image_angle + (dsin(current_time * 0.1 + i * 2)) * wind, image_blend, 1.0);
		_xz += _x_step;
		_yz += _y_step;
	}
}

/// @desc draw_imitation_sprite
/// @param sprite_index	
/// @param image_index
/// @param x				
/// @param y			
/// @param z
/// @param image_xscale	
/// @param image_yscale	
/// @param image_angle	
/// @param image_blend	
/// @param image_alpha	
function draw_imitation_sprite() {
	var _sprite_index	= argument[0];
	var _image_index	= argument[1];
	var _x				= argument[2];
	var _y				= argument[3];
	var _z				= argument[4];
	var _image_xscale	= argument[5];
	var _image_yscale	= argument[6];
	var _image_angle	= argument[7];
	var _image_blend	= argument[8];
	var _image_alpha	= argument[9];
							   
	var _camera_stretch = oCamera.imitation_sprite_stretch//power(oCamera.image_zscale/oCamera.zscale_min, 1.3);
	var _adjusted_angle = _image_angle-oCamera.angle 
	
	//var _width = sprite_get_width(_sprite_index);
	//var _height = sprite_get_height(_sprite_index);


	_image_yscale *= _camera_stretch;

	draw_sprite_ext(_sprite_index, _image_index, _x - _z * oCamera.x_step, _y - _z * oCamera.y_step, _image_xscale, _image_yscale, _adjusted_angle, _image_blend, _image_alpha);
	
	//draw_sprite_pos(_sprite_index, _image_index, 

	//_x - _z * oCamera.x_step - _image_xscale * _width/2, 
	//_y - _z * oCamera.y_step - _image_yscale * _height,
	
	//_x - _z * oCamera.x_step + _image_xscale * _width/2, 
	//_y - _z * oCamera.y_step - _image_yscale * _height,
	
	//_x - _z * oCamera.x_step + _image_xscale * _width/2, 
	//_y - _z * oCamera.y_step,  
	
	//_x - _z * oCamera.x_step - _image_xscale * _width/2, 
	//_y - _z * oCamera.y_step, 

	//1.0);
}