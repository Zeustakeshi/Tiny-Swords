// Inherit the parent event
event_inherited();


if (status >= 0 && status <= 2 && status_sprites[status] != noone) {
	 sprite_index = status_sprites[status];
}



if (current_health <= 0) {
	status = 2;
	if (status_sprites[status] == noone) {
		instance_destroy()
		init_grid()
	}
}