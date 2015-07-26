
SCFreqScope			frequency analysis view


SCFreqScope.new(parent, bounds)


SCFreqScope shows the frequency spectrum of a specified audio bus.  The scope will
remain active after a command-period.  To turn it off you must use the 'active' method.

Public methods:


kill()
Very important.  This must be run when the parent window is closed to avoid problems.
It also frees the buffers that the scope allocated and stops the FFT analysis synth.

active_(Boolean)
Turns the scope on if true or off if false.  When the scope is turned on for the first time,
it will send SynthDefs to the internal server, allocate the FFT and scope buffers, and
start the FFT analysis synth.  After that, only the FFT synth will be turned on and off.

dbRange_(Integer)
Determines the amplitude range.  This sets the lowest negative decibel reading.

freqMode_(Integer)
Can be either 0 or 1.  0 displays frequencies on a linear scale and 1 displays frequencies
on a logarithmic or equally spaced octave scale.

inBus_(Integer)
Change the bus number to analyze.



// Start internal server
s = Server.internal.boot;

// Create analyzer in a window
(
w = SCWindow("My Analyzer", Rect(0, 0, 511, 300)); // width should be 511
f = SCFreqScope(w, w.view.bounds);
f.active_(true); 	// turn it on the first time;

w.onClose_({ f.kill });  // you must have this
w.front;
)

{ SinOsc.ar([500, 1000], 0, 0.25) }.play(s);  // start two sine waves

f.freqMode_(1);		// change to log scale so we can see them
f.inBus_(1);			// look at bus 1
f.dbRange_(200);		// expand amplitude range
f.active_(false);		// turn scope off (watch CPU)
f.active_(true);		// turn it back on				


Now press command-period.  The scope is still running.


{ SinOsc.ar([500, 1000], 0, 0.25) }.play(s);  // start sines again

Close window and scope is killed.
