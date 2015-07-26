
BFDecode1			3D Ambisonic decoder

BFDecode1.ar(w, x, y, z, azimuth, elevation, wComp)

Decode a two dimensional ambisonic B-format signal for any speaker arrangement
w, x, y, z - the B-format signals. All of these MUST be audio rate signals. If you want to zero one out, use
	K2A.ar(0).
azimuth - the angle from 0pi front and center of the speaker.  Can be an array of angles.
elevation - the angle from 0pi center of the speaker.  Can be an array of angles.
wComp - chooses how the W channels is scaled. If 0, a scaler of 0.707 is used. If 1, W is varied according to the scaling of the X, Y and Z channels. 1 is the default.


Because of the way the W component is scaled, it is recommended that you only decode with BFEncode signals with BFDecode1 and it's methods.

s=Server.internal.boot;
(
{
	var w, x, y, z, p, a, b, c, d;
	
	p = PinkNoise.ar; // source
	
	// B-format encode
	#w, x, y, z = BFEncode1.ar(p, MouseX.kr(-pi, pi), MouseY.kr(0.25pi, -0.25pi), 1); 
	
	// B-format decode to cube / quad ([lfh, rfh, rrh, lrh, lfl, rfl, rrl, lrl])
	// lfl = left fron high, lfl = left front low etc...
	BFDecode1.ar(w, x, y, z, 
		[-0.25pi, 0.25pi, 0.75pi, 1.25pi,-0.25pi, 0.25pi, 0.75pi, 1.25pi], 
		[0.25pi,0.25pi,0.25pi,0.25pi,-0.25pi,-0.25pi,-0.25pi,-0.25pi,]);
	
}.scope(8);
)

3D Ambisonic decoder with compensation for speakers at different distances (delay and intenisty caluclated for meters)



BFDecode1.ar1(w, x, y, z, azimuth, elevation, maxDist, distance)

Decode a two dimensional ambisonic B-format signal for any speaker arrangement
w, x, y, z - the B-format signals. 
azimuth - the angle from 0pi front and center of the speaker.  Can be an array of angles.
elevation - the angle from 0pi center of the speaker.  Can be an array of angles.
maxDist - the distance (in meters) to the furthest speaker from center (this allocates the delay size)
distance - the distance (in meteres) to each speaker.
scaleflag - if 1, apply amplitude scaling to the closest signals to match more distant speakers

s=Server.internal.boot;
(
{
	var w, x, y, z, p;
	
	p = PinkNoise.ar(1) * LFSaw.kr(2, pi, -0.2, 0.2); // source
	
	// B-format encode
	#w, x, y, z = BFEncode1.ar(p, MouseX.kr(-0.5pi, 0.5pi), 0, 1); 
	
	// B-format decode to stereo with speakers at different distances
	BFDecode1.ar1(w, x, y, z, [-0.25pi, 0.25pi], 0, 10, [MouseY.kr(5, 10), 10]);
	
}.scope(2);
)


