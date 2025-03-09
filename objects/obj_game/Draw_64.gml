// Đặt font mặc định
draw_set_font(fnt_custom);

// Định nghĩa màu sắc cho giao diện
var text_color = c_white; // Màu chữ chính
var shadow_color = c_black; // Màu bóng đổ (tạo độ tương phản)
var bg_color = make_color_rgb(50, 50, 50); // Màu nền (xám tối)

// Hàm hỗ trợ để vẽ văn bản có bóng đổ và nền
function draw_text_with_background(_x, _y, _text, _text_color, _shadow_color, _bg_color) {
    draw_set_alpha(0.7);
    draw_rectangle_color(_x - 70, _y - 5, _x + string_width(_text) + 10, _y + string_height(_text) + 5, _bg_color, _bg_color, _bg_color, _bg_color, false);
    draw_set_alpha(1.0);
    draw_set_color(_shadow_color);
    draw_text(_x + 1, _y + 1, _text);
    draw_set_color(_text_color);
    draw_text(_x, _y, _text);
}

// Vẽ HUD (tài nguyên)
var hud_x = 80;
var hud_y = 20;
var line_height = 30;
draw_text_with_background(hud_x, hud_y, "Wood: " + string(wood), text_color, shadow_color, bg_color);
draw_text_with_background(hud_x, hud_y + line_height, "Gold: " + string(gold), text_color, shadow_color, bg_color);
draw_text_with_background(hud_x, hud_y + line_height * 2, "Meat: " + string(meat), text_color, shadow_color, bg_color);

// Vẽ màn hình Game Over
if (global.is_game_over) {
    draw_set_alpha(0.8);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var center_x = view_wport / 2;
    var center_y = view_hport / 2;
    draw_set_color(c_red);
    draw_text(center_x + 2, center_y + 2, "GAME OVER");
    draw_set_color(c_white);
    draw_text(center_x, center_y, "GAME OVER");
    
    var restart_text = "Press R to Restart";
    var blink_alpha = abs(sin(current_time / 500));
    draw_set_alpha(blink_alpha);
    draw_set_color(c_white);
    draw_text(center_x, center_y + 40, restart_text);
    draw_set_alpha(1.0);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}