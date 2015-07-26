
OnsetsDS    Onset detector

	OnsetsDS.kr(in, fftbuf, trackbuf, thresh=0.5, type=\power)

An onset detector for musical audio signals - i.e. detects the beginning of notes/drumbeats/etc. Outputs a control-rate trigger signal which is 1 when an onset is detected, and 0 otherwise.

The onset detection should work well for a general range of monophonic and polyphonic audio signals, but is not targeted at sounds like solo voice, flute, or choir, which have their own specific qualities and tend to be difficult for general-purpose onset detectors. The onset detection is purely based on signal analysis and does not make use of any "top-down" inferences such as tempo.

The input to the onset detector should be single-channel. As with most UGens, it will automatically be expanded out to cater for multiple channels, but they'll be completely separate detectors. Typically you'll only want a single output even for stereo input, so remember to mix down signals before feeding them in, if needed.


Example

(
s.boot.doWhenBooted({
// Prepare the buffers
b = Buffer.alloc(s, 512);
c = Buffer.alloc(s, 512);
d = Buffer.read(s, "sounds/a11wlk01.wav"); //  Feel free to load a more interesting clip!
});
)

(
x = {
	var sig, onsets, pips;
	sig = PlayBuf.ar(1, d.bufnum, BufRateScale.kr(d.bufnum), loop: 1);
	
	// OnsetsDS - move the mouse left/right to change the threshold:
	onsets = OnsetsDS.kr(sig, b.bufnum, c.bufnum, MouseX.kr(0,1), \complex);
	
	pips = SinOsc.ar(880, 0, EnvGen.kr(Env.perc(0.001, 0.1, 0.2), onsets));
	Out.ar(0, ((sig * 0.1) + pips).dup);
}.play;
)

x.free; // Free the synth
[b,c,d].do(_.free); // Free the buffers


The thresh value is a detection threshold, typical values for which are expected to range between 0 and 1, although values outside that range are allowed and may in rare cases be more appropriate for you. The default of 0.5 should give a generally decent balance.

The onset detector requires two buffers of the same size (fftbuf and trackbuf) to be passed in. It uses them internally for its FFT-based processing. Recommended size for these buffers is 512, although you may like to try other sizes (you may need to fiddle with the threshold settings etc).

The type argument chooses which onset detection function is used. The following choices are available:

 * \power    - the default, this is generally good and also very efficient
 * \complex  - performs very well indeed, but less efficient
 * \rcomplex - almost as good as \complex, and slightly more efficient
 * \wphase   - generally very good, medium efficiency
 * \mkl      - generally very good, medium efficiency

Which of these should you choose? The differences aren't large, so I'd recommend you stick with the default unless you find specific problems with it. Then try the \rcomplex if you want to use more CPU for a slightly better performance. The \mkl type is a bit different from the others so maybe try that too. They all have slightly different characteristics though, and in my tests perform at a very similar quality level.

Note: the type argument is treated specially, and only evaluated at the moment the SynthDef is compiled. You can't change the value after that (not even on Synth instantiation).

For more details of all the processes involved, the different onset detection functions, and their evaluation, see

	Stowell, D. and Plumbley, M. (2007) Adaptive whitening for improved real-time onset detection. To appear in Proceedings of the 2007 International Computer Music Conference.

Note: OnsetsDS is a "pseudo-UGen" built on top of other UGen's in Dan's MCLD UGen library, so it should not be installed "alone" on a system - it won't work without the rest of the library!


-----------

ADVANCED FEATURES

Further options are available, which you are welcome to fiddle with if you want.

Perhaps the most significant is extchain - if you set this to true then the onset detector expects "in" to be an FFT chain, not an audio-rate signal. This means that if you're already performing FFT on the signal you can feed the FFT chain into the onset detector, rather than having it perform a separate FFT.

The other parameters are numbers that modulate the behaviour of the onset detector:

 * relaxtime, floor and smear are parameters to the PV_Whiten UGen which is used internally. See [PV_Whiten] for details. (Note: in \mkl mode these are not used.) In particular, you may wish to push the default floor parameter down from its default of 0.1. For some classical music with wide dynamic variations, I found it helpful to go down as far as 0.000001.
 * mingap specifies a minimum gap (in seconds) between onset detections, to prevent too many doubled detections.
 * medianspan specifies the size (in FFT frames) of the median window used for smoothing the detection function before triggering.



