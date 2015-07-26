
FFTPhaseDev - Measure phase deviation of signal

	FFTPhaseDev.kr(chain, weight=0, powthresh=0.1)

Calculates the phase deviation of the signal, which is a measure of the total rate of change of  the phase of the spectral components, across all the FFT bins. A stationary signal (such as a steady sine wave) should exhibit zero phase deviation, whereas a non-stationary signal (such as a sine wave of modulating frequency, or more complex changing sound) should exhibit a positive phase deviation.

This measure can be used as a component in onset detection - see [OnsetsDS] - but may also have other applications.

The comparison is frame-by-frame, so its behaviour will depend to some extent upon your frame size.

The optional second argument weight specifies (at creation time - cannot be modulated) whether the phase deviations should be weighted by the instantaneous magnitude of each bin. Set it greater than zero to activate the weighting feature (it's either on or off; no shades of gray).

The other optional argument powthresh tells the UGen to ignore FFT bins where the power is lower than a threshold. (This option can be modulated at control rate.) This is most useful when the "weighted" option is NOT used. You're free to combine the options in any way you want though.

For more details about both algorithms (weighted and unweighted) see 

	Dixon, S. (2006) Onset Detection Revisited. In Proceedings of the 9th International Conference on Digital Audio Effects (DAFx-06), Montreal, Canada. pp. 133-137.


Examples

These examples use the standard unweighted measure, with a fixed powthresh value. Feel free to dabble with the parameters.

s.boot;
b = Buffer.alloc(s, 512, 1);

// Move the mouse to vary the frequency, and the amount of noise added.
// Watch the scope/post window to see the change in phase deviation.
(
x = {
var in, chain, flux;
in = SinOsc.ar(MouseX.kr(50, 500, 1), 0, 0.1) + WhiteNoise.ar(MouseY.kr(0, 0.1));
chain = FFT(b.bufnum, in);
flux = FFTPhaseDev.kr(chain);
flux.poll(10, "Phase deviation");
Out.ar(0, in.dup);
Out.kr(0, flux);
}.play(s);
)

x.free;b.free;


// Load an audio file and plot the phase deviation as a function of time
b = Buffer.alloc(s, 512, 1);
c = Buffer.read(s, "sounds/a11wlk01.wav");
(
x = {
var in, chain, phasedev;
in = PlayBuf.ar(1, c.bufnum, BufRateScale.kr(c.bufnum));
chain = FFT(b.bufnum, in);
phasedev = FFTPhaseDev.kr(chain, 0, 10) * 0.1;
phasedev.poll(10, "Phase deviation");
Out.ar(0, in.dup * 0.1);
K2A.ar(phasedev)
}.plot(c.numFrames/c.sampleRate, s);
)

x.free; b.free; c.free;


