// Inherit the parent event
event_inherited();

if (mouse_check_button_pressed(mb_left)) {
	if (mouse_x >= bbox_left && mouse_x <= bbox_right &&
        mouse_y >= bbox_top && mouse_y <= bbox_bottom) {
      base_is_selected = true;
    }else {
		base_is_selected = false;
	}
	
}

