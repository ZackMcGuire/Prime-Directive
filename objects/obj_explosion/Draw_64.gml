if (timer < Persistent.death_screen_fade_out)
{
	draw_set_color(c_black)
	draw_set_alpha(1 - (timer / Persistent.death_screen_fade_out))
	draw_rectangle(0, 0, room_width, room_height, 0)
	draw_set_color(c_white)
	draw_set_alpha(1)
}