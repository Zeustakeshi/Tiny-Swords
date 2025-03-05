// Inherit the parent event
event_inherited();


var _self = self;

with (obj_base_knight) {
	if ( obj_base_knight.created_by == self) {
		_self.current_troops_count++;
	}
}

while (current_troops_count < maximum_troops) {
	create_troops_random(_self)
	current_troops_count++;
}



function create_troops_random (_self) {
	var center_x = x;
	var center_y = y;
	
	var angle = random(360); // Góc ngẫu nhiên (độ)
	var distance = random(detection_radius); // Khoảng cách ngẫu nhiên
	var new_x = center_x + lengthdir_x(distance, angle); // Tọa độ x mới
	var new_y = center_y + lengthdir_y(distance, angle); // Tọa độ y mới
		
	if (!instance_exists(_self.knight_object)) return;
	
	var new_instance = instance_create_layer(new_x, new_y, "Instances_troops", _self.knight_object);
	
	new_instance.created_by = _self;
}