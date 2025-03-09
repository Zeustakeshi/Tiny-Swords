// Inherit the parent event
event_inherited();
monster_type = "tnt";
idle_animation = spr_tnt_red_idle
run_animation = spr_tnt_red_run
attack_down_animation = spr_tnt_red_attack
attack_top_animation = spr_tnt_red_attack
attack_left_animation = spr_tnt_red_attack
attack_right_animation = spr_tnt_red_attack


damage = global.tnt_damage;
max_health = 600;
current_health = max_health;
detection_radius = 160;
troops_speed = 10;