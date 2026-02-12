//display game over screen
if (dead == true)
{
	draw_set_font(Font1)
	draw_set_halign(fa_center)
	draw_set_valign(fa_center)
	draw_set_color(c_black)
	
	var x_center = display_get_width()  / 2
	var y_center = display_get_height() / 2
	draw_rectangle(0, 0, x_center * 2, y_center * 2, 0)
	draw_set_alpha(1 - (timer / death_screen_fade_in))
	draw_set_color(c_white)
	
	draw_sprite(spr_death_screen, 0, x_center, y_center)
	draw_text(x_center, y_center - 80, "Game Over")
	draw_text(x_center, y_center - 40, "Score: " + string(Controller.current_score))
	draw_text(x_center, y_center + 40, "[Space]: Play Again")
	draw_text(x_center, y_center + 80, "[Esc]: Main Menu")
	
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	draw_set_alpha(1)
}