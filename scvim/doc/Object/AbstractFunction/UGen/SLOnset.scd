
SLOnset			experimental time domain onset detector

SLOnset.kr(input, memorysize1=20, before=5,after=5, threshold=10, hysteresis=10, mul = 1.0, add = 0.0)

Purely time domain onset detector

Works well for loud signals but fainter onsets are missed, and really loud onsets lead to multiple triggers. 

(my note: needs some sort of log amplitude correction?)

(
x = {arg threshold=10.0; 

var input, onsets; 

input = SoundIn.ar(0); 

onsets= SLOnset.kr(input,20,5,5,threshold); 

Out.ar(0, SinOsc.ar(440,0,0.1)*Decay2.ar(K2A.ar(onsets), 0.01, 0.1)); 

}.play;
)


x.set(\threshold, 10.0)


x.free;


b = Buffer.read(s,"sounds/a11wlk01.wav"); // remember to free the buffer later.
b = Buffer.read(s,"sounds/break2"); // remember to free the buffer later.


(
x = {arg threshold=10.0, hysteresis=20; 

var input, onsets; 

input = PlayBuf.ar(1, b, BufRateScale.kr(b), loop:1);

onsets= SLOnset.kr(input,20,5,5,threshold,hysteresis); 

Out.ar(0, input + (SinOsc.ar(440,0,0.1)*Decay2.ar(K2A.ar(onsets), 0.01, 0.05))); 

}.play;
)


//by setting these appropriately can get somewhere...
x.set(\threshold, 50.0)
x.set(\hysteresis, 10.0)

b.free;


