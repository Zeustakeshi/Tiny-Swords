global.menu_bar_items = [
 
    {
        sprite: spr_house_blue, // Thay bằng tên sprite của item 2
        price: [75, 50, 100],         // Giá tiền (gỗ, vàng, thịt)
        name: "Warrior",
		object: obj_house_warrior
    },
	{
        sprite: spr_tower_blue, // Thay bằng tên sprite của item 1
        price: [100, 50, 75],         // Giá tiền (gỗ, vàng, thịt)
        name: "Archer",     // Tên item (có thể dùng để hiển thị tooltip hoặc debug)
		object: obj_tower_archer
    },
    {
        sprite: spr_house_yellow, // Thay bằng tên sprite của item 3
        price: [200, 20, 100],        // Giá tiền (gỗ, vàng, thịt)
        name: "Pawn",
		object: obj_house_pawn
    }
];

global.selected_menu_bar_item = -1;






