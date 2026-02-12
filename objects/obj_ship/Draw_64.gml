draw_set_color(c_white)
//draw_text(500, 300, x_velocity);

//display the tracking arrow or not
if (global.gamemode >= 1)
{
	var target_distance = sqrt(sqr(global.target_planet_x - x) + sqr(global.target_planet_y - y))
	if (target_distance > 500)
	{
		var transparency = 1
		if (target_distance < 1000) {transparency = (target_distance - 500) / 500}
		
		//set the properties of the tracking arrow
		var target_direction = point_direction(x, y, global.target_planet_x, global.target_planet_y)
		var arrow_distance = 50 + 500 * (target_distance / room_width)
		var arrow_x = display_get_width()  / 2 + (arrow_distance *  cos(degtorad(target_direction)))
		var arrow_y = display_get_height() / 2 + (arrow_distance * -sin(degtorad(target_direction)))
		
		//draw the tracking arrow, making sure it stays clamped to the screen's bounds
		var arrow_width  = sprite_get_width(spr_arrow)
		var arrow_height = sprite_get_height(spr_arrow)
		if arrow_x < 2*arrow_width  {arrow_x = 2*arrow_width }
		if arrow_y < 2*arrow_height {arrow_y = 2*arrow_height}
		if arrow_x > display_get_width()  - 2*arrow_width  {arrow_x = display_get_width()  - 2*arrow_width }
		if arrow_y > display_get_height() - 2*arrow_height {arrow_y = display_get_height() - 2*arrow_height}
		draw_sprite_ext(spr_arrow, 0, arrow_x, arrow_y, power(arrow_distance, 1/7) * ln(arrow_distance) / 8, power(arrow_distance, 1/4) * ln(arrow_distance) / 15, target_direction - 90, c_white, 0.9 * transparency)
	}
}