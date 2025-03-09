// Sự kiện Draw GUI của obj_menu_bar

// Lấy kích thước của viewport (camera)
var viewport_w = camera_get_view_width(view_camera[0]); // Chiều rộng camera
var viewport_h = camera_get_view_height(view_camera[0]); // Chiều cao camera

// Lấy kích thước của GUI (thường là kích thước cửa sổ hoặc display)
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

// Định nghĩa chiều cao của thanh menu
var menu_height = 130; // Ví dụ: chiều cao thanh menu là 130 pixel

// Tính chiều rộng của menu dựa trên số lượng item
var item_count = array_length(global.menu_bar_items); // Số lượng item
var item_width = 80;  // Chiều rộng của mỗi item (có thể điều chỉnh)
var item_height = 80; // Chiều cao của mỗi item (có thể điều chỉnh)
var padding = 10;     // Khoảng cách giữa các item
var total_items_width = item_count * item_width + (item_count - 1) * padding; // Tổng chiều rộng của các item

// Thêm padding cho menu (nếu muốn menu rộng hơn một chút so với tổng item)
var menu_padding = 20; // Padding hai bên menu (có thể điều chỉnh)
var menu_width = total_items_width + menu_padding * 2; // Chiều rộng menu, bao gồm padding

// Tính vị trí X để căn giữa menu trong GUI
var menu_x = (gui_w - menu_width) / 2;

// Tính vị trí Y để thanh menu nằm ở dưới cùng của GUI
var menu_y = gui_h - menu_height;

// Vẽ sprite tấm bảng làm nền cho thanh menu
draw_sprite_stretched(
    spr_inventory_board, // Thay bằng tên sprite tấm bảng của bạn
    0,                   // Sub-image của sprite
    menu_x,              // Vị trí X (căn giữa GUI)
    menu_y,              // Vị trí Y (dưới cùng GUI)
    menu_width,          // Chiều rộng của menu (không còn full GUI)
    menu_height          // Chiều cao của thanh menu
);

// Tính vị trí bắt đầu của các item bên trong menu
var start_x = menu_x + menu_padding; // Bắt đầu từ mép trái của menu, cộng padding
var item_y = menu_y + (menu_height - item_height) / 2; // Căn giữa item theo chiều dọc trong thanh menu

// Đặt font và căn chỉnh văn bản cho giá tiền
draw_set_font(fnt_custom); // Thay fnt_default bằng font bạn muốn sử dụng (nếu có)
draw_set_halign(fa_center); // Căn giữa văn bản theo chiều ngang
draw_set_valign(fa_top);    // Căn văn bản bắt đầu từ trên xuống
draw_set_color(c_white);    // Màu văn bản (có thể thay đổi)

for (var i = 0; i < item_count; i++) {
    var item_x = start_x + i * (item_width + padding); // Tính vị trí X của từng item
    
    // Lưu vị trí của item vào struct (để dễ xử lý click sau này)
    global.menu_bar_items[i].x = item_x;
    global.menu_bar_items[i].y = item_y;
    global.menu_bar_items[i].width = item_width;
    global.menu_bar_items[i].height = item_height;
    
    // Kiểm tra xem chuột có đang hover trên item này không
    // Chuyển đổi vị trí chuột sang không gian GUI
    var gui_mx = device_mouse_x_to_gui(0); // Vị trí X của chuột trong GUI
    var gui_my = device_mouse_y_to_gui(0); // Vị trí Y của chuột trong GUI
    var is_hover = (gui_mx >= item_x && gui_mx <= item_x + item_width &&
                    gui_my >= item_y && gui_my <= item_y + item_height);
    
    // Nếu đang hover, làm sáng item (tăng độ sáng bằng cách vẽ thêm một lớp trắng mờ)
    if (is_hover) {
        draw_set_alpha(0.2); // Độ mờ
        draw_rectangle_color(item_x, item_y, item_x + item_width, item_y + item_height, c_white, c_white, c_white, c_white, false);
        draw_set_alpha(1.0); // Đặt lại độ mờ
    }
    
    // Vẽ sprite của item
    draw_sprite_stretched(
        global.menu_bar_items[i].sprite, // Sprite của item
        0,                      // Sub-image
        item_x,                 // Vị trí X
        item_y,                 // Vị trí Y
        item_width,             // Chiều rộng
        item_height             // Chiều cao
    );
    
    // Vẽ giá tiền bên dưới item
    var price_y = item_y + item_height + 2; // Vị trí Y của giá tiền (cách item 2 pixel)
    var price_text = "(" + string(global.menu_bar_items[i].price[0]) + ", " + string(global.menu_bar_items[i].price[1]) + ", " + string(global.menu_bar_items[i].price[2]) + ")";

    // Vẽ nền cho giá tiền (hình chữ nhật nhỏ)
    var price_text_width = string_width(price_text); // Chiều rộng của văn bản giá tiền
    var price_text_height = string_height(price_text); // Chiều cao của văn bản giá tiền
    var price_box_padding = 4; // Khoảng cách đệm xung quanh văn bản
    draw_set_color(c_black); // Màu nền (có thể thay đổi)
    draw_set_alpha(0.7); // Độ mờ của nền
    draw_rectangle(
        item_x + item_width / 2 - price_text_width / 2 - price_box_padding,
        price_y - price_box_padding,
        item_x + item_width / 2 + price_text_width / 2 + price_box_padding,
        price_y + price_text_height + price_box_padding,
        false
    );
    draw_set_alpha(1.0); // Đặt lại độ mờ

    // Vẽ văn bản giá tiền
    draw_set_color(c_white); // Màu văn bản
    draw_text(item_x + item_width / 2, price_y, price_text); // Vẽ giá tiền, căn giữa item
}