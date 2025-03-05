// Tính trung điểm theo trục Y dựa trên collision box
var midpoint_y = bbox_top + (bbox_bottom - bbox_top) * 0.5;

// Gán độ sâu dựa trên midpoint_y
depth = -midpoint_y;       