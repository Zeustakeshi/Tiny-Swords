
detection_radius = 200;
current_troops_count = 0;
goblin_object = noone

max_health = 500;
current_health = max_health;


// Biến để quản lý việc sinh quái theo lệnh từ obj_wave_manager
num_monsters_to_spawn = 0; // Số quái cần sinh (do obj_wave_manager gán)
spawn_interval = 0; // Khoảng thời gian spawn (frame, do obj_wave_manager gán)
spawn_timer = 0; // Timer để đếm thời gian spawn
monster_type_to_spawn = ""; // Loại quái cần sinh (tnt hoặc torch, do obj_wave_manager gán)
goblin_object = noone; // Object quái cần sinh (do bạn gán trong room hoặc nơi khác)
monster_type = "";
monster_damage = 0;
// alarm[0] = global.game_speed  * attack_delay_time; 
