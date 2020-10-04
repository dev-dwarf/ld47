// Spawns player object at coordinates.

///@param x
///@param y

function spawn_player(_x, _y)
{
	instance_create_depth(_x, _y, -_y, oPlayer);
}