global.cell_size = 32; // Kích thước ô lưới, tùy chỉnh theo game của bạn
global.grid_width = room_width div global.cell_size;
global.grid_height = room_height div global.cell_size;


if (!variable_global_exists("grid")) {
    init_grid();
}


