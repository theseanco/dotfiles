
FMHEncode1			Second Order Ambisonic encoder

FMHEncode1.ar(in, azimuth, elevation, rho, gain, wComp)

in - input signal
azimuth -  in radians, -pi to pi
elevation -  in radians, -0.5pi to +0.5pi
rho - the speaker radius (1 places shound at the radius, <1 within the radius, >1 is outside the radius)
	beyond the radius, a distance scaling is applied (no filtering is done).
gain - a control rate level input.
wComp - chooses how the W channels is scaled. If 0, a scaler of 0.707 is used. If 1, W is varied according to the scaling of the X, Y, Z, R, S, T, U, and V channels. 1 is the default.

Output channels are in order W,X,Y,Z, R, S, T, U, V.
Because of the way the W component is scaled, it is recommended that you only decode with FMHDecode1 and it's methods.

s=Server.internal.boot;

(
{ 
	var w, x, y, z, r, s, t, u, v;
	#w, x, y, z, r, s, t, u, v = 
		FMHEncode1.ar(WhiteNoise.ar.dup,MouseX.kr(0, 2pi), MouseY.kr(-0.5pi, 0.5pi) + [0, 0.5pi], 1, 0.3).sum;
	FMHDecode1.cube(w, x, y, z, s, t, v);
}.scope(8));


