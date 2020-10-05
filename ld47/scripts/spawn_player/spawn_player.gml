// Spawns player object at coordinates.

///@param x
///@param y

function spawn_player(_x, _y)
{
	return instance_create_layer(_x, _y, "Instances", oPlayer);
}