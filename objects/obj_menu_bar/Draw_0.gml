// Nếu có item đang được chọn, hiển thị bản xem trước tại vị trí chuột
if (global.selected_menu_bar_item != -1) {
    var mx = mouse_x; // Vị trí X của chuột trong không gian room
    var my = mouse_y; // Vị trí Y của chuột trong không gian room
    
    // Lấy sprite của item đang được chọn
    var item_sprite = global.menu_bar_items[global.selected_menu_bar_item].sprite;
    
    // Kiểm tra xem vị trí chuột có hợp lệ không (dùng hàm is_block)
    var is_valid_position = !is_block_here(mx, my); // Nếu is_block trả về true, vị trí không hợp lệ
    
    // Vẽ bản xem trước của item
    draw_set_alpha(0.7); // Làm mờ bản xem trước để phân biệt với item thật
    if (is_valid_position) {
        // Nếu vị trí hợp lệ, vẽ item bằng màu bình thường (hoặc màu xanh để báo hiệu)
        draw_sprite(item_sprite, 0, mx, my);
    } else {
        // Nếu vị trí không hợp lệ, vẽ item bằng màu đỏ để báo hiệu
        draw_sprite_ext(item_sprite, 0, mx, my, 1, 1, 0, c_red, 0.7);
    }
    draw_set_alpha(1.0); // Đặt lại độ mờ
}