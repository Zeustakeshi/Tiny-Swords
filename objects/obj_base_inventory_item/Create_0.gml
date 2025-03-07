scale = 1.5;
item_width = 64;
item_margin = 100;
image_xscale  = scale
image_yscale = scale


function get_item_x (index) {
	var base_x = obj_inventory_board.x 
	index = index - 1;
	return base_x + (index * (item_width + item_margin))	
}

function get_item_y (index) {
	var base_y = obj_inventory_board.y
	return base_y;
}