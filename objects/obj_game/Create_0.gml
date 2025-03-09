global.cell_size = 32; // Kích thước ô lưới, tùy chỉnh theo game của bạn
global.grid_width = room_width div global.cell_size;
global.grid_height = room_height div global.cell_size;
global.game_speed = 60;
global.is_game_over = false;
global.round_number = 1;
global.tnt_damage = 500;
global.torch_damage = 120;




wood = 500;
gold = 500; 
meat = 500;



if (!variable_global_exists("grid")) {
    init_grid();
}
