 

idle_animation = noone
run_animation = noone
attack_top_animation = noone 
attack_down_animation = noone
attack_left_animation = noone 
attack_right_animation = noone

troops_speed = 5
troops_scale = 1 


is_move_left = false 
is_move_right = false;
is_move_up = false;
is_move_down = false;
is_idle = true;
is_attack_top = false;
is_attack_left = false;
is_attack_right = false;
is_attack_down = false;

is_selected = false
_room_speed = 30
created_by = self

detection_radius = 100

max_health = 100
current_health = 100
damage = 10 

target_x = -1;
target_y = -1;

my_path = path_add();

path_calculated = false;


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
	
