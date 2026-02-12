if (room == 0)
{
	//add main menu text
	draw_set_font(Font2)
	draw_set_halign(fa_right)
	draw_text(sprite_get_width(spr_menu) - 32, 32, "Developer: Zack McGuire")
	draw_text(sprite_get_width(spr_menu) - 32, 32 + 100, "Music: deadmau5 - Strobe")
	draw_set_halign(fa_left)
	draw_text(32, 32, "[Enter]: Toggle Fullscreen")
	draw_text(32, 32 + 100, "[Esc]: Quit")
}

if (room == 1)
{
	//draw the borders in rm_play
	draw_sprite_ext(spr_black, 0, 0, 0, width - hor_edge, ver_edge, 0, c_white, 0.5)
	draw_sprite_ext(spr_black, 0, width - hor_edge, 0, hor_edge, height - ver_edge, 0, c_white, 0.5)
	draw_sprite_ext(spr_black, 0, hor_edge, height - ver_edge, width - hor_edge, ver_edge, 0, c_white, 0.5)
	draw_sprite_ext(spr_black, 0, 0, ver_edge, hor_edge, height - ver_edge, 0, c_white, 0.5)
}