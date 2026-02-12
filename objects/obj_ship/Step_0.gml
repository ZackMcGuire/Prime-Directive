if (visible == 0) {return} //prevents the ship from doing anything, including draw events

//take inputs
if (keyboard_check(ord("W")) or keyboard_check(vk_up)) {global.player_1_forward = 1; no_gravity = false} 
else {global.player_1_forward = 0}
if (keyboard_check(ord("A")) or keyboard_check(vk_left))  {global.player_1_left  = 1;} 
else {global.player_1_left = 0}
if (keyboard_check(ord("D")) or keyboard_check(vk_right)) {global.player_1_right = 1;} 
else {global.player_1_right = 0}

//spin
image_angle += (global.player_1_left - global.player_1_right) * spin

//thrust
if (global.player_1_forward == 1)
{
	x_velocity -= sin(degtorad(image_angle)) * thrust * boost;
	y_velocity -= cos(degtorad(image_angle)) * thrust * boost;
	if (main_thrusters < 1) {main_thrusters += 0.15;}
	if (boost > 1 and boost_thrusters < 1) {boost_thrusters += 0.1;}
}
else if (main_thrusters > 0) {main_thrusters -= 0.15;}
if ((boost <= 1 or global.player_1_forward != 1) and boost_thrusters > 0) {boost_thrusters -= 0.05;}

//bounce off edges
var hor_edge = Controller.hor_edge
var ver_edge = Controller.ver_edge
var width  = Persistent.background_width  / (1 - Controller.parallax)
var height = Persistent.background_height / (1 - Controller.parallax)
if (x + x_velocity < hor_edge or x + x_velocity > width  - hor_edge) {x_velocity = -x_velocity; audio_play_sound(snd_screen_bounce, 5, false, 0.5 + (abs(x_velocity) / 50))}
if (y + y_velocity < ver_edge or y + y_velocity > height - ver_edge) {y_velocity = -y_velocity; audio_play_sound(snd_screen_bounce, 5, false, 0.5 + (abs(y_velocity) / 50))}

//pixel perfect movement in sandbox mode, destroy in delivery mode
if position_meeting(x + x_velocity, y + y_velocity, obj_planet)
{
	//create an explosion, and "deactivate" the ship by turning off visibility
	if (global.gamemode >= 1)
	{
		var x1 = x + x_velocity
		var y1 = y + y_velocity
		//layer
		var inversion = 2 * irandom(1) - 1 //randomly flip the explosion
		var planet_collided = instance_position(x1, y1, obj_planet)
		var explosion = instance_create_layer(x1, y1, "Instances", obj_explosion)
		var force = power(sqrt(sqr(x_velocity) + sqr(y_velocity)) + 1, 0.8)
		explosion.image_angle = point_direction(planet_collided.x, planet_collided.y, x1, y1) - 90
		explosion.image_xscale = force / 8 * inversion
		explosion.image_yscale = force / 8
		explosion.image_speed = 1.5 / sqrt(force)
		planet_collided.layer--
		explosion.layer--
		visible = false
		audio_play_sound(snd_explosion, 10, false, 1)
		
		//reset a lot of variables
		global.player_1_left = 0
		global.player_1_right = 0
		global.player_1_forward = 0
		main_thrusters = 0
		boost_thrusters = 0
	}
	else
	{
		//move up to touching the planet
		for (i = 0; i < abs(floor(max(x_velocity, y_velocity))); i++)
		{
			if (i < abs(floor(x_velocity)))
			{
				if (!position_meeting(x + sign(x_velocity), y, obj_planet)) {x += sign(x_velocity)}
			}
			if (i < abs(floor(y_velocity)))
			{
				if (!position_meeting(x, y + sign(y_velocity), obj_planet)) {y += sign(y_velocity)}
			}
		}
		//lose velocity instantly
		x_velocity = 0
		y_velocity = 0
	}
}

//grace period at the beginning of the game
if (no_gravity == true)
{
	x_velocity = 0
	y_velocity = 0
}

//actually move
x += x_velocity
y += y_velocity

//calculate gravity
x_gravity = 0
y_gravity = 0
boost = 1
touching_planet = 0

for (var i = 0; i < instance_number(obj_planet); ++i;)
{
	var planet = instance_find(obj_planet,i)
	var x0 = planet.x - x
	var y0 = planet.y - y
	var distance = sqrt(sqr(x0) + sqr(y0))
	var surface_radius = (planet.scale * sprite_get_width(spr_planet)) / 2
	
	//have normal gravity outside of a planet
	if (distance > surface_radius)
	{
		x_gravity += (power(surface_radius, 3) * x0) / (power(distance, 3))
		y_gravity += (power(surface_radius, 3) * y0) / (power(distance, 3))
	}
	//simulate planets having an atmosphere
	if (distance < (surface_radius * planet.atmosphere))
	{
		x_velocity *= 0.96
		y_velocity *= 0.96
	}	
	
	//have better thrust near the surface of larger planets
	if (distance < (surface_radius * power(planet.atmosphere, 6)))
	{
		if (planet.scale > (global.planet_max_scale * 0.4)) {boost = blue_boost}
	}
	
	//stop all gravity if inside any planet
	if (distance <= surface_radius) 
	{
		touching_planet = 1
		x += 2 * -x0 / sprite_get_width(spr_planet)
		y += 2 * -y0 / sprite_get_height(spr_planet)
	}
}
if (touching_planet >= 1)
{
	x_gravity = 0
	y_gravity = 0
}
x_velocity += x_gravity * grav * 0.01
y_velocity += y_gravity * grav * 0.01

//deliver package
if (global.gamemode >= 1)
{
	var x0 = global.target_planet_x - x
	var y0 = global.target_planet_y - y
	var distance = sqrt(sqr(x0) + sqr(y0))
	if (package_drop_cooldown == 0)
	{
		if (distance < 100 + (500 * global.target_planet_scale))
		{
			var package = instance_create_layer(x, y, "Instances", obj_package)
			package_drop_cooldown = 500 //don't send a package to the same planet twice
			package.inherited_velocity = sqrt(sqr(x_velocity) + sqr(y_velocity))
			package.target_x0 = x0
			package.target_y0 = y0
			package.target_distance = distance
			audio_play_sound(snd_sendoff, 10, false, 1)
		}
	}
	if (no_gravity == false) {delivery_timer++}
	if (package_drop_cooldown) > 0 {package_drop_cooldown--}
}

//calculate state
if (global.player_1_forward == 0) {state = 0}
if (global.player_1_forward == 1 and boost <= 1) {state = 1}
if (global.player_1_forward == 1 and boost >  1) {state = 2}