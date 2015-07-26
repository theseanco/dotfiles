
ClockFace			digital clock counter display

*new(starttime, tempo, inc)
	creates a new ClockFace and GUI that, when played, will start at starttime and increment by inc
	according to tempo (in beats per SECOND).

play
	starts the clock

stop
	stops the clock
	
cursecs_(curtime)
	sets the time on the clock to curtime. curtime is passed in seconds.
	
tempo_(newBPS)
	sets the current tempo in beats per second. Adjusts the internal TempoClock.

mod
	tell the ClockFace to calculate curtime with a modulo. Set to 0 or nil to remove a modulo.

onMod
	when a mod is set, a Function to evaluate when the  clock resets to 0.
	
onBeat
	if notNil, a Function to be evaluated whenever a new integer boundry is crossed. Can be used
	for metronomic functions.

Examples

////////////////////////

// simple basic clock
a = ClockFace.new;
a.play;
a.stop;

a.window.close;

// uses as a metronome

a = ClockFace.new;

// change the tempo of the time change
a.tempo_(92/60);
a.mod_(4);

a.onBeat_({arg curBeat;
	curBeat.postln;
	curBeat.even.if({
		(curBeat == 2).if({
			a.window.view.background_(Color.red(0.9))
			}, {
			a.window.view.background_(Color.red(0.6))
			})
		}, {
		a.window.view.background_(Color.white)
		})
	});

a.play;	

// change the tempo at the next bar
a.onMod_({a.tempo_(30/60)});
a.onMod_({"Works!".postln; a.tempo_(120/60)});

a.stop;


