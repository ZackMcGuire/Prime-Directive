//movement
if (inherited_velocity < minimum_velocity) {inherited_velocity = minimum_velocity}
x += inherited_velocity * target_x0 / target_distance
y += inherited_velocity * target_y0 / target_distance

//destruction
if (position_meeting(x, y, obj_planet))
{
	//give up to 100 points based on delivery completion time
	Controller.current_score += min(100, ceil(200 / (sqrt(obj_ship.delivery_timer / 85) + 0.5)))
	
	//find a new planet and set it as the target
	// if it happens to choose the exact same one, then choose the next planet in the list
	// this is why it can only normally choose between planets 0 and n-2,
	// so that planet n-1 is reserved for the rare duplicate planet n-2
	var new_target_planet = irandom_range(0, Controller.amount_of_planets - 2)
	for(var i = 0; i < Controller.amount_of_planets; i++)
	{
		var planet = instance_find(obj_planet, i);
		
		if (planet.delivery == 1)
		{
			planet.delivery = 0
			if (i == new_target_planet) {new_target_planet++}
		}
		else if (i == new_target_planet)
		{
			planet.delivery = 1
		}
	}
		
	//reset variables and self-delete
	obj_ship.delivery_timer = 1
	obj_ship.package_drop_cooldown = 0
	audio_play_sound(snd_delivery, 10, false, 0.3)
	instance_destroy()
}