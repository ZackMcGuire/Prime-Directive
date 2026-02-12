timer = 100000

//save highscore (loading is done in Persistent)
var file = working_directory + "highscores"
var handle = file_text_open_write(file)
file_text_write_real(handle, Persistent.highscore_easy)
file_text_write_real(handle, Persistent.highscore_hard)
file_text_close(handle)