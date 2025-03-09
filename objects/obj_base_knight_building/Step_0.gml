// Inherit the parent event
event_inherited();


var _self = self;

with (obj_base_knight_troops) {
	if ( obj_base_knight_troops.created_by == self) {
		_self.current_troops_count++;
	}
}


if (current_health > 0 && current_troops_count < maximum_troops) {
    troops_timer += 1; // Tăng timer mỗi frame
    if (troops_timer >= troops_delay) { // Khi timer đạt giá trị delay
        troops_timer = 0; // Reset timer
        create_troops_random(self); // Tạo một troop mới
        current_troops_count++; // Tăng số lượng troops
    }
}

if (current_health <= 0) {
	instance_destroy()
}


function create_troops_random (_self) {
	var center_x = x;
	var center_y = y;
	
	
	var new_x = 0;
	var new_y = 0;
	
	while (is_block_here(new_x, new_y)) {
		var angle = random(360); // Góc ngẫu nhiên (độ)
		var distance = random_range (sprite_width * 0.5, detection_radius); // Khoảng cách ngẫu nhiên
		new_x = center_x + lengthdir_x(distance, angle); // Tọa độ x mới
		new_y = center_y + lengthdir_y(distance, angle); // Tọa độ y mới
	}
	
		
	if (!instance_exists(_self.knight_object)) return;
	
	if ( obj_game.meat - knight_price >= 0) {
		obj_game.meat = obj_game.meat - knight_price;
	
		var new_instance = instance_create_layer(new_x, new_y, "Instances_troops", _self.knight_object);

		new_instance.created_by = _self;
	}
	

}