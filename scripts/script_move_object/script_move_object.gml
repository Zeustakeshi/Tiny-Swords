function move_2_target(obj, target_x, target_y) {
    if (!instance_exists(obj)) return;

    var distance = point_distance(obj.x, obj.y, target_x, target_y);

    if (distance > obj.troops_speed) {
        // Tính hướng di chuyển
        var dir = point_direction(obj.x, obj.y, target_x, target_y);
        
        // Chuẩn hóa vector để tốc độ không đổi
        var dx = lengthdir_x(1, dir); // Thành phần x của hướng
        var dy = lengthdir_y(1, dir); //   Thành phần y của hướng
		
		var new_x = obj.x + dx * obj.troops_speed;
        var new_y = obj.y + dy * obj.troops_speed;
         
        if (!place_meeting(new_x, new_y, obj_base_solid)) { 
            obj.x = new_x;
            obj.y = new_y;
        } else {
            // Nếu không di chuyển được cả hai, thử từng trục
            if (!place_meeting(new_x, obj.y, obj_base_solid)) {
                obj.x = new_x;
            }
            if (!place_meeting(obj.x, new_y, obj_base_solid)) {
                obj.y = new_y;
            }
        }
		
		// Cập nhật animation và hướng sprite
        if (dx != 0 || dy != 0) {
            if (dx > 0) {
                obj.image_xscale = obj.troops_scale; // Quay phải
                if (obj.run_animation != noone) obj.sprite_index = obj.run_animation;
            } else if (dx < 0) {
                obj.image_xscale = -obj.troops_scale; // Quay trái
                if (obj.run_animation != noone) obj.sprite_index = obj.run_animation;
            }
            // Thêm xử lý animation cho di chuyển lên/xuống nếu cần
        }
    } else {
        obj.base_stop_move();
    }
}