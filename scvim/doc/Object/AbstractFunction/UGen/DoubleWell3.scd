
//SLUGens released under the GNU GPL as extensions for SuperCollider 3, by Nick Collins, http://www.informatics.sussex.ac.uk/users/nc81/

DoubleWell3			Forced DoubleWell Oscillator

DoubleWell2.ar(reset,ratex,ratey,f,w,delta,initx,inity, mul, add)

Runge-Kutta ODE solver implementation of the chaotic Forced Double Well Oscillator (see Strogatz, Steven H. (1994) Nonlinear Dynamics and Chaos. Addison-Wesley, Reading, MA. pp441-7). 

D2x +delta*Dx-x+x^3 = F

y = Dx

All inputs can have .kr rate UGens plugged in. F is itself an arbitrary audio rate UGen input forcing term

reset- restart with new initial conditions sampled from initx, inity
rate- update rate for x and y
f- forcing term, an arbitrary audio rate input
delta- equation constant
initx- reset value for x
inity- reset value for y



//bass synth
{Out.ar(0,Pan2.ar(DoubleWell3.ar(f:SinOsc.ar(MouseX.kr(0,200),0,MouseY.kr(0.5,4.0))),0.0))}.play

//plotting check of first samples
{DoubleWell3.ar}.plot(0.05, minval:-1, maxval:1)

//gradually changing 
{Pan2.ar(DoubleWell3.ar(0,0.05,LFSaw.ar(Line.kr(10,1000,10)),Line.kr(0.0,0.3,20)),0.0)}.play

//controlled - midscreen amplitude jump
{Pan2.ar(DoubleWell3.ar(0,0.05,LFSaw.ar(MouseX.kr(10,1000)),MouseY.kr(0.0,0.5)),0.0)}.play



//triggering
{DoubleWell3.ar(Impulse.kr(MouseY.kr(0.01,100, 'exponential')),0.1,LFCub.ar(MouseX.kr(10,1000, 'exponential')),MouseY.kr(0.0,1.0),LFNoise0.kr(2.3,0.2,0.8),LFNoise1.kr(2.37,0.2,0.8))}.play


//AudioIn as forcing
{Pan2.ar(DoubleWell3.ar(0,0.05,LPF.ar(AudioIn.ar(1),100,MouseX.kr(0,1000)),MouseY.kr(0.0,0.5)),0.0)}.play






