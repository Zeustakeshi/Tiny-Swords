if (alarm[0] >= 0) {
    var _self = self;

    with (obj_base_goblin) {
      
        // Kiểm tra nếu created_by tồn tại và bằng với _self
        if (created_by != noone && created_by == _self) {
            is_attack_village = true;
        }
    }

    // Cập nhật lại alarm sau khi thực hiện hành động
    alarm[0] = global.game_speed  * attack_delay_time; 
}