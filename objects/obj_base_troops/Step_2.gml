

// Xử lý khi đến đích (path_position == 1)
if (path_position == 1) {
    path_end();
    path_calculated = false;
    if (idle_animation != noone) {
        sprite_index = idle_animation;
    }
}


if (path_calculated && path_position < 1) {
    // Lấy điểm tiếp theo trong path
    var current_index = floor(path_position * (path_get_number(my_path) - 1));
    var next_x = path_get_point_x(my_path, current_index + 1);
    var next_y = path_get_point_y(my_path, current_index + 1);
    
    // Xác định hướng dựa trên delta x (khác biệt giữa next_x và x)
    var delta_x = next_x - x;
    
    // Quyết định quay trái/phải
    if (delta_x > 0) {
        image_xscale = -troops_scale; // Quay phải (nếu delta_x dương → di chuyển sang phải)
    } else if (delta_x < 0) {
        image_xscale = troops_scale;  // Quay trái (nếu delta_x âm → di chuyển sang trái)
    }
    
    // Cập nhật animation (nếu có)
    if (is_idle && run_animation != noone) {
        sprite_index = run_animation;
    }
}


