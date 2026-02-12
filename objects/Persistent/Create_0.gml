death_screen_fade_out = 30 //how long in frames to fade out for, immediately after explosion ends
death_screen_fade_in = 30  //how long in frames to spend fading in
timer = -1
background = 0
highscore_easy = 0
highscore_hard = 0
saved_zoom = 1

//load all the textures on launch, so gameplay doesn't stutter
texture_prefetch("Default") 

//initiate sounds
audio_thruster = audio_play_sound(snd_thruster, 0, true, 0)
audio_rotation = audio_play_sound(snd_rotation, 0, true, 0)
audio_play_sound(snd_background_music, 0, true, 0.25)

//load highscore (saving is done in obj_explosion)
var file = working_directory + "highscores"
if (file_exists(file))
{
	var handle = file_text_open_read(file)
	highscore_easy = file_text_read_real(handle)
	highscore_hard = file_text_read_real(handle)
	file_text_close(handle)
}

//set the window title
window_set_caption("Prime Directive")
window_set_fullscreen(1)