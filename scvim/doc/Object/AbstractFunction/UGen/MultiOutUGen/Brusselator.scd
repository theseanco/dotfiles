
Brusselator			Prigogine oscillator

Brusselator.ar( reset=0, rate=0.01, mu=1.0, gamma=1.0, initx=0.5,inity=0.5,mul, add)

Euler ODE solver implementation of the Brusselator equations (http://en.wikipedia.org/wiki/Brusselator).  

x' = x^2*y - (mu+1)*x + gamma 
y' = -x^2*y + mu*x

All inputs can have .kr rate UGens plugged in.

Nonlinear oscillators can blow up, treat with caution. This one is relatively stable however, converging to a fixed point, or a limit cycle, in the upper positive quadrant. for some reasonable values. Just be careful if mu gets much bigger than gamma (though making it larger is necessary to get some chaotic oscillation behaviour); you can retrigger to get back to normal, and keep the rate lower to avoid Euler integration blow-ups. You may just need to scale and push down around zero to avoid a DC offset. Fixed point is at (x,y) = (gamma, mu/gamma)

reset- If > 0.0, restart with new initial conditions sampled from initx, inity
rate- update rate for a sample step
mu- equation constant. Set mu > (gamma**2 + 1.0) for the more fun limit cycle regions
gamma- equation constant
initx- reset value for x
inity- reset value for y


//listen to x and y output
{Out.ar(0,Brusselator.ar(Impulse.kr(MouseY.kr(1,50,'exponential')),MouseX.kr(0.01,1,'exponential')))}.play

//avoid DC offset (default gamma is 1.0, listening to x only, so take off gamma
{Out.ar(0,Pan2.ar((Brusselator.ar(Impulse.kr(MouseY.kr(1,50,'exponential')),MouseX.kr(0.01,1,'exponential')))[0] - 1.0) )}.play


//fun time, stable oscillation with these parameters
{var mu = MouseY.kr(1.0,1.5); Out.ar(0,Pan2.ar(Brusselator.ar(0.0,MouseX.kr(0.01,0.1,'exponential'),mu,0.25)[0] ) )}.play


{ Out.ar(0,Pan2.ar(Brusselator.ar(Impulse.kr(10),MouseX.kr(0.01,0.1,'exponential'),1.5,0.25,MouseY.kr(-1.0,1.0),0.0)[0]) )}.play


{ Out.ar(0,Brusselator.ar(Impulse.kr(MouseY.kr(1,500,'exponential')),MouseX.kr(0.01,0.1,'exponential'),1.15,0.5,0.5,1.0) )}.play


