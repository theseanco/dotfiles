
NPVoicer				handle polyphony with nodeproxies

first example:

s.boot;
s.latency = nil;			// for faster response;

g = NPVoicer(Ndef(\vox)); 	// make an NPVoicer with an Ndef in it
g.prime(\default);			// prepare it with the default synthdef

g.play;					// play it

	// start a sound with key 48, with its won set of params
g.put(48, [\freq, 48.midicps]);

	// a second note at 51
g.put(51, [\freq, 51.midicps]);

	// release them
g.release(48);
g.release(51);

Methods

	*new (proxy, setParams)
	
		proxy - a nodeproxy, typically an Ndef, or a ~proxy, if you use ProxySpace.
		setParams - the parameters to set independently for each node/voice on the proxy.
		
		g = NPVoicer(Ndef(\a), [\freq, \amp]);
	

	prime (obj)	prepare proxy for playing voices. 
	
		obj - can be anything a nodeproxy accepts: 
			a SynthDef name (a Symbol), a function, ...
		
			// init with Event's default SynthDef, 
			// as made in Event.makeDefaultSynthDef;
		g.prime(\default);
					
	synCtl 	a SynthDefControl that is made when priming, and used for the voices. 
		
		g.synCtl.dump;


	put (index, args)	start a voice at some index

		index - some key to identify the running voice. e.g. a MIDInote key, or a button number.
		args - the arguments to be set individually for this voice. 
			(usually, these are the ones in setParams.)
		
		g.play;
		g.put(48, [\freq, 48.midicps, \amp, 0.2, \pan, -0.5]);
		g.put(51, [\freq, 51.midicps, \amp, 0.1, \pan, 0.5]);


	release (key, fadeTime)	release the voice at key, optionally with a fadetime.
	
		key -  the key at which to find the voice to release.
		fadeTime - a release fadetime. works if the synthdef/object supports it.
		
		g.release(48);
		g.release(51, 3);	// default has no fadetime, so not working
		
(
		g.prime({ |freq = (60.midicps), amp = 0.1, pan|
			Pan2.ar( Ringz.ar(Dust.ar(10) + GrayNoise.ar(0.03), freq, 0.1), pan, amp)
		});
)
			// fadeTime gets built automatically in proxy, so separate fadetime 
			// works here: 
		g.put(72, [\freq, 72.midicps, \amp, 0.2, \pan, -0.5, \fadeTime, 0.5]);
		g.release(72, 3);	// key, fadeTime
	


	playingKeys	the keys that currently play voices
		
		g.put(60, [\freq, 48.midicps, \amp, 0.2, \pan, -0.5]);
		g.put(67, [\freq, 51.midicps, \amp, 0.1, \pan, 0.5]);
		g.playingKeys;

	releaseAll (fadeTime)	release all voices. 
		fadeTime - fadetime for the release
		
		g.releaseAll(0.0);

		g.put(60, [\freq, 60.midicps, \amp, 0.2, \pan, -0.5, \fadeTime, 1]);
		g.put(67, [\freq, 67.midicps, \amp, 0.1, \pan, 0.5, \fadeTime, 5]);

		g.releaseAll(3);


	spawn (args)		play voices that end by themselves (doneAction: 2) 
					i.e. NPVoicer need not keep track of these voices.

		args - the arguments to be set individually for this voice. 
		
		p = ProxySpace.push; 
		~x.play;
		g = NPVoicer(~x); 
		g.play;
		g.prime({ |freq = 400| SinOsc.ar(freq) * XLine.ar(0.2, 0.0002, 0.4, doneAction:2) }, true);
		g.proxy.spawn([\freq, 72.midicps]); 
		g.proxy.spawn([\freq, 96.midicps]); 

			// not working now, because spawning
		g.put(72, [\freq, 72.midicps, \amp, 0.1, \pan, 0.5]); // works
		
			// spawn
		g.spawn([\freq, 72.midicps]); 
		g.spawn([\freq, 96.midicps]); 



	Interface to the proxy - see NodeProxy for details

	play (out, numChannels, group, multi, vol, fadeTime, addAction)

	playN (outs, amps, ins, vol, fadeTime, group, addAction)

	stop (fadeTime, reset)

	end (fadeTime, reset)

	pause

	resume

Examples


	// trigger percussion-style notes from computer keyboard while above window. 
	// could also be done without NPVoicer, but it is convenient with NPVoicer.
(
s.latency = nil;
g = NPVoicer(Ndef(\x));
g.prime({ |freq = 400| SinOsc.ar(freq) * EnvGen.ar(Env.perc(0.001, 0.03, 0.4), doneAction:2) }, true);
g.play;

w = Window("ascii player - clickies").front; 
w.view.keyDownAction = { |view, char| 
	g.spawn([\freq, char.ascii.midicps])
};
)

	// play, hold, and release notes from computer keyboard
(
s.latency = nil;
g = NPVoicer(Ndef(\x), [\freq, \amp, \pan]);
g.prime(\default, false);
g.play;

w = Window("ascii player2 - it IS a keyboard after all...").front; 
w.view.keyDownAction = { |view, char| 
	var key = char.ascii; 
		// no retriggering
	if (g.playingKeys.includes(key).not) { 
		g.put(key, [\freq, key.midicps])
	};
};
w.view.keyUpAction = { |view, char| 
	var key = char.ascii; 
	if (g.playingKeys.includes(key)) { g.release(key) };
};
)

	// ToDo 
// An example with KeyPlayer

// An example with MultiTouchPad

// An example with NanoKey - MIDI, play and hold notes 

// An example with NanoPad - MIDI, trigger perc notes only

// Manta, ... others ... ? 



