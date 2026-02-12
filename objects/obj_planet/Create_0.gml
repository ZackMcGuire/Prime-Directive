randomize()

image_speed = 0
image_angle = random_range(0, 360)
seed = irandom(1000)

//magic numbers
anti_zero_width = 0.4
atmosphere = 1.05

//variables
if (global.gamemode == 0)
{
	//create the menu object
	menu = instance_create_layer(x, y, "Lower_Menus", obj_planet_menu)
}
color = make_color_hsv(random_range(0, 255), random_range(0, 255), random_range(180, 255)) //gives the planet a random color
delivery = 0 //whether this planet is currently the target of a delivery