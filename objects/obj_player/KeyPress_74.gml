player_is_collect = true
move_speed = 4;
var move_x = keyboard_check(vk_right) - keyboard_check(vk_left); // Di chuyển trái/phải
var move_y = keyboard_check(vk_down) - keyboard_check(vk_up);   // Di chuyển lên/xuống

// Di chuyển Instance
x += move_x * move_speed;
y += move_y * move_speed;