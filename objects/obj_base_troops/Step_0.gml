depth = -y;

 

if (is_move_left) {
	move_2_target( x - troops_speed, y)
}

if (is_move_right) {
	move_2_target( x + troops_speed, y)
}

if (is_move_down) {
	move_2_target( x , y + troops_speed)
}


if (is_move_up) {
	move_2_target(x , y = troops_speed)
}

if (is_idle && idle_animation != noone) {
	sprite_index = idle_animation
}


if (is_attack_top && attack_top_animation != noone) {
	sprite_index = attack_top_animation
}

if (is_attack_down && attack_down_animation != noone) {
	sprite_index = attack_down_animation
}

if (is_attack_left && attack_left_animation != noone) {
	sprite_index = attack_left_animation
}

if (is_attack_right && attack_right_animation != noone) {
	sprite_index = attack_right_animation
}
 

// detroy when health = 0 (is died :<)
if (current_health <= 0) {
	instance_destroy();
	
	if (created_by != noone) {
		created_by.current_troops_count--;
	}
}











