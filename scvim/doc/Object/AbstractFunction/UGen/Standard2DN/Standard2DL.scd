
Standard2DL		standard map 2D chaotic generator



Standard2DL.ar(minfreq, maxfreq, k, x0, y0, mul, add)


minfreq, maxfreq - iteration frequency in Hertz
k - perturbation amount
x0 - initial value of x
y0 - initial value of y
	
	xn+1 = (xn + yn+1) % 2pi
	yn+1 = (yn + ksin(xn)) % 2pi
.
{ Standard2DL.ar(220, 11025, mul:0.3) }.play(s);


// mouse-controlled param
{ Standard2DL.ar(11025, 44100, MouseX.kr(0.9,4), mul:0.3) }.play(s);

// as a frequency control
{ SinOsc.ar(Standard2DL.ar(10, 20, MouseX.kr(0.9,4))*800+900)*0.4 }.play(s);