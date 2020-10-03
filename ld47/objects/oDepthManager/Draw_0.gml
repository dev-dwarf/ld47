/// @description
if (!ds_exists(depth_grid, ds_type_grid)) exit;

for (var i = 0; i < ds_grid_height(depth_grid); i++) {
	var inst = depth_grid[# 0, i];
	
	if (is_undefined(inst) or !instance_exists(inst)) {
		//ds_grid_delete_row(depth_grid, i);
		continue;
	}
	
	with (inst) { // run the instance's draw event
		event_perform(ev_draw, 0);
	}
}