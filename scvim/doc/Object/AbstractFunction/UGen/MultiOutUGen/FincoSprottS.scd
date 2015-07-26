
FincoSprottS Yet another chaotic system UGen



# x,y,z = FincoSprottS.ar(freq=22050, a=8, b=2, h=0.05, xi=0, yi=0, zi=0, mul=1.0, add=0.0)



The "system S" described by Lucas Finco and Clint Sprott:
http://sprott.physics.wisc.edu/chaos/finco/abs.html

The system is defined by:



dx/dt = -x-ay 
dy/dt =x +b|z| 
dz/dt =x + 1



See also [FincoSprottL] and [FincoSprottM]




An example using just the x value:


{ FincoSprottS.ar(MouseX.kr(20, SampleRate.ir)) * 0.3 }.play(s);




An example utilising the three different outputs as pitch, PWM and pan values (respectively):



(
{
# x,y,z = FincoSprottS.ar(MouseX.kr(1, 200));
Pan2.ar(Pulse.ar(x.range(100,1000), y.range(0,1), 0.3), z + 0.5)
}.play(s)
)


