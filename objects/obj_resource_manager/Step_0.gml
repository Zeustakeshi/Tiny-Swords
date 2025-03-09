if (meat_timer > 0) {
    meat_timer -= 1;  // Giảm timer
} else {
    meat_timer = meat_delay;  // Reset timer
    create_resource("meat");  // Tạo tài nguyên thịt
}

if (wood_timer > 0) {
    wood_timer -= 1;
} else {
    wood_timer = wood_delay;
    create_resource("wood");  // Tạo tài nguyên gỗ
}

if (gold_timer > 0) {
    gold_timer -= 1;
} else {
    gold_timer = gold_delay;
    create_resource("gold");  // Tạo tài nguyên vàng
}



function create_resource(resource_type) {
    var new_x = 0;
    var new_y = 0;
    
    // Tìm vị trí ngẫu nhiên không bị chặn
    while (is_block_here(new_x, new_y)) { // Lặp đến khi tìm được vị trí trống
		new_x = random(room_width);   // Chọn x ngẫu nhiên trong chiều rộng bản đồ
        new_y = random(room_height);  // Chọn y ngẫu nhiên trong chiều cao bản đồ
	} 
    
    // Tạo tài nguyên tương ứng
    switch (resource_type) {
        case "meat":
            instance_create_layer(new_x, new_y, "Instances_resources", obj_happy_sheep);
            break;
        case "wood":
            instance_create_layer(new_x, new_y, "Instances_resources", obj_tree);
            break;
        case "gold":
            instance_create_layer(new_x, new_y, "Instances_resources", obj_gold_mine);
            break;
    }
}