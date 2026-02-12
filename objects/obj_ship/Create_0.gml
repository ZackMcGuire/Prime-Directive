randomize()

//static variables
image_speed = 0
#macro grav 0.3
#macro thrust 0.2
#macro spin 3
#macro blue_boost 2

//changing variables
global.player_1_right = 0
global.player_1_left = 0
global.player_1_forward = 0
boost = 1
x_velocity = 0
y_velocity = 0
x_gravity = 0
y_gravity = 0
state = 0
touching_planet = 0
main_thrusters = 0
boost_thrusters = 0
delivery_timer = 1
package_drop_cooldown = 0
no_gravity = true

//spawn the ship with a random orientation
image_angle = random(360)

instance_create_layer(x, y, "Instances", obj_camera)