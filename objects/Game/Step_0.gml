
if (mouse_check_button_pressed(mb_right)) {
	var mouse_x_in_room = mouse_x;
    var mouse_y_in_room = mouse_y;
 
    with (obj_flag) {
        instance_destroy();
    }
    instance_create_layer(mouse_x_in_room, mouse_y_in_room, "Instances_game", obj_flag);

}


if (keyboard_check(vk_escape)) {
    with (obj_flag) {
        instance_destroy();
    }
}