
FMHDecode1			decode an FMH signal for a specific speaker

FMHDecode1.ar(w, x, y, z, r, s, t, u, v, azimuth, elevation, mul, add )

w, x, y, z, r, s, t, u , v - the components of a second order ambisonic signal
azimuth - Speaker angle in radians. 0 is front, values should be anti-clockwise (-0.5pi is right, 0.5pi is left)
elevation - Speaker elevation in radians. 0 to 0.5pi is up, 0 to -0.5pi is down.

WARNINGS - Second-order encoding and decoding has some quirks. Decoding for arbitrary arrays will probably not result in the cleanest results. Often, components need to be discarded depending on the kind of speaker array. See: http://www.muse.demon.co.uk/ref/speakers.html for more information. Some of the more common speaker rigs are pre-done for you according to the specifications from Richard Furse's site. 

In addition, after a number of conversations with Miguel Negrao (and his contacts with Fons Adriaensen), it is fairly clear that for Second Order decoding to really work well, filtering should be done on the output... for a later date! 

(
{
	var w, x, y, z, r, s, t, u, v, p, a, b, c, d;
	
	p = PinkNoise.ar;
	
	// second order B-format encode
	#w, x, y, z, r, s, t, u, v = FMHEncode1.ar(p, MouseX.kr(-pi, pi), 
		MouseY.kr(0.25pi, -0.25pi), 1); 
	
	// B-format decode to cube / quad ([lfh, rfh, rrh, lrh, lfl, rfl, rrl, lrl])
	// lfl = left front high, lfl = left front low etc...
	
	FMHDecode1.ar(w, x, y, z, r, s, t, u, v,
		[-0.25pi, 0.25pi, 0.75pi, 1.25pi,-0.25pi, 0.25pi, 0.75pi, 1.25pi], 
		[0.25pi,0.25pi,0.25pi,0.25pi,-0.25pi,-0.25pi,-0.25pi,-0.25pi]);
}.scope(8);
)

ar1(w, x, y, z, r, s, t, u, v, azimuth, elevation, maxDist, distance, scaleflag, mul, add)

maxDist - the distance (in meters) to the furthest speaker from center (this allocates the delay size)
distance - the distance (in meteres) to each speaker.
scaleflag - if 1, apply amplitude scaling to the closest signals to match more distant speakers

The following are some common speaker rigs, with the appropriate components zeroed out

stereo(w, y, mul, add)

square(w, x, y, v, mul, add) - stereo pairs - lf, rf, lr, rr
quad(w, x, y, v, mul, add) - clockwise - lf, rf, rr, lr
pentagon(w, x, y, u, v, mul, add) - center front, rf, rr, lr, lf
hexagon(w, x, y, u, v, mul, add) - lf, rf, r, rr, lr, l
ocatogon1(w, x, y, u, v, mul, add) - lf, rf, rfs, rrs, rr, lr, lrs, lfs
ocatogon1(w, x, y, u, v, mul, add) - f, rf, r, rr, rear, lr, l, lf
cube(w, x, y, z, s, t, v, mul, add) - lfu, rfu, rru, lru, lfd, rfd, rrd, lrd
doubleHex(w, x, y, z, s, t, u, v, mul, add) - lfu, rfu, ru, rru, lru, lu, lfd, rfd, rd, rrd, lrd, ld
dodecahedron(w, x, y, z, r, s, t, u, v, mul, add) - top, fu, rfu, rru, lru, lfu, fd, rfd, rrd, lrd, lfd, bottom



s=Server.internal.boot;

(
{ 
	var w, x, y, z, r, s, t, u, v;
	#w, x, y, z, r, s, t, u, v = 
		FMHEncode1.ar(WhiteNoise.ar,MouseX.kr(0, 2pi), MouseY.kr(-0.5pi, 0.5pi), 1, 0.3);
	FMHDecode1.stereo(w, y);
}.scope(5));

(
{ 
	var w, x, y, z, r, s, t, u, v;
	#w, x, y, z, r, s, t, u, v = 
		FMHEncode1.ar(SinOsc.ar,MouseX.kr(0, 2pi), MouseY.kr(-0.5pi, 0.5pi), 1, 0.3);
	FMHDecode1.pentagon(w, x, y, u, v);
}.scope(5));

(
{ 
	var w, x, y, z, r, s, t, u, v;
	#w, x, y, z, r, s, t, u, v = 
		FMHEncode1.ar(WhiteNoise.ar,MouseX.kr(0, 2pi), MouseY.kr(-0.5pi, 0.5pi), 1, 0.3);
	FMHDecode1.cube(w, x, y, z, s, t, v);
}.scope(8));


(
{ 
	var w, x, y, z, r, s, t, u, v;
	#w, x, y, z, r, s, t, u, v = 
		FMHEncode1.ar(SinOsc.ar,MouseX.kr(0, 2pi), MouseY.kr(-0.5pi, 0.5pi), 1, 0.3);
	FMHDecode1.doubleHex(w, x, y, z, s, t, u, v);
}.scope(12));

(
{ 
	var w, x, y, z, r, s, t, u, v;
	#w, x, y, z, r, s, t, u, v = 
		FMHEncode1.ar(WhiteNoise.ar,MouseX.kr(0, 2pi), MouseY.kr(-0.5pi, 0.5pi), 1, 0.3);
	FMHDecode1.dodecahedron(w, x, y, z, r, s, t, u, v);
}.scope(12));



