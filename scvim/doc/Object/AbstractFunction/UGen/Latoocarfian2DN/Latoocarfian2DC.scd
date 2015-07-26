
Latoocarfian2DC		latoocarfian 2D chaotic generator



Latoocarfian2DC.ar(minfreq, maxfreq, a, b, c, d, x0, y0, mul, add)


minfreq, maxfreq - iteration frequency in Hertz
a, b, c, d - equation variables
x0 - initial value of x
y0 - initial value of y


	xn+1 = sin(byn) + c*sin(bxn)
yn+1 = sin(ayn) + d*sin(axn)

x values determine frequencies; y values determine amplitudes.
Stable ranges fora &b tend to be between -3 to + 3.c &d between 0.5 and 1.5.  There are combinations within these ranges that are unstable, so be prepared to tweak this oscillator.



(
{ Latoocarfian2DC.ar(
	SampleRate.ir/8,
	SampleRate.ir/2,
	LFNoise2.kr(2.dup, 1.5, 1.5), 
	d:LFNoise2.kr(2.dup, 0.5, 1.5),
	mul:0.2
) }.play(s);
)
