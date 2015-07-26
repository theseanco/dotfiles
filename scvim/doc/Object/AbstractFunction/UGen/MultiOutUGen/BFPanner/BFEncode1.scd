
BFEncode1			Ambisonic B format encoder

BFEncode1.ar(in, azimuth, elevation, rho, gain, wComp)

in - input signal
azimuth -  in radians, -pi to pi
elevation -  in radians, -0.5pi to +0.5pi
rho - the speaker radius (1 places shound at the radius, <1 within the radius, >1 is outside the radius)
	beyond the radius, a distance scaling is applied (no filtering is done).
gain - a control rate level input.
wComp - chooses how the W channels is scaled. If 0, a scaler of 0.707 is used. If 1, W is varied according to the scaling of the X, Y and Z channels. 0 is the default.

Output channels are in order W,X,Y,Z.

s=Server.internal.boot;
// You'll only hear the first two channels on a stereo setup.
(
{ 
	#w, x, y, z = BFEncode1.ar(WhiteNoise.ar,MouseX.kr(0, 2pi), 0, MouseY.kr(0.0, 4.0), 0.3);
	//decode for 4 channels
	BFDecode1.ar(w, x, y, z, [-0.25pi, 0.25pi, 0.75pi, 1.25pi], 0);
}.scope(4));


