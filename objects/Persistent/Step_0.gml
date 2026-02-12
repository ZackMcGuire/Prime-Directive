//play sound for thruster
if (!instance_exists(obj_ship)) {audio_sound_gain(audio_thruster, 0, 0)}
else {audio_sound_gain(audio_thruster, (4 * obj_ship.main_thrusters + obj_ship.boost_thrusters) / 5, 17)}

//play sound for rotation
if (!instance_exists(obj_ship)) {audio_sound_gain(audio_rotation, 0, 0)}
else {audio_sound_gain(audio_rotation, 0.15 * (sign(global.player_1_left + global.player_1_right)), 50)}

if (timer > 0) {timer--}

switch (background)
{
	case 0:
		background_width  = 5053
		background_height = 3644
		break;
	case 1:
		background_width  = 4000
		background_height = 4000
		break;
	case 2:
		background_width  = 5000
		background_height = 4354
		break;
	case 3:
		background_width  = 5014
		background_height = 5053
		break;
	case 4:
		background_width  = 4000
		background_height = 3973
		break;
}