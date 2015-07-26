
Lorenz2DN		lorenz 2D chaotic generator



Lorenz2DN.ar(minfreq, maxfreq, s, r, b, h, x0, y0, z0, mul, add)


freq - iteration frequency in Hertz
s, r, b- equation variables
h - integration time step
x0 - initial value of x
y0 - initial value of y
z0 - initial value of z
	
	x' = s(y - x)
	y' = x(r - z) - y
	z' = xy - bz

The time step amounthdetermines the rate at which the ODE is evaluated.  Higher values will increase the
rate, but cause more instability.  This generator uses a different algorithm than the LorenzN/L/C ugen included with current distributions.  The resulting sound is somewhat different, and it also means thath becomes unstable around 0.02.


{ Lorenz2DN.ar(11025, 44100) }.play(s);


// randomly modulate params
(
{ Lorenz2DN.ar(
	11025, 44100, 
	LFNoise0.kr(1, 2, 10), 
	20,
	LFNoise0.kr(1, 1.5, 2),
	0.02
) * 0.2 }.play(s);
)

// as a frequency control
{ SinOsc.ar(Lorenz2DN.ar(40, 80, h:0.02)*800+900)*0.4 }.play(s);