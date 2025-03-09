ga_population_size = 20; // Kích thước quần thể
ga_generations = 50; // Số thế hệ
ga_mutation_rate = 0.9; // Tỷ lệ đột biến
ga_population = []; // Quần thể các gene
ga_best_wave = []; // Wave tốt nhất tìm được


monster_types = ["tnt", "torch"];


// Thời gian chờ giữa các wave
wave_delay = 10 * global.game_speed; //  10 giây
wave_delay_timer = wave_delay;

// Trạng thái wave
wave_in_progress = false;

wave_end_delay_timer = 0;


/*
	Định nghĩa gene cho GA
	Mỗi gene trong GA đại diện cho một wave tấn công. Một gene có thể bao gồm:
	Số lượng quái vật ném bom (num_bombers).
	Số lượng quái vật đánh cận chiến (num_melee).
	Khoảng thời gian spawn giữa các quái vật (spawn_interval).
	Ví dụ: Một gene [5, 3, 0.5] có nghĩa là:

	5 quái vật ném bom.
	3 quái vật đánh cận chiến.
	Mỗi quái vật được sinh ra cách nhau 0.5 giây.

*/



ga_initialize_population()















