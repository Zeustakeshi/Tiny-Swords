
if (mouse_check_button_pressed(mb_left)) {
	var mouse_x_in_room = mouse_x;
    var mouse_y_in_room = mouse_y;
 
    with (obj_flag) {
        instance_destroy();
    }
    instance_create_layer(mouse_x_in_room, mouse_y_in_room, "Instances_Flag", obj_flag);

}