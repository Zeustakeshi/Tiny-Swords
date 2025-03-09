// Inherit the parent event
event_inherited();
monster_type = "torch";
idle_animation = spr_torch_red_idle
run_animation = spr_torch_red_run
attack_down_animation = spr_torch_red_attack_down
attack_top_animation = spr_torch_red_attack_top
attack_left_animation = spr_torch_red_attack_horizontal
attack_right_animation = spr_torch_red_attack_horizontal


damage = global.torch_damage
max_health = 1500;
current_health = max_health;
detection_radius = 150;
troops_speed = 8;