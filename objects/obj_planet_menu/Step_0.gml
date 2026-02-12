image_xscale = Controller.zoom
image_yscale = Controller.zoom

//deactivate when clicked off of
if ((mouse_check_button_pressed(mb_left) or mouse_check_button_pressed(mb_right))
   && !position_meeting(mouse_x, mouse_y, id))
{
	holding = false
	instance_deactivate_object(self)
}

//move slider
if mouse_check_button_released(mb_left) {holding = false}
if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, id))
{
	holding = true
	slider_percentage = (mouse_x - x + (bar_width * Controller.zoom / 2)) / (bar_width * Controller.zoom)
}
if (mouse_check_button(mb_left) && holding == true)
{
	slider_percentage = (mouse_x - x + (bar_width * Controller.zoom / 2)) / (bar_width * Controller.zoom)
}

//clamp the slider to the bar
if (slider_percentage > 1) {slider_percentage = 1}
if (slider_percentage < 0) {slider_percentage = 0}