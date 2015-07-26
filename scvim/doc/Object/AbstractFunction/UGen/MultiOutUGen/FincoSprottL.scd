
FincoSprottL Yet another chaotic system UGen



# x,y,z = FincoSprottL.ar(freq, a, h, xi, yi, zi, mul, add)



The "system L" described by Lucas Finco and Clint Sprott:
http://sprott.physics.wisc.edu/chaos/finco/abs.html

The system is defined by:



dx/dt =y+zdy/dt =a|x| -ydz/dt = 1 -x


See also [FincoSprottM] and [FincoSprottS]

Examples using just the x value:

// Vary the freq with the mouse
{ FincoSprottL.ar(MouseX.kr(20, SampleRate.ir)).poll(2) * 0.3 }.play(s);


// Vary the parameter "a".
// NB the parameter affects the amplitude, so this example is clipped
{ FincoSprottL.ar(SampleRate.ir, a:LFNoise0.kr(1).range(1, 3)).poll(2).softclip * 0.3 }.play(s);



An example utilising the three different outputs as pitch, PWM and pan values (respectively):



(
{
# x,y,z = FincoSprottL.ar(MouseX.kr(1, 200));
Pan2.ar(Pulse.ar(x.range(100,1000), y.range(0,1), 0.3), z + 0.95)
}.play(s)
)


