
//SLUGens released under the GNU GPL as extensions for SuperCollider 3, by Nick Collins, http://www.informatics.sussex.ac.uk/users/nc81/

EnvDetect			Envelope Follower Filter

EnvDetect.ar(in, attack,  release)

Code adapted from musicdsp.org for a simple envelope tracking filter. 

in- input
attack- attack time in seconds
release- relase time in seconds 


(
SynthDef("help-EnvDetect",{Out.ar(0,Pan2.ar(
SinOsc.ar(440,0,0.3*EnvDetect.ar(LFNoise1.ar(20), MouseX.kr(0.001,0.1,'exponential'), MouseY.kr(0.001,0.1,'exponential'))) 
,0.0))
}).play
)


(
SynthDef("help-EnvDetect",{Out.ar(0,Pan2.ar(
LFSaw.ar(EnvDetect.ar(LFNoise1.ar(11,100,200), MouseX.kr(2,0.0001,'exponential'), MouseY.kr(2,0.0001,'exponential')),0,0.3*EnvDetect.ar(LFSaw.ar(7), MouseX.kr(0.001,1,'exponential'), MouseY.kr(0.001,1,'exponential'))) 
,0.0))
}).play
)



