
Player			A soundfile player and BFormat Decoder


Player.new(soundfilepath, formatOut, starttime, outbus, amp)
	all arguments are optional
	soundfilepath - the path (complete or relative) to a soundfile
	formatOut - a string. defaults to \straight which simply plays the soundfile directly to the output.
		If your file is a BFormat file (3 or 4 channel) you can choose:
		\stereo
		\uhj
		\quad
		\hex
	starttime - an initial starttime for playback
	outbus - the starting outbus for playback
	amp - an initial amp value
	xywz- true or false.  This wil decode Ambsonic files recorded for middle side monitoring. (default is false)
	env- any fixed duration envelope (Env, InterplEnv, InterplXYC) to be played over the soundfiles duration

Player uses the internal server, and will boot it for you if it isn't already running

Instance Methods

play- plays the soundfile.
pause- pauses the soundfile.  Playback begins where the file is paused
stop - stops the soundfile. Playback begins from starttime
formatOut - changes the output format
starttime - change the starttime
endtime - change the endtime
gui - create a GUI controller with optional scope

Examples:

// create a new player
a = Player.new("sounds/a11wlk01-44_1.aiff")

// play it
a.play;

// pause it
a.pause;

// play it again
a.play;

// stop it
a.stop;

// create a GUI
a.gui;




