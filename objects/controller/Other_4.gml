///Room Start is identical to Create, since Controller isn't persistent, but it just...feels different
//set the view as the camera for rm_play
if (room == 1)
{
	view_enabled = true;
	view_visible[0] = true;
	view_set_camera(0, main_camera);
	
	//remember zoom
	zoom = Persistent.saved_zoom
	camera_set_view_size(main_camera, init_width * zoom, init_height * zoom);
	camera_set_view_border(main_camera, init_width * zoom / 2, init_height * zoom / 2);
	camera_apply(main_camera)
	
	//update room size
	width  = Persistent.background_width  / (1 - parallax)
	height = Persistent.background_height / (1 - parallax)

	//spawn the ship in a random location
	ship_x = irandom_range(hor_edge, width  - hor_edge)
	ship_y = irandom_range(ver_edge, height - ver_edge)
	instance_create_layer(ship_x, ship_y, "Instances", obj_ship)
	
	//spawn random planets
	if (global.gamemode >= 1)
	{
		if (global.gamemode == 1) {amount_of_planets = easy_planets}
		if (global.gamemode == 2) {amount_of_planets = hard_planets}
		var starting_planet = irandom_range(0, amount_of_planets - 2)
		forbidden_x[amount_of_planets] = ship_x
		forbidden_y[amount_of_planets] = ship_y
		for(var i = 0; i < amount_of_planets; i++)
		{
			//for each planet, attempt to place it a bunch of times
			for(var j = 0; j < 1000; j++)
			{
				//choose a random spawn location
				var spawn_x = irandom_range(hor_edge, width  - hor_edge)
				var spawn_y = irandom_range(ver_edge, height - ver_edge)
				
				//run through the array, and if this place is too close to something else, loop again
				for(var k = 0; k <= amount_of_planets; k++)
				{
					if (abs(spawn_x - forbidden_x[k]) < 256 and abs(spawn_y - forbidden_y[k]) < 256)
					{
						k = amount_of_planets + 3
					}
				}
				
				//if the spot is clear, add it to the array of object locations
				if (k != amount_of_planets + 4)
				{
					var new_planet = instance_create_layer(spawn_x, spawn_y, "Instances", obj_planet)
					new_planet.scale = random_range(global.planet_max_scale / 5, global.planet_max_scale)
					if (i == starting_planet) {new_planet.delivery = 1} //choose a random planet as the first target
					forbidden_x[i] = spawn_x
					forbidden_y[i] = spawn_y
					j = 1000000
				}
			}
		}
	}
}