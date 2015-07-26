
BFEncodeSter			Ambisonic B format encoder for stereo signals

BFEncodeSter.ar(l, r, azimuth, width elevation, rho, gain, wComp)

l - left side of the input signal
r - right side of the input signal
azimuth -  in radians, -pi to pi
width - in radians, width of stereo image
elevation -  in radians, -0.5pi to +0.5pi
rho - the speaker radius (1 places shound at the radius, <1 within the radius, >1 is outside the radius)
	beyond the radius, a distance scaling is applied (no filtering is done).
gain - a control rate level input.
wComp - chooses how the W channels is scaled. If 0, a scaler of 0.707 is used. If 1, W is varied according to the scaling of the X, Y and Z channels. 1 is the default.

Output channels are in order W,X,Y,Z.
Because of the way the W component is scaled, it is recommended that you only decode with BFDecode1 and it's methods.

s=Server.internal.boot;
s.scope;
// You'll only hear the first two channels on a stereo setup.

SynthDef(\testster, {
	var w, x, y, z;
	#w, x, y, z = BFEncodeSter.ar(
		PinkNoise.ar(Decay.ar(Impulse.ar(2, 0, 0.25))),
		SinOsc.ar(440, 0, Decay.ar(Impulse.ar(2, 0.5, 0.25))),
		MouseY.kr(0, pi), // center position of image
		MouseX.kr(0, pi) // width
		);
	Out.ar(0, B2Ster.ar(w, x, y))
	}).load(s);
	
s.sendMsg(\s_new, \testster, a=s.nextNodeID, 0, 1);
 
s.sendMsg(\n_free, a);


