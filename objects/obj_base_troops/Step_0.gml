depth = -y;



if (is_move_left) {
	move_2_target( x - troops_speed, y)
}

if (is_move_right) {
	move_2_target( x + troops_speed, y)
}

if (is_move_down) {
	move_2_target( x , y + troops_speed)
}


if (is_move_up) {
	move_2_target(x , y = troops_speed)
}

if (is_idle && idle_animation != noone) {
	sprite_index = idle_animation
}


if (is_attack_top && attack_top_animation != noone) {
	sprite_index = attack_top_animation
}

if (is_attack_down && attack_down_animation != noone) {
	sprite_index = attack_down_animation
}

if (is_attack_left && attack_left_animation != noone) {
	sprite_index = attack_left_animation
}

if (is_attack_right && attack_right_animation != noone) {
	sprite_index = attack_right_animation
}
 

// detroy when health = 0 (is died :<)
if (current_health == 0) {
	instance_destroy();
}

    

if (path_calculated && path_position < 1) {
    // Lấy điểm tiếp theo trong path
    var current_index = floor(path_position * (path_get_number(my_path) - 1));
    var next_x = path_get_point_x(my_path, current_index + 1);
    var next_y = path_get_point_y(my_path, current_index + 1);
    
    // Tính hướng từ vị trí hiện tại đến điểm tiếp theo
    var path_dir = point_direction(x, y, next_x, next_y);
    
    // Xác định hướng chính dựa trên giá trị lớn hơn
    if (path_dir < 180) {
            image_xscale = -troops_scale; // Quay phải
            if (run_animation != noone) sprite_index = run_animation;
    } else {
        image_xscale = troops_scale; // Quay trái
        if (run_animation != noone) sprite_index = run_animation;
    }

}




