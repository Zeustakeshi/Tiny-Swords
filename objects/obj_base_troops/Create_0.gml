

idle_animation = noone
run_animation = noone
attack_1_animation = noone 
attack_2_animation = noone
troops_speed = 5
troops_scale = 1


is_move_left = false 
is_move_right = false;
is_move_up = false;
is_move_down = false;
is_idle = false;
is_selected = false


function base_move_left () {
	reset_move_state()
	is_move_left = true;
}

function base_move_right () {
	reset_move_state()
	is_move_right = true;
}

function base_move_down () {
	reset_move_state()
	is_move_down = true;
} 

function base_move_up () {
	reset_move_state()
	is_move_up = true;
}

function base_stop_move () {
	reset_move_state()
	is_idle = true;
}

function reset_move_state () {
	is_move_left = false 
	is_move_right = false;
	is_move_up = false;
	is_move_down = false;
	is_idle = false;
}
	
