
Henon2DC		hmap 2D chaotic generator



Henon2DC.ar(minfreq, maxfreq, a, b, x0, y0, mul, add)


minfreq, maxfreq - iteration frequency in Hertz
a, b - equation variables
x0 - initial value of x
y0 - initial value of y
	
	
	y = b * x(n)
	xn+2 = 1 - axn+12 + y

{ Henon2DC.ar(SampleRate.ir/4, SampleRate.ir/2, MouseX.kr(1,1.4), MouseY.kr(0,0.3)) * 0.2 }.play(s);

(
{ Henon2DC.ar(
	2200, 8800, 
	LFNoise2.kr(1, 0.2, 1.2), 
	LFNoise2.kr(1, 0.15, 0.15)
) * 0.2 }.play(s);
)

{ SinOsc.ar(Henon2DC.ar(20, 40, MouseX.kr(1,1.4), MouseY.kr(0,0.3))*800+900)*0.4 }.play(s);