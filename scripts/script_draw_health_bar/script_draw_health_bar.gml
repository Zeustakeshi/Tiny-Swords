function draw_health_bar(_health, max_health) {
    // Tính tỷ lệ máu (sửa lỗi chính ở đây)
    var health_ratio = _health / max_health;

    // Vẽ nền thanh máu (màu đen)
    draw_set_color(c_black);
    draw_rectangle(x-50, y-50, x+50, y-45, false);

    // Xác định màu sắc dựa trên tỷ lệ máu
    var bar_color;
    if (health_ratio > 0.8) {
        bar_color = make_color_rgb(0, 255, 0); // Xanh lá
    } else if (health_ratio > 0.4) {
        bar_color = make_color_rgb(255, 255, 0); // Vàng
    } else {
        bar_color = make_color_rgb(255, 0, 0); // Đỏ
    }
    draw_set_color(bar_color);

    // Vẽ phần máu hiện tại (sửa tọa độ)
    var bar_width = 100 * health_ratio; // Chiều dài thanh máu
    draw_rectangle(x-50, y-50, x-50 + bar_width, y-45, false);
}