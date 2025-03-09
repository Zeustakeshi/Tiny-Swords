function find_nearest_target(source, target_types) {
    var nearest_target = noone ;  // Đối tượng gần nhất, mặc định là noone
    var min_dist = -1;          // Khoảng cách nhỏ nhất, -1 nghĩa là chưa tìm thấy

    // Lặp qua từng loại đối tượng trong mảng target_types
    for (var i = 0; i < array_length(target_types); i++) {
        var object_type = target_types[i];
        var temp_nearest = instance_nearest(source.x, source.y, object_type);
        
        // Kiểm tra nếu tìm thấy một instance
        if (temp_nearest != noone) {
            var dist = point_distance(source.x, source.y, temp_nearest.x, temp_nearest.y);
            // Cập nhật nếu đây là khoảng cách nhỏ nhất hoặc là khoảng cách đầu tiên
            if (min_dist == -1 || dist < min_dist) {
                min_dist = dist;
                nearest_target = temp_nearest;
            }
        }
    }
    
    return nearest_target;  // Trả về instance gần nhất hoặc noone nếu không tìm thấy
}


function find_nearest_target_in_range(source, target_types, min_range, max_range) {
    var nearest_target = noone;  // Đối tượng gần nhất trong phạm vi
    var min_dist = -1;          // Khoảng cách nhỏ nhất, -1 nghĩa là chưa tìm thấy

    // Lặp qua từng loại đối tượng trong mảng target_types
    for (var i = 0; i < array_length(target_types); i++) {
        var object_type = target_types[i];
        var temp_nearest = instance_nearest(source.x, source.y, object_type);
        
        // Kiểm tra nếu tìm thấy một instance
        if (temp_nearest != noone) {
            var dist = point_distance(source.x, source.y, temp_nearest.x, temp_nearest.y);
            // Chỉ xem xét nếu khoảng cách <= max_range
            if (dist <= max_range ) {
                // Cập nhật nếu đây là khoảng cách nhỏ nhất hoặc là khoảng cách đầu tiên
                if (min_dist == -1 || dist < min_dist) {
                    min_dist = dist;
                    nearest_target = temp_nearest;
                }
            }
        }
    }
    
    return nearest_target;  // Trả về instance gần nhất trong phạm vi hoặc noone nếu không tìm thấy
}



function move_to_nearest_target (targets, range) {
	
	var nearest_distance = -1;

	
	if (nearest_target != noone  && instance_exists(nearest_target)) {
		var target_x = nearest_target.x 
		var target_y = nearest_target.y
	
		move_2_target(target_x, target_y);
	
		var distance = point_distance(x, y, nearest_target.x,  nearest_target.y);

	
		if (nearest_distance == -1 || distance < nearest_distance) {
		    nearest_distance = distance;
		} 
	
	}else  {
		nearest_target = range == -1 ? 
			find_nearest_target(self, targets) :
			find_nearest_target_in_range(self, targets, detection_radius, range);
	}

	

	// Sau khi tìm được goblin gần nhất
	if (nearest_target != noone && nearest_distance <= detection_radius) {
		var angle = point_direction(x, y, nearest_target.x, nearest_target.y);
	
		if (angle >= -135 && angle < -45) {
	        is_attack_left = true;
	    } else if (angle >= -45 && angle < 45) {
	        is_attack_top = true;
	    } else if (angle >= 45 && angle < 135) {
	        is_attack_right = true;
	    } else {
	        is_attack_down = true;
	    }
	
		if (image_index >= image_number - 1) { // Frame cuối cùng (index bắt đầu từ 0)
	        image_index = 0; // Reset animation
			nearest_target.current_health -= damage;
	    }
	
	}else {
		is_attack_left = false;
		is_attack_top = false;
		is_attack_right = false;
		is_attack_down = false;
	}



}