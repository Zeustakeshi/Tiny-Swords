function is_block_here(x, y){
	var cell_size = global.cell_size;
    var target_x_grid = x div cell_size;
    var target_y_grid = y div cell_size;
	
	return is_blocked(target_x_grid, target_y_grid);
	
}