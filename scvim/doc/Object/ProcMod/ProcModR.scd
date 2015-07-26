
ProcModR		A extension to the ProcMod real-time control structure!

ProcModR - A structure for controlling modular processes, with the capabilitiy to record its output
	in real-time

Class Methods

*new(env, amp, numChannels, procout, id, group, addAction, target, function, releaseFunc, 
	onReleaseFunc, responder, timeScale, lag, clock, server)

	env - an overall amplitude envelope that synths created and sent to the ProcModRs internal routing bus 		will be shaped by. There is a max of 20 breakpoints to the env. If the Env has a releaseNode,
		ProcModR will continue to process events until .release is called.
	amp - an overall amplitude control for an instance of ProcMod.
	numChannels - the number of channels of output events in this function will contain.
	procout - where the sound from this ProcModR should be routed to. 
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

SynthDef(\singrain, {arg outbus, freq, amp, dur;
	OffsetOut.ar(outbus, 
		Pan2.ar(
			SinOsc.ar(freq, 0, amp) * 
				EnvGen.kr(Env.sine(dur, amp), doneAction: 2),
			Rand.new(-1.0, 1.0)
		)
	) // read off the overall env control of the ProcMod
}).load(s);
	
// create a new ProcModR, and assign a function to it
a = ProcModR.new(Env([0, 1, 0], [1, 1], \sin, 1), 1, 2, 0, server: s);
a.function_({arg group, routebus, server;
	Task({
		inf.do({
			// start a new synth... run it inside this ProcMod's group,
			// and read control values off the envbus
			server.sendMsg(\s_new, \singrain, server.nextNodeID, 0, group,
				\freq, 440.rrand(1760), \amp, 0.1, \dur, 5, \outbus, routebus);
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
	proc = ProcModR.new(env, amp, 2, 0);
	proc.function_({arg group, routebus, server;
		Task({
			inf.do({
				// start a new synth... run it inside this ProcMod's group,
				// and read control values off the envbus
				server.sendMsg(\s_new, \singrain, server.nextNodeID, 0, group,
					\freq, high.rrand(low), \amp, 1, \dur, winsize, 
					\outbus, routebus);
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

Re-triggerable ProcModRs

ProcModRs are meant for the most part, to be played and released. However, if the function slot is passed a Function object, they can be re-triggered after they have been released. If the Function returns a Task or Routine, the ProcMod will function as though a Task or Routine were placed in the function slot (it will be started and released in the same way). Re-triggered events will be assigned a new group and envbus, so these are made available to the Function through arguments. If an OSCresponderNode or releaseFunc are needed for each re-triggered event, they should be assigned inside the Function:

SynthDef(\trig, {arg id, val;
	SendTrig.kr(Impulse.kr(10), id, val);
	}).load(s);
	
SynthDef(\singrain, {arg freq, amp, dur, outbus;
	OffsetOut.ar(outbus, 
		Pan2.ar(
			SinOsc.ar(freq, 0, amp) * 
				EnvGen.kr(Env.sine(dur, amp), doneAction: 2),
			-1.0.rrand(1.0)
		)
	) // read off the overall env control of the ProcMod
}).load(s);

i = 0;
s.boot;
a = ProcModR.new(Env([0, 1, 0], [1, 3], \sin, 1), 1, 2, 0, server: s);
// use a function. This one returns the Task. group and envbus are passed in as args
a.function_({arg group, routebus, server;
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
				\outbus, routebus);
			0.05.wait;
			});
		});
	});

a.play; // play the ProcModR
// release the current event, and start a new one immediately. These will overlap.
a.release; a.play; // watch the posted values from the OSCresponderNode
a.release;


Recording the output of ProcModRs

ProcModRs can record their output (anything that is sent to its private routebus) out to a file with the recordPM method. You just supply a basepath, and other timestamp info is added to it:

a = {arg amp, env, high, low, winsize, overlaps, path;
	var proc;
	// defaults to Server.default if no Server is supplied
	proc = ProcModR.new(env, amp, 2, 0);
	proc.recordPM(path);
	proc.function_({arg group, routebus, server;
		Task({
			inf.do({
				// start a new synth... run it inside this ProcMod's group,
				// and read control values off the envbus
				server.sendMsg(\s_new, \singrain, server.nextNodeID, 0, group,
					\freq, high.rrand(low), \amp, 1, \dur, winsize, 
					\outbus, routebus);
				(winsize / overlaps).wait;
				})
			});
		});
	};

// create new instances of ProcMod... store it to the variables 'b' and 'c'
b = a.value(0.2, Env([0, 1, 0], [1, 1], \sin, 1), 2000, 1000, 0.1, 4, 
	"~/Desktop/test1".standardizePath); // a base path, other time stamp info is added
c = a.value(0.3, Env([0, 1, 0], [10, 0.1], [5, -10], 1), 440, 880, 0.4, 2,
	"~/Desktop/test2".standardizePath);

b.play; c.play;

b.release; 
c.release;

ProcModR and ProcEvents

ProcModRs is interchangable with ProcMod. The main difference is you can give the .record method to ProcEvents, with a path, and it will use that base path to record every ProcModR out to it's own, timestamped file.


(
a = {arg id, amp, env, high, low, winsize, overlaps;
	var proc;
	proc = ProcModR.new(env, amp, 2, 0, id: id);
	proc.function_({arg group, routebus, server;
		Task({
			inf.do({
				// start a new synth... run it inside this ProcMod's group,
				// and read control values off the envbus
				server.sendMsg(\s_new, \singrain, server.nextNodeID, 0, group,
					\freq, high.rrand(low), \amp, 1, \dur, winsize, 
					\outbus, routebus);
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
			
e.record("~/Desktop/test".standardizePath, true, 'aiff', 'float');
)

e.perfGUI;


