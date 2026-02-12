if (room == 1)
{
	//draw_text(200, 200 + 40, "init_width: " + string(round(init_width)))
	//draw_text(200, 200 + 160, "obj_camera.x: " + string(round(obj_camera.x)))
	//draw_text(200, 200 + 200, "ship velocity: " + string(round(sqrt(sqr(obj_ship.x_velocity) + sqr(obj_ship.y_velocity))))) 

	//draw the minimap with a border
	var background_aspect_ratio = height / width
	if (!surface_exists(minimap)) {refresh_minimap()}
	draw_rectangle(display_get_width() - 16 - minimap_size - minimap_border, 16 - minimap_border, 
		display_get_width() - 16 + minimap_border - 1, 16 + floor(minimap_size * background_aspect_ratio) + minimap_border - (display_get_width() / init_width), 0)
	draw_surface(minimap, display_get_width() - 16 - minimap_size, 16)
	
	//draw the rocket and target planet to the minimap
	if (!surface_exists(minimap_entities)) {minimap_entities = surface_create(minimap_size, minimap_size * background_aspect_ratio)}
	surface_set_target(minimap_entities)
	draw_clear_alpha(c_black, 0.0)
	if (global.gamemode >= 1) draw_sprite_ext(spr_package, 0, minimap_size * global.target_planet_x / width, minimap_size * background_aspect_ratio * global.target_planet_y / height, 0.5, 0.5, 0, c_white, 1)
	draw_sprite_ext(spr_ship, 0, minimap_size * obj_ship.x / width, minimap_size * background_aspect_ratio * obj_ship.y / height, 0.35, 0.35, obj_ship.image_angle, c_white, 1)
	surface_reset_target()
	draw_surface(minimap_entities, display_get_width() - 16 - minimap_size, 16)

	//draw ship controls
	draw_set_font(Font1)
	draw_set_halign(fa_right)
	draw_set_valign(fa_bottom)
	draw_text(display_get_width() - 16, display_get_height() - 16 - 40, "Scroll to zoom")
	draw_text(display_get_width() - 16, display_get_height() - 16, "W,A,D to move")
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	
	//draw the score (if in delivery mode)
	if (global.gamemode >= 1)
	{
		draw_text(16, 16, "Score: " + string(current_score))
		if (global.gamemode == 1) {draw_text(16, 16 + 40, "Highscore: " + string(Persistent.highscore_easy))}
		if (global.gamemode == 2) {draw_text(16, 16 + 40, "Highscore: " + string(Persistent.highscore_hard))}
	}
	
	//draw menu controls (if in sandbox mode)
	if (global.gamemode == 0)
	{
		draw_text(16, 16, "[Space]: Restart")
		draw_text(16, 16 + 40, "[Esc]: Main Menu")
	}
}