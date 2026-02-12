randomize()

//static variables
#macro zoom_change_amount 0.1
global.planet_max_scale = 0.5
min_zoom = 0.3
max_zoom = 2
parallax = 0.8 //larger means larger map. Must be between 0.8 and 0.9
menu_animation_length = 60
easy_planets = 150
hard_planets = 450
minimap_size = 192
minimap_border = 3

//changing variables
global.target_planet_x = 0
global.target_planet_y = 0
global.target_planet_scale = 0
zoom = 1
minimap = -1
minimap_entities = -1
menu_animation = 0
init_width  = min(1366, display_get_width())
init_height = min(768, display_get_height())
menu_width  = sprite_get_width(spr_menu)
menu_height = sprite_get_height(spr_menu)
hor_edge = init_width  / (1 - parallax)
ver_edge = init_height / (1 - parallax)
amount_of_planets = 1
current_score = 0

//create the overlay sprite
if (room == 0)
{
	overlay = instance_create_layer(sprite_get_width(spr_menu) / 2, 
			  sprite_get_height(spr_menu) / 2, "Assets_Upper", obj_overlay)
}

//camera stuff
globalvar menu_camera;
menu_camera = camera_create_view(0, 0, menu_width, menu_height, 
	0, -1, -1, -1, 0, 0);
globalvar main_camera;
main_camera = camera_create_view(0, 0, init_width, init_height, 
	0, obj_camera, -1, -1, init_width / 2, init_height / 2);
minimap_size *= display_get_width() / init_width

//set the view as the camera for rm_menu
view_enabled = true;
view_visible[0] = true;
view_set_camera(0, menu_camera);

//minimap stuff
function refresh_minimap()
{
	var background_aspect_ratio = Persistent.background_height / Persistent.background_width
	minimap = surface_create(minimap_size, minimap_size * background_aspect_ratio) //size of minimap
	var temp_surface = surface_create(Persistent.background_width, 
									  Persistent.background_height) //size of map itself
	//draw spr_background onto the surface
	surface_set_target(temp_surface)
	draw_clear(c_green)
	draw_sprite(spr_background, Persistent.background, 0, 0)
	surface_reset_target()
	
	//scale it down and stick it onto the minimap surface
	surface_set_target(minimap)
	draw_surface_stretched(temp_surface, 0, 0, minimap_size, minimap_size * background_aspect_ratio)
	surface_reset_target()
	surface_free(temp_surface)
}

surface_resize(application_surface, display_get_width(), display_get_height());
display_set_gui_size(display_get_width(), display_get_height());
window_set_size(display_get_width(), display_get_height());
window_center();