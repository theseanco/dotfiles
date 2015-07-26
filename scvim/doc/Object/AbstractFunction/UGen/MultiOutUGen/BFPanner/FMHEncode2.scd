
FMHEncode2			Second Order Ambisonic encoder

FMHEncode2.ar(in, point_x, point_y, elevation, gain, wComp)

in - input signal
point_x - a point in the x axis
point_y - a point in the y axis
elevation -  in radians, -0.5pi to +0.5pi
gain - a control rate level input.
wComp - chooses how the W channels is scaled. If 0, a scaler of 0.707 is used. If 1, W is varied according to the scaling of the X, Y, Z, R, S, T, U, and V channels. 1 is the default.


x, y positions-
	0 -1 behind
	0 1 in front 
	-1 0 right
	1 0 left

Output channels are in order W,X,Y,Z, R, S, T, U, V.
Because of the way the W component is scaled, it is recommended that you only decode with FMHDecode1 and it's methods.

s=Server.internal.boot;
// You'll only hear the first two channels on a stereo setup.
(
{ 
	var w, x, y, z, r, s, t, u, v;
	#w, x, y, z, r, s, t, u, v = FMHEncode2.ar(WhiteNoise.ar,MouseX.kr(-1, 1), 
		MouseY.kr(-1.0, 1.0), 0);
}.scope(9));


