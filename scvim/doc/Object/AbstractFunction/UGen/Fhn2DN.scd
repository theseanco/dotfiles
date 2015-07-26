
Fhn2DN			FitzHughNagumo Neuron Firing Oscillator


Fhn2DN.ar(minfreq, maxfreq, rateu, ratew, b0, b1, i, initu, initw, mul, add)


du/dt= rateu*(u-0.3333*u^3 - w)
dw/dt= ratew*(b0+b1*u - w)

All inputs can have .kr rate UGens plugged in.


minfreq, maxfreq -freq iteration
rateu- update rate for u
ratew- update rate for w 
b0- equation constant
b1- equation constant
i - arbitrary external impulse; i.e. pulse wave, trigger, lfnoise, or nothing.
initu- reset value for u
initw- reset value for w



{ Out.ar(0,Pan2.ar(0.5*Fhn2DN.ar(220,800,0.3,0.3,0.6,0.8,LFPulse.kr(MouseX.kr(1, 10, 1), 0, 0.1)),0.0)) }.play

(
SynthDef(\fhn, {|out=0, pan=0, amp=0.1|
	var sig;
	sig=Fhn2DN.ar(110, 22050, TExpRand.kr(0.001, 0.2, Dust.kr(8)), TExpRand.kr(0.001, 0.2, Dust.kr(13)), TRand.kr(0.1, 0.4, Dust.kr(5)),TRand.kr(0.1, 1.9, Dust.kr(3)), mul:amp);
	Out.ar(0,Pan2.ar(sig, pan))
}).play
)

(
SynthDef(\fhn, {|out=0, pan=0, amp=0.1|
	var sig, trig1, trig2, b0, b1;
	trig1=FhnTrig.kr(5, 8, 0.3, 0.3, 1, 1);
	trig2=FhnTrig.kr(8, 13, 0.27, 0.27, 0.6, 0.8);
	b0=Fhn2DN.kr(3, 5, 0.29, 0.29, 0.5, 1.1, mul:0.23, add:0.25);
	b1=Fhn2DN.kr(2, 3, 0.25, 0.25, 0.2, 1.5, mul:0.48, add:0.5);
	sig=Fhn2DN.ar(110, 22050, TExpRand.kr(0.001, 0.3, trig1), TExpRand.kr(0.001, 0.3, trig2), b0, b1, mul:amp);
	Out.ar(0,Pan2.ar(sig, pan))
}).play
)