if (is_selected) {

	var border_scale_x = (sprite_get_width(sprite_index) / sprite_get_width(pointer_02)) * 0.5;
    var border_scale_y = (sprite_get_height(sprite_index) / sprite_get_height(pointer_02)) * 0.5;
	
	draw_sprite_ext(
        pointer_02, 0, x, y,
        border_scale_x, border_scale_y,
        0, c_white, 1
    );
	
	

}



// draw_set_color(c_red);

// draw_circle(x, y, detection_radius, true); // Đường viền

draw_self()

// draw health bar
draw_health_bar(clamp(current_health, 0, max_health), max_health);




