//calculate planet's scale based on slider's position
if (global.gamemode == 0)
	{scale = ((menu.slider_percentage + anti_zero_width) / (1 + anti_zero_width)) * global.planet_max_scale}

//scale collision mask
image_xscale = scale;
image_yscale = scale;
	
if (global.gamemode == 0)
{
	//reactivate menu when clicked on
	if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, id))
	{
		instance_activate_object(menu)
		menu.image_xscale = Controller.zoom
		menu.image_yscale = Controller.zoom
	}
}

if (global.gamemode >= 1)
{
	//broadcast location in delivery mode
	if (delivery == 1)
	{
		global.target_planet_x = x
		global.target_planet_y = y
		global.target_planet_scale = scale
	}
}