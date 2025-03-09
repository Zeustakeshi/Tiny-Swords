if (mouse_check_button_pressed(mb_left)) {
    // Chuyển đổi vị trí chuột sang không gian GUI
    var gui_mx = device_mouse_x_to_gui(0); // Vị trí X của chuột trong GUI
    var gui_my = device_mouse_y_to_gui(0); // Vị trí Y của chuột trong GUI
    
    // Kiểm tra xem chuột có nằm trong vùng của item nào không
    for (var i = 0; i < array_length(global.menu_bar_items); i++) {
        var item = global.menu_bar_items[i];
        if (gui_mx >= item.x && gui_mx <= item.x + item.width &&
            gui_my >= item.y && gui_my <= item.y + item.height) {
            // Người dùng đã click vào item i
            global.selected_menu_bar_item  = i;
            show_debug_message("Picked up item: " + global.menu_bar_items[i].name);
            
            // Thay đổi con trỏ chuột thành sprite của item
            cursor_sprite = global.menu_bar_items[i].sprite;
            window_set_cursor(cr_none); // Ẩn con trỏ mặc định để chỉ hiển thị sprite
            break;
        }
    }
}

// Nếu nhấn phím ESC, hủy chọn item
if (keyboard_check_pressed(vk_escape) && global.selected_menu_bar_item  != -1) {
    global.selected_menu_bar_item  = -1;
    cursor_sprite = -1; // Đặt lại con trỏ mặc định
    window_set_cursor(cr_default); // Hiển thị lại con trỏ mặc định
}

// Nếu item đang được chọn và  người dùng nhả chuột, đặt item xuống
if (global.selected_menu_bar_item  != -1 && mouse_check_button_released(mb_left)) {
    var mx = mouse_x; // Vị trí X của chuột trong không gian room
    var my = mouse_y; // Vị trí Y của chuột trong không gian room
    
    // Kiểm tra xem vị trí chuột có hợp lệ không
    if (!is_block_here(mx, my)) {
		var menu_bar_item =  global.menu_bar_items[global.selected_menu_bar_item];
        // Vị trí hợp lệ, tạo instance của item tại vị trí chuột
        var item_obj = menu_bar_item.object; // Giả định bạn có thuộc tính object trong struct
        if (item_obj != -1 && 
			obj_game.wood - menu_bar_item.price[0] >= 0 &&
			obj_game.gold - menu_bar_item.price[1] >= 0 &&
			obj_game.meat - menu_bar_item.price[2] >= 0
		) { // Đảm bảo object tồn tại và người dùng có đủ tài nguyên
            instance_create_layer(mx, my, "Instances_buildings", item_obj);
        
			obj_game.wood = obj_game.wood - menu_bar_item.price[0]
			obj_game.gold = obj_game.gold - menu_bar_item.price[1]
			obj_game.meat = obj_game.meat - menu_bar_item.price[2]

			
			show_debug_message("Placed item: " + global.menu_bar_items[global.selected_menu_bar_item ].name + " at (" + string(mx) + ", " + string(my) + ")");
        
			init_grid()
		}
        
        // Đặt lại trạng thái (hủy chọn item)
        global.selected_menu_bar_item  = -1;
        cursor_sprite = -1; // Đặt lại con trỏ mặc định
        window_set_cursor(cr_default); // Hiển thị lại con trỏ mặc định
    } else {
        // Vị trí không hợp lệ, thông báo cho người dùng (tùy chọn)
        show_debug_message("Cannot place item here: position is blocked.");
    }
}