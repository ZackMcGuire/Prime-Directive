//make F11 toggle fullscreen
if keyboard_check_pressed(vk_return) 
{
	if window_get_fullscreen() {window_set_fullscreen(false)}
	else {window_set_fullscreen(true)}
}

//update highscore
if (global.gamemode == 1) 
{
	if (Persistent.highscore_easy < current_score) {Persistent.highscore_easy = current_score}
}
if (global.gamemode == 2) 
{
	if (Persistent.highscore_hard < current_score) {Persistent.highscore_hard = current_score}
}

//room change keybinds
if keyboard_check_pressed(vk_escape)
{
	if (room != 0 or menu_animation > 0) {audio_play_sound(snd_clack, 5, false, 1)}
	Persistent.dead = false
	room_goto(0)
}
if keyboard_check_pressed(vk_space)
{
	audio_play_sound(snd_clack, 5, false, 1)
	Persistent.dead = false
	room_goto(1)
}

if (room == 0)
{
	//exit if escape is pressed while on the main menu
	if (keyboard_check_pressed(vk_escape))
	{
		if (menu_animation == 0) {game_end()}
	}
				
	//start the animation when the player presses anything other than escape
	else if ((keyboard_check_pressed(vk_anykey) or mouse_check_button_pressed(mb_any)) 
			and !keyboard_check_pressed(vk_return))
	{
		if (menu_animation == 0) 
		{
			menu_animation++
			audio_play_sound(snd_clack, 5, false, 1)
		}
	}
	
	if (menu_animation > 0)
	{
		zoom = lerp(1, 0.345, (1 - cos(pi * menu_animation / menu_animation_length)) / 2)
		
		camera_set_view_pos(menu_camera, (menu_width / 2) * (1 - zoom), (menu_height / 2) * (1 - zoom))
		camera_set_view_size(menu_camera, menu_width * zoom, menu_height * zoom);
		camera_apply(menu_camera)
		
		if (menu_animation < menu_animation_length) {menu_animation++}
		
		//"switch slides" partway through the animation
		if (menu_animation == (menu_animation_length * 0.4)) {overlay.image_index = 1}
	}
}

if (room == 1)
{
	//create a planet upon left clicking
	if (global.gamemode == 0)
	{
		if (mouse_check_button_pressed(mb_left))
		{
			//make sure there are no planets or menus at the position
			if (instance_position(mouse_x, mouse_y, obj_planet_menu) < 0
			 && instance_position(mouse_x, mouse_y, obj_planet)      < 0)
			{
				//makes the planet half of max size in sandbox mode
				var planet = instance_create_layer(mouse_x, mouse_y, "Instances", obj_planet)
				planet.scale = global.planet_max_scale / 2 
				planet.image_xscale = planet.scale;
				planet.image_yscale = planet.scale;
				audio_play_sound(snd_planet_placement, 10, false, 1)
			}
		}
	}
	
	//zoom in
	if mouse_wheel_up()
	{
		if zoom - zoom_change_amount >= min_zoom
		{
			zoom -= zoom_change_amount
			camera_set_view_size(main_camera, init_width * zoom, init_height * zoom);
			camera_set_view_border(main_camera, init_width * zoom / 2, init_height * zoom / 2);
			camera_apply(main_camera)
			Persistent.saved_zoom = zoom
		}
	}
	
	//zoom out
	if mouse_wheel_down()
	{
		if zoom + zoom_change_amount <= max_zoom
		{
			zoom += zoom_change_amount
			camera_set_view_size(main_camera, init_width * zoom, init_height * zoom);
			camera_set_view_border(main_camera, init_width * zoom / 2, init_height * zoom / 2);
			camera_apply(main_camera)
			Persistent.saved_zoom = zoom
		}
	}
}