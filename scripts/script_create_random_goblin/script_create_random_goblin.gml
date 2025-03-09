function create_goblin (goblin_count) {
	for (var i = 0; i < goblin_count; i++) {
	    var random_x = irandom_range(0, room_width);  // Tọa độ x ngẫu nhiên
	    var random_y = irandom_range(0, room_height); // Tọa độ y ngẫu nhiên
	

	
		if (is_blocked(random_x, random_y)) {
			var nearest_empty = find_nearest_empty_cell(random_x, random_y);
			if (nearest_empty[0] == -1 || nearest_empty[1] == -1) continue;
			random_x = nearest_empty[0];
			random_y = nearest_empty[1];
		}
	
	    instance_create_layer(random_x, random_y, "Instances_goblins", obj_torch_red);
		
		show_debug_message("create goblin pos_x: " + string(random_x) + " pos_y: " + string(random_y))
		
	}

}
