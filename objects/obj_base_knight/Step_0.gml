// Inherit the parent event
event_inherited();


if (is_selected) {
	if (instance_exists(obj_flag)) {
		move_2_target(self, obj_flag.x, obj_flag.y)
	}
}



if (mouse_check_button_pressed(mb_left)) {
    // Kiểm tra nếu chuột nhấn vào đối tượng
    if (position_meeting(mouse_x, mouse_y, id)) {
        is_selected = !is_selected; // Chuyển đổi trạng thái chọn
    }
}


var closest_distance = -1;
var closest_enemy = noone;

var count = instance_number(obj_base_goblin); // Số lượng instance của obj_base_goblin
for (var i = 0; i < count; i++) {
    var enemy = instance_find(obj_base_goblin, i); // Lấy instance thứ i
    if (enemy != noone) {
        var distance = point_distance(x, y, enemy.x, enemy.y);

        // Kiểm tra nếu đây là goblin gần nhất
        if (closest_distance == -1 || distance < closest_distance) {
            closest_distance = distance;
            closest_enemy = enemy.id;
        }
    }
}
 

// Sau khi tìm được goblin gần nhất
if (closest_enemy != noone && closest_distance <= detection_radius) {
	var angle = point_direction(x, y, closest_enemy.x, closest_enemy.y);
	
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
        if (closest_enemy != noone) {
            closest_enemy.current_health -= 10; // Trừ máu
        }
        image_index = 0; // Reset animation
		closest_enemy.current_health -= 10
    }
	
	
}else {
	is_attack_left = false;
	is_attack_top = false;
	is_attack_right = false;
	is_attack_down = false;
}

