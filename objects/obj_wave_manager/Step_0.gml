
if (!wave_in_progress) {
    show_debug_message("DEBUG: Không có wave đang diễn ra. Kiểm tra wave_delay_timer...");
    if (wave_delay_timer <= 0) {
        show_debug_message("DEBUG: wave_delay_timer <= 0. Chuẩn bị chạy GA...");
        ga_run();
        if (array_length(ga_best_wave) > 0) {
            show_debug_message("DEBUG: GA hoàn thành. Wave tốt nhất: num_tnt=" + string(ga_best_wave[0]) + 
                               ", num_torch=" + string(ga_best_wave[1]) + 
                               ", spawn_interval=" + string(ga_best_wave[2]) + 
                               ", damage_tnt=" + string(ga_best_wave[3]) + 
                               ", damage_torch=" + string(ga_best_wave[4]));
            activate_wave(ga_best_wave);
            show_debug_message("DEBUG: Wave đã được kích hoạt.");
        } else {
            show_debug_message("ERROR: GA không tìm được wave tốt nhất (ga_best_wave rỗng)!");
        }
        wave_delay_timer = wave_delay;
        show_debug_message("DEBUG: Đặt lại wave_delay_timer = " + string(wave_delay));
        wave_in_progress = true;
        show_debug_message("DEBUG: wave_in_progress = true. Wave bắt đầu.");
    } else {
        show_debug_message("DEBUG: wave_delay_timer = " + string(wave_delay_timer) + ". Đang chờ...");
        wave_delay_timer -= 1;
    }
} else {
    var tnt_monsters = instance_number(obj_tnt_red) - 1;
    var torch_monsters = instance_number(obj_torch_red) - 1;
    
    if (tnt_monsters <= 0 && torch_monsters <= 0) {
        // Nếu wave_end_delay_timer chưa được đặt, đặt thành 3 giây
        if (wave_end_delay_timer == 0) {
            wave_end_delay_timer = 20 * global.game_speed; // 3 giây tính bằng frame
            show_debug_message("DEBUG: Không còn quái vật. Bắt đầu chờ 3 giây trước khi kết thúc wave...");
        }
        
        // Đếm ngược thời gian chờ
        wave_end_delay_timer -= 1;
        show_debug_message("DEBUG: Đang chờ kết thúc wave. wave_end_delay_timer = " + string(wave_end_delay_timer));
        
        // Khi hết thời gian chờ, kết thúc wave
        if (wave_end_delay_timer <= 0) {
            show_debug_message("DEBUG: Hết 6 giây chờ. Wave kết thúc.");
            wave_in_progress = false;
            wave_end_delay_timer = 0; // Reset timer để dùng cho wave sau
        }
    } else {
        // Nếu vẫn còn quái, reset wave_end_delay_timer
        wave_end_delay_timer = 0;
        show_debug_message("DEBUG: Wave đang diễn ra. Số quái tnt: " + string(tnt_monsters) + 
                           ", Số quái torch: " + string(torch_monsters));
    }
}