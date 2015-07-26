
BFEncode2			Ambisonic B format encoder

BFEncode2.ar(in, point_x, point_y, elevation, gain)

in - input signal
point_x - a point in the x axis
point_y - a point in the y axis
elevation -  in radians, -0.5pi to +0.5pi
gain - a control rate level input.
wComp - chooses how the W channels is scaled. If 0, a scaler of 0.707 is used. If 1, W is varied according to the scaling of the X, Y and Z channels. 1 is the default.


x, y positions-
	0 -1 behind
	0 1 in front 
	-1 0 right
	1 0 left


Output channels are in order W,X,Y,Z.
Because of the way the W component is scaled, it is recommended that you only decode with BFDecode1 and it's methods.

s=Server.local.boot;
// You'll only hear the first two channels on a stereo setup.
({ 
	#w, x, y, z = BFEncode2.ar(WhiteNoise.ar, MouseX.kr(-20, 20), MouseY.kr(20, -20), 0, 0.3);
	//decode for 4 channels
	BFDecode1.ar(w, x, y, z, [-0.25pi, 0.25pi, 0.75pi, 1.25pi], 0);
}.scope(4));


