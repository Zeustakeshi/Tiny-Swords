/// @function move_2_target(new_target_x, new_target_y)
/// @param new_target_x Tọa độ X đích
/// @param new_target_y Tọa độ Y đích
function move_2_target(new_target_x, new_target_y) {
    // Kiểm tra nếu đích mới khác đích cũ hoặc chưa tính toán đường đi
    if (target_x != new_target_x || target_y != new_target_y || !path_calculated) {
        target_x = new_target_x;
        target_y = new_target_y;
        path_calculated = false; // Đặt lại trạng thái trước khi tính toán
        
        // Tính toán đường đi bằng A*
        if (a_star_to_path(x, y, target_x, target_y, my_path)) {
            path_start(my_path, troops_speed, path_action_stop, true);
            path_calculated = true; // Đường đi đã được tính toán
        } else {
            path_end(); // Không tìm thấy đường đi thì dừng
            base_stop_move();
        }
    }
    
    // Kiểm tra khoảng cách đến đích
    var distance = point_distance(x, y, target_x, target_y);
    if (distance <= 100) {
        path_end(); // Dừng đường đi khi đến gần đích
        path_calculated = false; // Cho phép tính toán đường đi mới
        base_stop_move(); // Gọi hàm dừng từ code cũ
    }
    
    // Kiểm tra nếu đường đi bị chặn
    if (path_calculated && path_blocked()) {
        path_end();
        path_calculated = false;
        base_stop_move();
    }
}

function path_blocked() {
    var path_points = path_get_number(my_path);
    for (var i = 0; i < path_points; i++) {
        var px = path_get_point_x(my_path, i);
        var py = path_get_point_y(my_path, i);
        var grid_x = px div global.cell_size;
        var grid_y = py div global.cell_size;
        if (global.grid[# grid_x, grid_y] == 1) {
            return true; // Đường đi bị chặn
        }
    }
    return false;
}