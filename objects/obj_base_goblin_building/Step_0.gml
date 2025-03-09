 // Inherit the parent event
event_inherited();


var _self = self;



// Kiểm tra nếu có lệnh sinh quái từ obj_wave_manager
if (num_monsters_to_spawn > 0) {
    spawn_timer += 1; // Tăng timer mỗi frame
    if (spawn_timer >= spawn_interval) { // Khi timer đạt giá trị spawn_interval
        spawn_timer = 0; // Reset timer
        create_troops_random(self); // Tạo một quái mới
        num_monsters_to_spawn -= 1; // Giảm số quái cần sinh
        show_debug_message("DEBUG: Doanh trại " + string(id) + " sinh quái " + monster_type_to_spawn + ". Còn lại: " + string(num_monsters_to_spawn));
    }
}

if (current_health <= 0) {
	instance_destroy()
}





function create_troops_random(_self) {
    var center_x = x;
    var center_y = y;
    
    var new_x = 0;
    var new_y = 0;
    
    // Tìm vị trí ngẫu nhiên không bị chặn
    var attempts = 0;
    var max_attempts = 10; // Giới hạn số lần thử để tránh vòng lặp vô hạn
    while (is_block_here(new_x, new_y) && attempts < max_attempts) {
        var angle = random(360); // Góc ngẫu nhiên (độ)
        var distance = random_range(sprite_width * 0.5, detection_radius); // Khoảng cách ngẫu nhiên
        new_x = center_x + lengthdir_x(distance, angle); // Tọa độ x mới
        new_y = center_y + lengthdir_y(distance, angle); // Tọa độ y mới
        attempts += 1;
    }
    
    if (attempts >= max_attempts) {
        show_debug_message("WARNING: Không tìm được vị trí hợp lệ để sinh quái cho doanh trại " + string(_self.id));
        return;
    }
    
    if (!instance_exists(_self.goblin_object)) {
        show_debug_message("ERROR: goblin_object không tồn tại cho doanh trại " + string(_self.id));
        return;
    }
    
    var new_instance = instance_create_layer(new_x, new_y, "Instances_troops", _self.goblin_object);
    new_instance.created_by = _self;
	new_instance.damage = _self.monster_damage;
    show_debug_message("DEBUG: Doanh trại " + string(_self.id) + " sinh quái " + string(_self.goblin_object) + " tại (" + string(new_x) + ", " + string(new_y) + ")");
}