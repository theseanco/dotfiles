
Standard2DN		standard map 2D chaotic generator



Standard2DN.ar(minfreq, maxfreq, k, x0, y0, mul, add)


minfreq, maxfreq - iteration frequency in Hertz
k - perturbation amount
x0 - initial value of x
y0 - initial value of y
	
	xn+1 = (xn + yn+1) % 2pi
	yn+1 = (yn + ksin(xn)) % 2pi
.
{ Standard2DN.ar(220, 11025, mul:0.3) }.play(s);


// mouse-controlled param
{ Standard2DN.ar(SampleRate.ir/2, SampleRate.ir, MouseX.kr(0.9,4), mul:0.3) }.play(s);

// as a frequency control
{ SinOsc.ar(Standard2DN.ar(10, 20, MouseX.kr(0.9,4))*800+900)*0.4 }.play(s);