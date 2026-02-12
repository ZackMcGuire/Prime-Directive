if instance_exists(obj_ship)
{
	var ship_velocity = sqrt(sqr(obj_ship.x_velocity) + sqr(obj_ship.y_velocity))
	var move = percent * (arctan(ship_velocity / 8) + 1)
	x += percent * (obj_ship.x - x)
	y += percent * (obj_ship.y - y)
}