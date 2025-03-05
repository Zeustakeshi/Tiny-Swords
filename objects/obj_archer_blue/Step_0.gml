// Inherit the parent event
event_inherited();


if (keyboard_check(ord("W"))){
	base_move_up()
}

if (keyboard_check(ord("A"))){
	base_move_left()
}

if (keyboard_check(ord("S"))){
	base_move_down()
}

if (keyboard_check(ord("D"))){
	base_move_right()
}


if (instance_exists(obj_flag) && is_selected) {
	move_2_target(self, obj_flag.x, obj_flag.y)
} 