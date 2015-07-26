

Oregonator			Chemical reaction modelling Oscillator

Oregonator.ar( reset=0, rate=0.01, epsilon=1.0, mu=1.0, q=1.0, initx=0,inity=0,initz=0, mul, add)

Euler ODE solver implementation of the Oregonator equations (http://www.scholarpedia.org/article/Oregonator).  

x' = epsilon* (q*y  - x*y + x*(1-x) ) 
y' = mu* (-q*y -x*y +z)
z' = x-y

All inputs can have .kr rate UGens plugged in.

The Oregonator can blow up, treat with caution. 

reset- If > 0.0, restart with new initial conditions sampled from initx, inity, initz
rate- update rate for a sample step
epsilon- equation constant
mu- equation constant
q- equation constant
initx- reset value for x
inity- reset value for y
initz- reset value for z




//hits fixed points too quickly
{Out.ar(0,Pan2.ar(0.1*Oregonator.ar(Impulse.kr(10),MouseX.kr(0.01,1,'exponential')),0.0))}.play


{Out.ar(0,Oregonator.ar(Impulse.kr(100),0.1, 0.1, 0.5, 0.2,initx:0.1, inity:-0.5, initz:0.7))}.plot(0.1)


{Out.ar(0,Pan2.ar(0.1*Oregonator.ar(Impulse.kr(100),0.1, 0.1, 0.5, 0.2,initx:0.1, inity:-0.5, initz:MouseX.kr)[0],0.0))}.play


{Out.ar(0,Pan2.ar(0.1*Oregonator.ar(Impulse.kr(MouseX.kr(100,1000)),0.1, 0.2, 0.5, 0.2,initx:MouseY.kr, inity:-0.5, initz:0.5)[0],0.0))}.play


{Out.ar(0,Pan2.ar(0.1*Oregonator.ar(Impulse.kr(MouseX.kr(10,1000,'exponential')),0.3, 0.1,0.1, 0.2,initx:MouseY.kr(0.1,1.0), inity:-0.5, initz:0.5)[0],0.0))}.play


{Out.ar(0,Pan2.ar(0.1*Oregonator.ar(Impulse.kr(MouseX.kr(100,1000)),0.1, 0.2, 0.5, 0.2,initx:MouseY.kr, inity:-0.5, initz:0.5)[1],0.0))}.play


{Out.ar(0,Pan2.ar(0.1*Mix(Oregonator.ar(Impulse.kr(MouseX.kr(10,1000)),0.1, 0.2, 0.5, 0.2,initx:MouseY.kr, inity:-0.5, initz:0.5)),0.0))}.play


