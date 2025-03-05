grid_size = 32; // Kích thước ô
grid_width = room_width div grid_size; // Số ô theo chiều rộng
grid_height = room_height div grid_size; // Số ô theo chiều cao


/// @func is_walkable(x, y)
function is_walkable(grid_x, grid_y) {
    // Kiểm tra xem ô (grid_x, grid_y) có vật cản không
    var cell_x = grid_x * grid_size;
    var cell_y = grid_y * grid_size;
    return !instance_place(cell_x, cell_y, obj_soild);
}

/// @func find_path(start_x, start_y, target_x, target_y)
function find_path(start_x, start_y, target_x, target_y) {
    // Chuyển tọa độ pixel sang grid
    var start_x_grid = start_x div grid_size;
    var start_y_grid = start_y div grid_size;
    var target_x_grid = target_x div grid_size;
    var target_y_grid = target_y div grid_size;
    
    // Kiểm tra điểm đích có hợp lệ
    if (!is_walkable(target_x_grid, target_y_grid)) return [];
    
    // Khởi tạo open list, closed list, và came_from
    var open_list = ds_priority_create(); // Dùng priority queue để ưu tiên node có F_cost thấp
    var closed_list = ds_list_create();
    var came_from = ds_map_create();
    
    // Thêm node bắt đầu vào open list
    var start_key = start_x_grid + "_" + start_y_grid;
    ds_priority_add(open_list, start_key, 0);
    came_from[? start_key] = {
        parent: noone,
        g_cost: 0,
        h_cost: heuristic(start_x_grid, start_y_grid, target_x_grid, target_y_grid)
    };
    
    while (!ds_priority_empty(open_list)) {
        // Lấy node có F_cost thấp nhất
        var current_key = ds_priority_delete_min(open_list);
        var current_x = real(string_copy(current_key, 1, string_pos("_", current_key) - 1));
        var current_y = real(string_copy(current_key, string_pos("_", current_key) + 1, string_length(current_key)));
        
        // Thêm vào closed list
        ds_list_add(closed_list, current_key);
        
        // Kiểm tra đích đến
        if (current_x == target_x_grid && current_y == target_y_grid) {
            ds_priority_destroy(open_list);
            ds_list_destroy(closed_list);
            return reconstruct_path(came_from, current_key);
        }
        
        // Duyệt 4 hướng
        var directions = [
            {dx: -1, dy: 0}, // Trái
            {dx: 1, dy: 0},  // Phải
            {dx: 0, dy: -1}, // Lên
            {dx: 0, dy: 1}   // Xuống
        ];
        
        for (var i = 0; i < array_length(directions); i++) {
            var dir = directions[i];
            var neighbor_x = current_x + dir.dx;
            var neighbor_y = current_y + dir.dy;
            
            // Kiểm tra ô hợp lệ và không có vật cản
            if (neighbor_x < 0 || neighbor_x >= grid_width || neighbor_y < 0 || neighbor_y >= grid_height) continue;
            if (!is_walkable(neighbor_x, neighbor_y)) continue;
            
            // Tạo key cho neighbor
            var neighbor_key = neighbor_x + "_" + neighbor_y;
            
            // Kiểm tra neighbor đã ở trong closed list chưa
            if (ds_list_find_index(closed_list, neighbor_key) != -1) continue;
            
            // Tính toán G_cost và H_cost
            var current_g = came_from[? current_key].g_cost;
            var new_g = current_g + 1;
            
            // Kiểm tra neighbor đã có trong open list chưa
            if (!ds_priority_find(open_list, neighbor_key)) {
                // Thêm vào open list
                var h_cost = heuristic(neighbor_x, neighbor_y, target_x_grid, target_y_grid);
                var f_cost = new_g + h_cost;
                ds_priority_add(open_list, neighbor_key, f_cost);
                came_from[? neighbor_key] = {
                    parent: current_key,
                    g_cost: new_g,
                    h_cost: h_cost
                };
            } else {
                // Nếu đã tồn tại, kiểm tra nếu đường đi mới tốt hơn
                var existing_g = came_from[? neighbor_key].g_cost;
                if (new_g < existing_g) {
                    // Cập nhật G_cost và parent
                    came_from[? neighbor_key].g_cost = new_g;
                    came_from[? neighbor_key].parent = current_key;
                }
            }
        }
    }
    
    // Không tìm thấy đường
    ds_priority_destroy(open_list);
    ds_list_destroy(closed_list);
    ds_map_destroy(came_from);
    return [];
}

/// @func heuristic(x1, y1, x2, y2) 
function heuristic(x1, y1, x2, y2) {
    return abs(x1 - x2) + abs(y1 - y2); // Manhattan distance
}

/// @func reconstruct_path(came_from, current_key)
function reconstruct_path(came_from, current_key) {
    var path = ds_list_create();
    while (came_from[? current_key].parent != noone) {
        // Chuyển key thành tọa độ
        var _x = real(string_copy(current_key, 1, string_pos("_", current_key) - 1));
        var _y = real(string_copy(current_key, string_pos("_", current_key) + 1, string_length(current_key)));
        ds_list_add(path, {x: _x, y: _y});
        current_key = came_from[? current_key].parent;
    }
    ds_list_reverse(path);
    return path;
}