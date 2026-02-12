//choose which sprite to display (global.planet_max_scale * 0.6 is the halfway mark)
if (scale <  global.planet_max_scale * 0.7) {image_index = seed mod 8}
if (scale >= global.planet_max_scale * 0.7) {image_index = seed mod 5 + 8}

draw_sprite_ext(spr_planet, image_index, x, y, scale, scale, image_angle, color, 1)
if (delivery == 1) {draw_sprite_ext(spr_package_indicator, 0, x, y, scale, scale, 0, c_white, 1)}