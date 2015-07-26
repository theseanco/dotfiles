
ProcMod	/ ProcEvents		A real-time control structure!

ProcMod - A structure for controlling modular processes.
ProcEvents - An event manager for ProcMod with GUI control capabilities.

SEE ALSO: ProcModR - even cooler then ProcMod.

ProcMod

Class Methods

*new(env, amp, id, group, addAction, target, function, releaseFunc, onReleaseFunc, responder,
		timeScale, lag, clock, server)
*play(env, amp, id, group, addAction, target, function, releaseFunc, onReleaseFunc, responder,
		timeScale, lag, clock, server)

	env - an overall amplitude envelope that synths created in a ProcMod function can access. This will run
		a .kr env on ProcMod.envbus that can be read by other synths in the ProcMod through the creation
		of a procmodenv synth. There is a max of 20 breakpoints to the env. If the Env has a releaseNode,
		ProcMod will continue to process events until .release is called.
	amp - an overall amplitude control for an instance of ProcMod.
	id - a \symbol or "string" to be used later to identify an instance of ProcMod.
	group - a group for an instance of ProcMod to run in. Defaults to nil and a new group is created. If 
		ProcMod creates the group, a new one is created on each .play call.
	addAction - an addAction for this instance of ProcMod. Defaults to 0.
	target - a target for this instance of ProcMod. Defaults to 1.
	function - a Function, Task or Routine to be evaluated on the playing of this instance of ProcMod.
		If a Function is passed in that returns a Task or Routine, the ProcMod will become 're-triggerable'
		and will allow for overlapping getures (it can be released and restarted immediately). All Functions,
		when evaluated, will have the current group id and envbus passed in as an argument.
	releaseFunc - a Function, Task or Routine to be evaluated after the ProcMod has finished its release
	onReleaseFunc - a Function, Task or Routine to be evaluated at release time.
	responder -  an instance of OSCresponder or OSCresponderNode for use by this instance 
		of ProcMod. It is automatically added when the ProcMod starts, and released after the ProcMod
		finishes its release.
	timeScale - applies a scale function to the ProcMod envelope. Defaults to 1.
	lag - applies to chages to the amp value passed into this instance of ProcMod.
	clock - an intance of Clock to run this instance of ProcMod. Defaults to SystemClock.
	server - an instance of Server to run this ProcMod on. Useful for remote servers. 
		Defaults to Server.default.

Instance methods

play - evaluates this instance of ProcMod. ProcMod.function is evaluated, 
	and ProcMod.responder is set up if they are declared. 
	
value - same as .play.

release - releases an instance of ProcMod. If ProcMod.env has a release section, functions and
	OSCresponders wait until this has executed before releasing the ProcMods functionality.
	
kill - immediately free the ProcMod, regardless of ProcMod.env.

group - return the current group of this instance of ProcMod.

envbus - return the current control bus id the global envelope is written to for this instance of ProcMod.
	
env_( Env or Number) - an instance of Env to be sent to the synthdef controlling an instance of ProcMods 
	overall amplitude and event control. If a Number is passed in, it will represent a releasetime for the 
	ProcMod.
	
function_( func ) - an instance of Function, Task or Routine to be evaluated on ProcMod.play. If a Function is 
	passed in, the ProcMod will become 're-triggerable' and can be restarted after it has been released. If
	a Function is passed in, it may return a Task or Routine. The function is passed the ProcMod's current
	group and envbus as args.

releaseFunc_( func )  - an instance of Function, Task or Routine to be evaluated after a ProcMod has released.

onReleaseFunc_( func )  - an instance of Function, Task or Routine to be evaluated the moment a ProcMod is
 	released.

responder_( OSCresponder) - an instance of OSCresponder or OSCresponderNode for use by an instance 
	of ProcMod.

amp_( val ) -  If there is an envelope controlling the overall amplitude of events, set the amplitude to val.

lag_( val ) -  If there is an envelope controlling the overall amplitude of events, set the lag time for changes of 
	amplitude to take effect (with the amp_ instance method)
	
saveToData( Association ) -  places the Association into a Dictionary for later access. Any Association may be 
	stored. 

Examples:

SynthDef(\singrain, {arg freq, amp, dur, envbus;
	OffsetOut.ar(0, 
		Pan2.ar(
			SinOsc.ar(freq, 0, amp) * 
				EnvGen.kr(Env.sine(dur, amp), doneAction: 2) *
				In.kr(envbus),
			Rand.new(-1.0, 1.0)
		)
	) // read off the overall env control of the ProcMod
}).load(s);
	
// create a new proc mod, and assign a function to it
a = ProcMod.new(Env([0, 1, 0], [1, 1], \sin, 1), server: s);
a.function_({arg group, envbus, server;
	Task({
		inf.do({
			// start a new synth... run it inside this ProcMod's group,
			// and read control values off the envbus
			server.sendMsg(\s_new, \singrain, server.nextNodeID, 0, group,
				\freq, 440.rrand(1760), \amp, 0.1, \dur, 5, \envbus, envbus);
			0.5.wait;
			})
		});
	});

// play it
a.play;
// change the amp
a.amp_(2);
// change the lag
a.lag_(0.5);
// change the amp again
a.amp_(5);
// release it
a.release;

// creating ProcMods in a functional way

a = {arg amp, env, high, low, winsize, overlaps;
	var proc;
	// defaults to Server.default if no Server is supplied
	proc = ProcMod.new(env, amp);
	proc.function_({arg group, envbus, server;
		Task({
			inf.do({
				// start a new synth... run it inside this ProcMod's group,
				// and read control values off the envbus
				server.sendMsg(\s_new, \singrain, server.nextNodeID, 0, group,
					\freq, high.rrand(low), \amp, 1, \dur, winsize, 
					\envbus, envbus);
				(winsize / overlaps).wait;
				})
			});
		});
	};

// create new instances of ProcMod... store it to the variables 'b' and 'c'
b = a.value(0.2, Env([0, 1, 0], [1, 1], \sin, 1), 2000, 1000, 0.1, 4);
c = a.value(0.3, Env([0, 1, 0], [10, 0.1], [5, -10], 1), 440, 880, 0.4, 2);

b.play; c.play;

b.release; 
c.release;

Re-triggerable ProcMods

ProcMods are meant for the most part, to be played and released. However, if the function slot is passed a Function object, they can be re-triggered after they have been released. If the Function returns a Task or Routine, the ProcMod will function as though a Task or Routine were placed in the function slot (it will be started and released in the same way). Re-triggered events will be assigned a new group and envbus, so these are made available to the Function through arguments. If an OSCresponderNode or releaseFunc are needed for each re-triggered event, they should be assigned inside the Function:

SynthDef(\trig, {arg id, val;
	SendTrig.kr(Impulse.kr(10), id, val);
	}).load(s);
	
SynthDef(\singrain, {arg freq, amp, dur, envbus;
	OffsetOut.ar(0, 
		Pan2.ar(
			SinOsc.ar(freq, 0, amp) * 
				EnvGen.kr(Env.sine(dur, amp), doneAction: 2) *
				In.kr(envbus),
			-1.0.rrand(1.0)
		)
	) // read off the overall env control of the ProcMod
}).load(s);

i = 0;
s.boot;
a = ProcMod.new(Env([0, 1, 0], [1, 3], \sin, 1), server: s);
// use a function. This one returns the Task. group and envbus are passed in as args
a.function_({arg group, envbus, server;
	a.responder_(
			OSCresponderNode(a.server.addr, '/tr', {arg time, resp, msg;
				(msg[2] == group).if({msg[3].postln})
				})
		);
	Task({
		s.sendMsg(\s_new, \trig, a.server.nextNodeID, 0, group, \id, group,
			\val, i);
		i = i + 1;
		inf.do({
			// start a new synth... run it inside this ProcMod's group,
			// and read control values off the envbus
			server.sendMsg(\s_new, \singrain, server.nextNodeID, 0, 
				group, \freq, 440.rrand(880) * i, \amp, 0.1, \dur, 5, 
				\envbus, envbus);
			0.05.wait;
			});
		});
	});

a.play; // play the ProcMod
// release the current event, and start a new one immediately. These will overlap.
a.release; a.play; // watch the posted values from the OSCresponderNode
a.release;

ProcEvents

Class Methods

*new(events, amp, initmod, killmod, id, server)

	events - an array of events (ProcMods or a function) to play / release  in the following format:
			[ProcMod, ProcMod.id to release]
		both the events to play and release may also be arrays, or nil.
		If the event is a function, realize that it is best to be a single shot type of thing, you won't be able to
		access it later (to stop a loop, for instance). So, make sure it is something that you set to run
		or execute, then can forget about completely.
	amp - an amplitude scaler for everything running in the ProcEvents instance.
	initmod - a ProcMod to be evaluated when the first event is called, regardless of event number. Useful for
		allocating buffers or persistant synths.
	killmod - a ProcMod to be evaluated when this instance of ProcEvents is killed. Useful for freeing buffers
		and killing persistant synths.
	id - a \symbol or "string" to identify this instance of ProcEvents
	server - an instance of Server to run this ProcMod on. Useful for remote servers. 
		Defaults to Server.default.	

Instance methods

play( eventindex ) - plays and releases the events at index in the events array. If initmod has not been 
	executed, it will be.

next - will play and release the next event is the events array. Starts at 0. If initmod has not been executed, it
	will be.
	
releaseAll - releases all running ProcMods EXCEPT the initmod.

reset - releases all running ProcMods and resets the system to evaluate initmod again.

killAll - kill this instance of ProcEvents. Frees everything.

starttime( id ) - returns the starttime of the ProcMod with 'id' in relation to the starttime of ProcEvents' first event. 
	d should be a \symbol or "string". If 'id' is nil, the time of the first event of this instance of ProcEvents
	(according to Main.elapsedTime) is returned.
	
now( id ) - returns the current time in reference to the starttime of 'id'. 'id' should be a \symbol or "string". If 'id' is 
	nil, the reference will be the ProcEvents starttime itself.
	
perfGUI - creates a GUI with basic ProcEvents controls to perform an instance of ProcEvents. 

pracGUI - creates a GUI with basic ProcMod controls and a perfGUI for rehearsal purposes.
	
pedalTrig( pedalbus, headroom, trigwindow, testdur ) - listens to pedalbus for Amplitude triggers. This is 
	fairly specialized. I use a quater inch keyboard sustain pedal (a ground switch). When pedalTrig is 
	invoked, an OSCresponderNode is started that listens for a noise floor for testdur seconds. An average 
	reading is taken and is stored as a basevalue. When the pedal is pressed, a spike in amplitude is created. 
	If the spike is within basevalue * headroom, the next event is called. Some tuning should be done to find
	a headroom value that will work reliably. Triggers are limited to one trigger in every trigwindow seconds.
	The server MUST be booted before .pedalTrig is called.

TO DO: create a way to store values from the pracGUI to be re-used for later performances.

Examples:

SynthDef(\singrain, {arg freq, amp, dur, procbus, outbus = 0;
	Out.ar(outbus, 
		Pan2.ar(
			SinOsc.ar(freq, 0, amp) * 
				EnvGen.kr(Env.sine(dur, amp), doneAction: 2) *
				In.kr(procbus), // read off the overall env control of the ProcMod
			Rand(-1.0, 1.0)
		)
	) 
}).load(s);

(
// create a ProcMod... feed the function in at init time
a = ProcMod.new(Env([0, 1, 0], [1, 1], \sin, 1), 0.02,
		function: {arg group, envbus, server;
			Task({
				inf.do({
					s.sendMsg(\s_new, \singrain, s.nextNodeID, 0, group,
						\freq, 440.rrand(880), \amp, 1, \dur, 0.2, 
						\procbus, envbus);
					0.05.wait;
					})
				});
			}
		);

// create a ProcMod... set the function after init time
b = ProcMod.new(Env([0, 1, 0], [1, 1], \sin, 1), 0.02)
	.function_({arg group, envbus;
		Task({
			inf.do({
				s.sendMsg(\s_new, \singrain, s.nextNodeID, 0, group,
					\freq, 4400.rrand(8800), \amp, 1, \dur, 0.2, 
					\procbus, envbus);
				0.05.wait;
				})
			});
		});			

// create the ProcEvents to run the above ProcMods				
e = ProcEvents.new(
	// an array of event / release arrays
	[
		// run 'a'
/* 0 */		[a, nil],
		// run 'b'
/* 1 */		[b, nil],
		// kill ev1 and ev2
/* 2 */		[nil, [a, b]]
	], 1);

)

// open a GUI to perform the above events
e.perfGUI;

// a more complex example, using function to create ProcMods, and feeding the 
// evaluated form of those functions into ProcEvents.
(
a = {arg id, amp, env, high, low, winsize, overlaps;
	var proc;
	proc = ProcMod.new(env, amp, id: id);
	proc.function_({arg group, envbus, server;
		Task({
			inf.do({
				// start a new synth... run it inside this ProcMod's group,
				// and read control values off the envbus
				server.sendMsg(\s_new, \singrain, server.nextNodeID, 0, group,
					\freq, high.rrand(low), \amp, 1, \dur, winsize, 
					\procbus, envbus);
				(winsize / overlaps).wait;
				})
			});
		});
	};

e = ProcEvents.new([
/* 0 */		[a.value(\ev1, 0.1, Env([0, 1, 0], [2, 10], \sin, 1), 440, 880, 0.3, 8),
			nil], // create \ev1, release nothing
/* 1 */		[a.value(\ev2, 0.1, Env([0, 1, 0], [1, 10], \sin, 1), 2200, 4400, 0.2, 8),
			nil],
/* 2 */		[a.value(\ev3, 0.1, Env([0, 1, 0.5, 2, 0], [1, 1, 1, 1], \sin, 1), 100,
				10000, 1, 4),
			[\ev1, \ev2]], // release ev1 and ev2
/* 3 */		[nil, \ev3]
			], 0.dbamp, id: "test");
			
)

e.perfGUI;

/* A simple example showing the pedalTrig function. The headroom value is high so you
can see how it works with an internval mic ... snap your fingers and the GUI should advance */

(
s=Server.internal.boot;
s.waitForBoot({
	a = ProcEvents.new([
		[{"event1".postln}, nil],
		[{"event2".postln}, nil],
		[{"event3".postln}, nil],
		[{"event4".postln}, nil],
		[{"event5".postln}, nil],
		[{"event6".postln}, nil],
		[{"event7".postln}, nil],
		[{"event8".postln}, nil],
		[{"event9".postln}, nil]
		], 1, nil, nil, "test", s);
		
	// .pedalTrig(pedalbus, testdur)

	a.pedalTrig(s.options.numOutputBusChannels, 1.0);
	
	a.perfGUI;
	})
)

s.scope


