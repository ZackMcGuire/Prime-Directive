draw_self()

draw_sprite_ext(spr_slider, 0, 
	x + (bar_width * Controller.zoom) * (slider_percentage - 1/2), 
	y - Controller.zoom * slider_y, Controller.zoom, Controller.zoom, 0, c_white, 1)