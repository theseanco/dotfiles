
Gbman2DN		gingerbreadman map 2D chaotic generator



Gbman2DN.ar(minfreq, maxfreq, x0, y0, mul, add)


minfreq, maxfreq - iteration frequency in Hertz
x0 - initial value of x
y0- initial value of y
	
	xn+1 = 1 - yn + |xn|
	yn+1 = xn

{ Gbman2DN.ar(MouseX.kr(20, SampleRate.ir*0.25), MouseX.kr(80, SampleRate.ir), 0.1) }.play(s);

{ Gbman2DN.ar(11025, 22050, -0.7, -2.7, 0.1) }.play(s);

{ Gbman2DN.ar(2200, 8800, 1.2, 2.0002, 0.1) }.play(s);
