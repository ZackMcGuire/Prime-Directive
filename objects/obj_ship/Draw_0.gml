//draw self
draw_set_color(c_white)
draw_sprite_ext(spr_ship, 1, x, y, 1, 1, image_angle, c_white, main_thrusters)
draw_sprite_ext(spr_ship, 2, x, y, 1, 1, image_angle, c_white, boost_thrusters)
draw_sprite_ext(spr_ship, 0, x, y, 1, 1, image_angle, c_white, 1) 

//draw_text(x, y + 108, main_thrusters)