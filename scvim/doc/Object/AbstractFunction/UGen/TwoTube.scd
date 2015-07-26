
//SLUGens released under the GNU GPL as extensions for SuperCollider 3, by Nick Collins, http://www.informatics.sussex.ac.uk/users/nc81/

TwoTube			physical modeling simulation; two tubes

TwoTube.ar(input=0, k=0.01, loss=1.0, d1length=100,d2length=100,  mul = 1.0, add = 0.0)

Physical model; two tube sections with scattering junction inbetween; their relative areas determine k. 

input- Excitation to inject into the system
k- 	  Scattering coefficient for junction of two tubes, usually -1<=k<=1
loss-  Amplitude loss factor in circulation
d1length- Length in samples of first delay line
d2length- Length in samples of second delay line (no interpolation implemented yet)



(
{
var delay1, delay2, source; 

//k from -1 to 1

//in samples
delay1= 100; 
delay2= 40;

source= WhiteNoise.ar(0.5)*EnvGen.ar(Env([1,1,0],[(delay1+delay2)/SampleRate.ir,0.0]), Impulse.kr(MouseY.kr(1,4)));

TwoTube.ar(source,MouseX.kr(-1,1),0.99,delay1,delay2); 
}.play

)




(
SynthDef(\twotube,{arg delay1=100, delay2=50, k=0.0, loss=0.999, dur=0.5, pan=0.0; 
var source; 

//k from -1 to 1

source= WhiteNoise.ar(0.5)*EnvGen.ar(Env([1,1,0,0],[(delay1+delay2)/SampleRate.ir,0.0,1.0]));

Out.ar(0,Pan2.ar(TwoTube.ar(source,k,loss,delay1,delay2)*EnvGen.ar(Env([0,1,1,0],[0.001]++((dur-0.001)*[0.4,0.6])),doneAction:2),pan)); 
}).send(s); 
)



(
t.stop;
t={

inf.do{

Synth(\twotube,[\delay1, rrand(1,300),\delay2, rrand(1,300),\loss, rrand(0.9,0.999),\dur, rrand(0.1,5.0), \pan, rrand(-1,1.0), \k, rrand(-1,1.0)]);

0.5.wait;
};

}.fork;
)



