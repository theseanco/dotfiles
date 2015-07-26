
//SLUGens released under the GNU GPL as extensions for SuperCollider 3, by Nick Collins, http://www.informatics.sussex.ac.uk/users/nc81/

Max			maximum within last x samples

Max.kr(in, numsamp)

Will output the maximum value of over the last numsamp samples, calculated efficiently by storing a local maximum for every control period. The numsamp argument will be rounded to a multiple of control period lengths. The output is the held maximum at control rate. 

in- input to sample (.ar rate)
numsamp- take the maximum over this number of samples into the past (will be rounded to control periods)


(
SynthDef("help-Max",{Out.ar(0,Pan2.ar(
SinOsc.ar(Max.kr(SinOsc.ar(2,0,300,400).abs,6400),0,0.1) 
,0.0))
}).play
)

//compare
(
SynthDef("help-Max",{Out.ar(0,Pan2.ar(
SinOsc.ar(SinOsc.ar(2,0,300,400),0,0.1) 
,0.0))
}).play
)

(
SynthDef("help-Max",{Out.ar(0,Pan2.ar(
SinOsc.ar(Max.kr(LFNoise0.ar(20,300,400),3200),0,0.1) 
,0.0))
}).play
)

//compare
(
SynthDef("help-Max",{Out.ar(0,Pan2.ar(
SinOsc.ar(LFNoise0.ar(20,300,400),0,0.1) 
,0.0))
}).play
)




