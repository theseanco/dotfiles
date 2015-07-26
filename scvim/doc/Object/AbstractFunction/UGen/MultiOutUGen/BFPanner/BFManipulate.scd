
BFManipulate			BFormat sound manipulation

BFManipulate.ar(w, x, y, z, rotate, tilt, tumble)

Manipulates the entire soundfiled of a BFormat signal around an the x-, y-, or z-axis.
w, x, y, z - the B-format signals. 
rotate - rotate the soundfiled around the z-axis (left to right) in radians.
tilt - rotate about the x- axis (clock-wise and counter-clock-wise) in radians
tumble - rotate about the y axis (up and down) in radians

s=Server.internal.boot;
(
{
	var w, x, y, z, p, a, b, c, d;
	
	p = Resonz.ar(PinkNoise.ar(100), 440, 0.01) *
		LFSaw.kr(2, pi, -0.2, 0.2); // source
	q = Resonz.ar(PinkNoise.ar(100), 330, 0.01)  * 
		LFSaw.kr(2, pi, -0.2, 0.2); // source

	// B-format encode
	#w, x, y, z = BFEncode1.ar(p, -0.25pi, 1) + 
		BFEncode1.ar(DelayC.ar(q, 0.2, 0.2), 0.25pi, 1);
	
	#a, b, c, d = BFManipulate.ar(w, x, y, z, 
		MouseX.kr(-pi, pi), 0, MouseY.kr(-pi, pi));
	// B-format decode to cube / quad
	BFDecode1.ar(a, b, c, d, 
		[-0.25pi, 0.25pi, 0.75pi, 1.25pi,-0.25pi, 0.25pi, 0.75pi, 1.25pi], 
		[0.25pi,0.25pi,0.25pi,0.25pi,-0.25pi,-0.25pi,-0.25pi,-0.25pi,]);	
}.scope(8);
)


