// Inherit the parent event
event_inherited();


var closest_distance = -1;
var closest_resource = noone;

var count = instance_number(obj_base_resource); // Số lượng instance của obj_base_goblin
for (var i = 0; i < count; i++) {
    var enemy = instance_find(obj_base_resource, i); // Lấy instance thứ i
    if (enemy != noone) {
        var distance = point_distance(x, y, enemy.x, enemy.y);

        // Kiểm tra nếu đây là tài nguyên gần nhất
        if (closest_distance == -1 || distance < closest_distance) {
            closest_distance = distance;
            closest_resource = enemy.id;
        }
    }
}
 

// Sau khi tìm được goblin gần nhất
 

if (closest_resource != noone && closest_resource.status != 2 ) {
	if (closest_distance <= detection_radius ) {
		var angle = point_direction(x, y, closest_resource.x, closest_resource.y);
	
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
			closest_resource.current_health -= damage
			increase_resource_value(closest_resource)
			closest_resource.status = 1
	    }
	}else {
		closest_resource.status = 0
		is_attack_left = false;
		is_attack_top = false;
		is_attack_right = false;
		is_attack_down = false;
		is_idle = true;
	}
	
}else {
	is_attack_left = false;
	is_attack_top = false;
	is_attack_right = false;
	is_attack_down = false;
	is_idle = true;
}


function increase_resource_value (resource) {
	switch (resource.object_index) {
		case obj_happy_sheep: {
			obj_game.meat += resource.value;
			break;
		}
		case obj_tree: {
			 obj_game.wood += resource.value;
			 break;
		}
		case obj_gold_mine: {
			 obj_game.gold += resource.value;
			 break;
		}
	}
}