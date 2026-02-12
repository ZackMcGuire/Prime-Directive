if (image_index == 1)
{
	if (keyboard_check_pressed(ord("A")))
	{
		global.gamemode = 0
		image_index = 2
		play_audio = true
	}
	if (keyboard_check_pressed(ord("B")))
	{
		global.gamemode = 1
		image_index = 2
		play_audio = true
	}
	if (keyboard_check_pressed(ord("C")))
	{
		global.gamemode = 2
		image_index = 2
		play_audio = true
	}
}

else if (image_index == 2)
{
	if (keyboard_check_pressed(ord("A")))
	{
		Persistent.background = 0
		alarm[0] = 1
		play_audio = true
	}
	if (keyboard_check_pressed(ord("B")))
	{
		Persistent.background = 1
		alarm[0] = 1
		play_audio = true
	}
	if (keyboard_check_pressed(ord("C")))
	{
		Persistent.background = 2
		alarm[0] = 1
		play_audio = true
	}
	if (keyboard_check_pressed(ord("D")))
	{
		Persistent.background = 3
		alarm[0] = 1
		play_audio = true
	}
	if (keyboard_check_pressed(ord("E")))
	{
		Persistent.background = 4
		alarm[0] = 1
		play_audio = true
	}
}
if (play_audio == true) 
{
	audio_play_sound(snd_clack, 5, false, 1)
	play_audio = false
}