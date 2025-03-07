function init_grid() {
    global.grid = ds_grid_create(global.grid_width, global.grid_height);
    ds_grid_clear(global.grid, 0);

    for (var i = 0; i < global.grid_width; i++) {
        for (var j = 0; j < global.grid_height; j++) {
            var cell_left = i * global.cell_size;
            var cell_top = j * global.cell_size;
            var cell_right = cell_left + global.cell_size;
            var cell_bottom = cell_top + global.cell_size;

            var is_blocked = false;
            if (position_meeting(cell_left, cell_top, obj_base_solid) || 
                position_meeting(cell_right, cell_top, obj_base_solid) || 
                position_meeting(cell_left, cell_bottom, obj_base_solid) || 
                position_meeting(cell_right, cell_bottom, obj_base_solid)) {
                is_blocked = true;
            }

            global.grid[# i, j] = is_blocked ? 1 : 0;
        }
    }
	
	
}

function draw_gird () {

	var view_x = camera_get_view_x(view_camera[0]);
	var view_y = camera_get_view_y(view_camera[0]);
	var view_w = camera_get_view_width(view_camera[0]);
	var view_h = camera_get_view_height(view_camera[0]);

	for (var i = floor(view_x / global.cell_size); i < ceil((view_x + view_w) / global.cell_size); i++) {
	    for (var j = floor(view_y / global.cell_size); j < ceil((view_y + view_h) / global.cell_size); j++) {
	        if (i >= 0 && i < global.grid_width && j >= 0 && j < global.grid_height) {
	            var cell_x = i * global.cell_size;
	            var cell_y = j * global.cell_size;

	            // Kiểm tra nếu ô này bị chặn bởi obj_solid
	            if (global.grid[# i, j] == 1) {
	                draw_set_color(c_red); // Màu đỏ cho ô bị chặn
	            } else {
	                draw_set_color(c_gray); // Màu xám cho ô trống
	            }
	            draw_rectangle(cell_x, cell_y, cell_x + global.cell_size, cell_y + global.cell_size, false);

	            // Vẽ viền đen
	            draw_set_color(c_black);
	            draw_rectangle(cell_x, cell_y, cell_x + global.cell_size, cell_y + global.cell_size, true);
	        }
		}
	}
}
