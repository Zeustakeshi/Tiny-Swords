if (is_move_left) {
	move_2_target(self, x - troops_speed, y)
}

if (is_move_right) {
	move_2_target(self, x + troops_speed, y)
}

if (is_move_down) {
	move_2_target(self, x , y + troops_speed)
}


if (is_move_up) {
	move_2_target(self, x , y = troops_speed)
}

if (is_idle) {
	if (idle_animation != noone) sprite_index = idle_animation
}


if (mouse_check_button_pressed(mb_left)) {
    // Kiểm tra nếu chuột nhấn vào đối tượng
    if (position_meeting(mouse_x, mouse_y, id)) {
        is_selected = !is_selected; // Chuyển đổi trạng thái chọn
    }
}


 










