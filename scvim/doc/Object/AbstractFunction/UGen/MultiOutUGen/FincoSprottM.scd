
FincoSprottM Yet another chaotic system UGen



# x,y,z = FincoSprottM.ar(freq=22050, a= -7, b=4, h=0.05, xi=0, yi=0, zi=0, mul=1.0, add=0.0)



The "system M" described by Lucas Finco and Clint Sprott:
http://sprott.physics.wisc.edu/chaos/finco/abs.html

The system is defined by:



dx/dt = -z 
dy/dt =a|x| -y 
dz/dt = 1 +bx+y


(NB: The parameter "a" should be negative. Its sign has been reversed compared to the formulation presented by Finco and Sprott.)

See also [FincoSprottL] and [FincoSprottS]



An example using just the x value:


{ FincoSprottM.ar(MouseX.kr(20, SampleRate.ir)) * 0.3 }.play(s);



An example utilising the three different outputs as pitch, PWM and pan values (respectively):



(
{
# x,y,z = FincoSprottM.ar(MouseX.kr(1, 200));
Pan2.ar(Pulse.ar(x.range(100,1000), y.range(0,1), 0.3), z + 0.5)
}.play(s)
)


