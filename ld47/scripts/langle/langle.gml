///@param direction_current
///@param direction_target
///@param lerp_speed
function langle(argument0, argument1, argument2) {

	var _dir_current = argument0,//Current angle
		_dir_target = argument1,//Angle that you want to lerp to	
		_lerp = argument2;//Lerp value (must be from 0-1)
	
	// First, get difference (in degrees) between source and destination angles
	var _angle_difference = max(_dir_current, _dir_target) - min(_dir_current, _dir_target);

	// Now, determine the sign of the lerp. Positive is counterclockwise, and negative is clockwise.
	var _sign = 1;

	// If the target angle is less than the current angle (meaning the rotation will be clockwise), set
	// the lerp sign to -1.
	if _dir_target < _dir_current
		_sign = -1;
	
	// Now, multiply the angle difference by the lerp value to get the amount to 
	// increase/decrease current angle by
	var _angDiff = (_angle_difference) * _lerp;

	// Get the new angle by applying the lerp.
	var _newDir = _dir_current + (_angDiff * _sign);

	// Return the new angle. You're all done!
	return _newDir;


}
