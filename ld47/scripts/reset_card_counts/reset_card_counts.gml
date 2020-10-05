// Reset counts of all cards back to default values.

function reset_card_counts()
{
	instance_destroy(oCardHolder);
	instance_create_layer(0, 0, "Instances", oCardHolder);
	global.wave_count = 0;
}