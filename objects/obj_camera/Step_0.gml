 var border_size = 20


if (follow != noone) {
	
	xTo = follow.x;
    yTo = follow.y;
    x += (xTo - x) / 25;
    y += (yTo - y) / 25;
	
}else {
	var screen_mouse_x = window_mouse_get_x();
    var screen_mouse_y = window_mouse_get_y();
    var screen_width = window_get_width();
    var screen_height = window_get_height();
	
	var move_x = 0;
    var move_y = 0;
	
	if screen_mouse_x < border_size {
        move_x = -camera_speed;
    } else if screen_mouse_x > screen_width - border_size {
        move_x = camera_speed;
    }
	
	
	if screen_mouse_y < border_size {
        move_y = -camera_speed;
    } else if screen_mouse_y > screen_height - border_size {
        move_y = camera_speed;
    }
	
	
	x += move_x;
    y += move_y;
	
}

var cam = view_camera[0];
var view_w = camera_get_view_width(cam);
var view_h = camera_get_view_height(cam);

// Giới hạn không cho camera vượt khỏi phòng
x = clamp(x, view_w * 0.5, room_width - view_w * 0.5);
y = clamp(y, view_h * 0.5, room_height - view_h * 0.5);

camera_set_view_pos(cam, x - (camera_width * 0.5), y - (camera_height * 0.5))