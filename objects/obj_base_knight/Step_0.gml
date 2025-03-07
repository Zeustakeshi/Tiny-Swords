// Inherit the parent event
event_inherited();


if (is_selected) {
	if (instance_exists(obj_flag)) {
		move_2_target( obj_flag.x, obj_flag.y)
	}
}



if (mouse_check_button_pressed(mb_left)) {
    // Kiểm tra nếu chuột nhấn vào đối tượng
    if (position_meeting(mouse_x, mouse_y, id)) {
        is_selected = !is_selected; // Chuyển đổi trạng thái chọn
    }
}


 