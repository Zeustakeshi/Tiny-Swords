if (is_move_left) {
	if (!place_meeting(x - troops_speed, y, obj_base_solid)) {
		x -= troops_speed
	}
	image_xscale = -troops_scale;
	if (run_animation != noone) sprite_index = run_animation;
}

if (is_move_right) {

	if (!place_meeting(x + troops_speed, y, obj_base_solid)) {
		x += troops_speed
	}
	
	image_xscale = troops_scale;
	if (run_animation != noone) sprite_index = Archer_Blue_run;


}

if (is_move_down) {
	if (!place_meeting(x, y + troops_speed, obj_base_solid)) {
		   y += troops_speed
	}


}



if (is_move_up) {
	if (!place_meeting(x, y - troops_speed, obj_base_solid)) {
		   y -= troops_speed
	}
}

if (is_idle) {
	if (idle_animation != noone) sprite_index = idle_animation
}








if (mouse_check_button_pressed(mb_left)) {
    // Kiểm tra nếu chuột nhấn vào đối tượng
    if (position_meeting(mouse_x, mouse_y, id)) {
        is_selected = !is_selected; // Chuyển đổi trạng thái chọn
    } else {
        is_selected = false; // Bỏ chọn nếu nhấn ra ngoài
    }
}













