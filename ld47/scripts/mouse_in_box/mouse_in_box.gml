// Checks if mouse is in object's collision mask.

function mouse_in_box()
{
	return point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom);
}