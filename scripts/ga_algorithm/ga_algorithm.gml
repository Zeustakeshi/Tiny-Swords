function ga_initialize_population() {
    for (var i = 0; i < ga_population_size; i++) {
        var gene = [
            irandom_range(1, 10), // Số quái vật ném bom
            irandom_range(1, 10), // Số quái vật đánh cận chiến
            random_range(10, 20),  // Khoảng thời gian spawn
			random_range(200, 222), // damage của quái vật ném boom
			random_range(120, 130) // damage của quái vật cận chiến
        ];
        ga_population[i] = gene;
    }
}

function ga_evaluate_fitness(gene) {
    var num_tnt = gene[0];         // Số quái tnt yêu cầu
    var num_torch = gene[1];       // Số quái torch yêu cầu
    var spawn_interval = gene[2];  // Khoảng cách sinh quái
    var damage_tnt =  gene[3];           // Sát thương mỗi tnt
    var damage_torch =  gene[4];         // Sát thương mỗi torch
	
    
    // Tính fitness dựa trên số quái thực sự
 
    var total_damage = num_tnt * damage_tnt + num_torch * damage_torch;
    
    // Điều chỉnh fitness dựa trên khoảng cách sinh
    var interval_factor = 1 / spawn_interval;
    total_damage = total_damage * (1 + interval_factor * 0.1);
	
    
    var fitness = total_damage;
    return fitness;
}

function ga_selection() {
    var selected = [];
    if (array_length(ga_population) == 0) {
        show_debug_message("Lỗi: ga_population rỗng!");
        return selected; // Trả về mảng rỗng để tránh lỗi
    }
    
    // Tính tổng fitness của toàn bộ quần thể
    var total_fitness = 0;
    for (var j = 0; j < array_length(ga_population); j++) {
        total_fitness += ga_evaluate_fitness(ga_population[j]);
    }
    
    // Chọn 2 cha mẹ bằng Roulette Wheel Selection
    for (var i = 0; i < 2; i++) {
        var pick = random(total_fitness); // Chọn một giá trị ngẫu nhiên trong khoảng total_fitness
        var current = 0;
        for (var j = 0; j < array_length(ga_population); j++) {
            current += ga_evaluate_fitness(ga_population[j]); 
            if (current >= pick) {
                array_push(selected, ga_population[j]);
                break;
            }
        }
        // Nếu không chọn được (do lỗi làm tròn), chọn phần tử cuối cùng
        if (array_length(selected) == i) {
            array_push(selected, ga_population[array_length(ga_population) - 1]);
        }
    }
    
    return selected;
}

function ga_crossover(parent1, parent2) {
    var child = [
	    choose(parent1[0], parent2[0]),
	    choose(parent1[1], parent2[1]),
	    (parent1[2] + parent2[2]) / 2,
	    choose(parent1[3], parent2[3]),
	    choose(parent1[4], parent2[4])
	];
    return child;
}


function ga_mutation(gene) {
    if (random(1) < ga_mutation_rate) {
        gene[0] += irandom_range(-2, 2); // Thay đổi số tnt
        gene[0] = max(1, gene[0]);       // Không dưới 1
    }
    if (random(1) < ga_mutation_rate) {
        gene[1] += irandom_range(-2, 2); // Thay đổi số torch
        gene[1] = max(1, gene[1]);       // Không dưới 1
    }
    if (random(1) < ga_mutation_rate) {
        gene[2] += random_range(-5, 5); // Thay đổi khoảng thời gian spawn (frame)
        gene[2] = clamp(gene[2], 10, 20); // Giới hạn từ 10-60 frame
    }
    if (random(1) < ga_mutation_rate) {
        gene[3] += random_range(-30, 30);  // Thay đổi damage tnt
        gene[3] = clamp(gene[3], 100, 222); // Giới hạn damage tnt từ 100-222
    }
    if (random(1) < ga_mutation_rate) {
        gene[4] += random_range(-20, 20);  // Thay đổi damage torch
        gene[4] = clamp(gene[4], 100, 130); // Giới hạn damage torch từ 120-130
    }
    return gene;
}


function ga_run() {
    if (array_length(ga_population) == 0) {
        ga_initialize_population();
    }
    
    for (var gen = 0; gen < ga_generations; gen++) {
        var new_population = [];
        
        // Elitism: Giữ lại 2 gene tốt nhất
        var best_indices = [];
        for (var elite = 0; elite < 2; elite++) {
            var best_index = -1;
            var best_fitness = -1;
            for (var j = 0; j < array_length(ga_population); j++) {
                if (array_get_index(best_indices, j) == -1) {
                    var fitness = ga_evaluate_fitness(ga_population[j]);
                    if (fitness > best_fitness) {
                        best_fitness = fitness;
                        best_index = j;
                    }
                }
            }
            if (best_index != -1) {
                array_push(new_population, ga_population[best_index]);
                array_push(best_indices, best_index);
            }
        }
        
        // Tạo gene con để lấp đầy quần thể mới
        while (array_length(new_population) < ga_population_size) {
            var parents = ga_selection();
            if (array_length(parents) < 2) break;
            var parent1 = parents[0];
            var parent2 = parents[1];
            
            var child = ga_crossover(parent1, parent2);
            child = ga_mutation(child);
            
            array_push(new_population, child);
        }
        
        ga_population = new_population;
    }
    
    // Tìm wave tốt nhất
    var best_fitness = -1;
    for (var i = 0; i < array_length(ga_population); i++) {
        var fitness = ga_evaluate_fitness(ga_population[i]);
        if (fitness > best_fitness) {
            best_fitness = fitness;
            ga_best_wave = ga_population[i];
        }
    }
}


function activate_wave(wave) {
   var num_tnt = wave[0];
    var num_torch = wave[1];
    var spawn_interval = wave[2]; // Khoảng thời gian spawn (frame)
    var damage_tnt = wave[3];
    var damage_torch = wave[4];
	
	
    
    var tnt_bases = [];
    var torch_bases = [];
    
    // Tìm tất cả các doanh trại tnt và torch
    with (obj_base_goblin_building) {
        if (monster_type == "tnt") {
            array_push(tnt_bases, id);
        } else if (monster_type == "torch") {
            array_push(torch_bases, id);
        }
    }
    
    // Log để kiểm tra số lượng doanh trại
    show_debug_message("DEBUG: Số doanh trại tnt: " + string(array_length(tnt_bases)));
    show_debug_message("DEBUG: Số doanh trại torch: " + string(array_length(torch_bases)));
    
    // Nếu không có doanh trại, thông báo lỗi
    if (array_length(tnt_bases) == 0 && num_tnt > 0) {
        show_debug_message("ERROR: Không có doanh trại tnt để sinh " + string(num_tnt) + " quái tnt!");
    }
    if (array_length(torch_bases) == 0 && num_torch > 0) {
        show_debug_message("ERROR: Không có doanh trại torch để sinh " + string(num_torch) + " quái torch!");
    }
    
    // Sinh quái tnt
    if (array_length(tnt_bases) > 0) {
        var tnt_per_base = ceil(num_tnt / array_length(tnt_bases)); // Chia đều số quái tnt cho mỗi doanh trại
        for (var i = 0; i < array_length(tnt_bases); i++) {
            var base = tnt_bases[i];
            base.num_monsters_to_spawn = min(tnt_per_base, num_tnt - (i * tnt_per_base)); // Số quái cần sinh
            base.spawn_interval = spawn_interval * global.game_speed; // Đổi giây thành frame
            base.spawn_timer = 0; // Khởi tạo timer để bắt đầu sinh ngay
            base.monster_type_to_spawn = "tnt"; // Đặt loại quái cần sinh
			base.monster_damage = damage_tnt;
            show_debug_message("DEBUG: Doanh trại tnt " + string(i) + " sẽ sinh " + string(base.num_monsters_to_spawn) + " quái tnt.");
        }
    }
    
    // Sinh quái torch
    if (array_length(torch_bases) > 0) {
        var torch_per_base = ceil(num_torch / array_length(torch_bases)); // Chia đều số quái torch cho mỗi doanh trại
        for (var i = 0; i < array_length(torch_bases); i++) {
            var base = torch_bases[i];
            base.num_monsters_to_spawn = min(torch_per_base, num_torch - (i * torch_per_base)); // Số quái cần sinh
            base.spawn_interval = spawn_interval * global.game_speed; // Đổi giây thành frame
            base.spawn_timer = 0; // Khởi tạo timer để bắt đầu sinh ngay
            base.monster_type_to_spawn = "torch"; // Đặt loại quái cần sinh
			base.monster_damage = damage_torch;
			show_debug_message("DEBUG: Doanh trại torch " + string(i) + " sẽ sinh " + string(base.num_monsters_to_spawn) + " quái torch.");
        }
    }
}




