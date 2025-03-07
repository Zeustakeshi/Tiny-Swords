/// @function a_star_to_path(start_x, start_y, target_x, target_y, path)
/// @param start_x Tọa độ X bắt đầu
/// @param start_y Tọa độ Y bắt đầu
/// @param target_x Tọa độ X đích
/// @param target_y Tọa độ Y đích
/// @param path Đối tượng path của GameMaker để lưu đường đi
function a_star_to_path(start_x, start_y, target_x, target_y, path) {
    var cell_size = global.cell_size;
    var grid_width = global.grid_width;
    var grid_height = global.grid_height;

    var start_x_grid = start_x div cell_size;
    var start_y_grid = start_y div cell_size;
    var target_x_grid = target_x div cell_size;
    var target_y_grid = target_y div cell_size;

    // Kiểm tra nếu điểm bắt đầu hoặc đích bị chặn
    if (global.grid[# start_x_grid, start_y_grid] == 1 || global.grid[# target_x_grid, target_y_grid] == 1) {
        return false;
    }

    // Khởi tạo các cấu trúc dữ liệu
    var open_list = ds_priority_create();
    var grid_g = ds_grid_create(grid_width, grid_height);
    var grid_parent_x = ds_grid_create(grid_width, grid_height);
    var grid_parent_y = ds_grid_create(grid_width, grid_height);
    var closed = ds_grid_create(grid_width, grid_height);

    ds_grid_clear(grid_g, -1);
    ds_grid_clear(grid_parent_x, -1);
    ds_grid_clear(grid_parent_y, -1);
    ds_grid_clear(closed, 0);

    // Thêm điểm bắt đầu vào open_list
    grid_g[# start_x_grid, start_y_grid] = 0;
    var start_h = abs(start_x_grid - target_x_grid) + abs(start_y_grid - target_y_grid);
    ds_priority_add(open_list, start_x_grid + start_y_grid * grid_width, start_h);

    var found = false;

    // Thuật toán A*
    while (!ds_priority_empty(open_list)) {
        var current = ds_priority_delete_min(open_list);
        var current_x = current mod grid_width;
        var current_y = current div grid_width;

        if (current_x == target_x_grid && current_y == target_y_grid) {
            found = true;
            break;
        }

        closed[# current_x, current_y] = 1;

        for (var dx = -1; dx <= 1; dx++) {
            for (var dy = -1; dy <= 1; dy++) {
                if (abs(dx) + abs(dy) != 1) continue; // Chỉ xét 4 hướng

                var neighbor_x = current_x + dx;
                var neighbor_y = current_y + dy;

                if (neighbor_x < 0 || neighbor_x >= grid_width || neighbor_y < 0 || neighbor_y >= grid_height) continue;
                if (global.grid[# neighbor_x, neighbor_y] == 1) continue;
                if (closed[# neighbor_x, neighbor_y] == 1) continue;

                var tentative_g = grid_g[# current_x, current_y] + 1;

                if (grid_g[# neighbor_x, neighbor_y] == -1 || tentative_g < grid_g[# neighbor_x, neighbor_y]) {
                    grid_g[# neighbor_x, neighbor_y] = tentative_g;
                    var h = abs(neighbor_x - target_x_grid) + abs(neighbor_y - target_y_grid);
                    var f = tentative_g + h;
                    grid_parent_x[# neighbor_x, neighbor_y] = current_x;
                    grid_parent_y[# neighbor_x, neighbor_y] = current_y;
                    ds_priority_add(open_list, neighbor_x + neighbor_y * grid_width, f);
                }
            }
        }
    }

    // Nếu tìm thấy đường đi, xây dựng path
    if (found) {
        var current_x = target_x_grid;
        var current_y = target_y_grid;

        path_clear_points(path);
        path_add_point(path, target_x_grid * cell_size + cell_size / 2, target_y_grid * cell_size + cell_size / 2, 100);

        while (current_x != start_x_grid || current_y != start_y_grid) {
            var parent_x = grid_parent_x[# current_x, current_y];
            var parent_y = grid_parent_y[# current_x, current_y];
            path_add_point(path, parent_x * cell_size + cell_size / 2, parent_y * cell_size + cell_size / 2, 100);
            current_x = parent_x;
            current_y = parent_y;
        }

        path_reverse(path); // Đảo ngược path để đi từ nguồn đến đích
    }

    // Dọn dẹp bộ nhớ
    ds_grid_destroy(grid_g);
    ds_grid_destroy(grid_parent_x);
    ds_grid_destroy(grid_parent_y);
    ds_grid_destroy(closed);
    ds_priority_destroy(open_list);

    return found;
}