if (timer <= 0)
{
	Persistent.dead = true
	Persistent.timer = Persistent.death_screen_fade_in
	instance_destroy()
}
timer--