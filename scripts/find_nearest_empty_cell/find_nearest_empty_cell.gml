function find_nearest_empty_cell(target_x, target_y) {
    var cell_size = global.cell_size;
    var grid_width = global.grid_width;
    var grid_height = global.grid_height;
    
    var start_x_grid = target_x div cell_size;
    var start_y_grid = target_y div cell_size;
    
    // Nếu điểm bắt đầu không bị chặn, trả về ngay tọa độ đó
    if (!is_blocked(start_x_grid, start_y_grid)) {
        return [start_x_grid, start_y_grid];
    }
    
    // Khởi tạo hàng đợi và lưới đánh dấu đã thăm
    var queue = ds_queue_create();
    var visited = ds_grid_create(grid_width, grid_height);
    ds_grid_clear(visited, 0);
    
    ds_queue_enqueue(queue, [start_x_grid, start_y_grid]);
    visited[# start_x_grid, start_y_grid] = 1;
    
    // 4 hướng di chuyển: trái, phải, lên, xuống
    var directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    
    while (!ds_queue_empty(queue)) {
        var current = ds_queue_dequeue(queue);
        var cx = current[0];
        var cy = current[1];
        
        for (var i = 0; i < 4; i++) {
            var nx = cx + directions[i][0];
            var ny = cy + directions[i][1];
            
            if (nx >= 0 && nx < grid_width && ny >= 0 && ny < grid_height) {
                if (visited[# nx, ny] == 0) {
                    visited[# nx, ny] = 1;
                    if (!is_blocked(nx, ny)) {
                        // Tìm thấy ô trống, dọn dẹp và trả về
                        ds_queue_destroy(queue);
                        ds_grid_destroy(visited);
                        return [nx, ny];
                    }
                    ds_queue_enqueue(queue, [nx, ny]);
                }
            }
        }
    }
    
    // Không tìm thấy ô trống (trường hợp hiếm), dọn dẹp và trả về giá trị mặc định
    ds_queue_destroy(queue);
    ds_grid_destroy(visited);
	
	show_debug_message(" Không tìm thấy ô trống (trường hợp hiếm), dọn dẹp và trả về giá trị mặc định")
    return [-1, -1];
}