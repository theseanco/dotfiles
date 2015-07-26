
//SLUGens released under the GNU GPL as extensions for SuperCollider 3, by Nick Collins, http://www.informatics.sussex.ac.uk/users/nc81/

LPCError			Linear Predictive Coding Gone Wrong

LPCError.ar(input, p, mul, add)

Experimental use of LPC on a block by block basis. The interesting thing is the imperfections introduced by the resynthesis. 

input- What do you think you put here?
p- Number of filter coefficients with which to model the signal within 64 sample blocks, 1-64. 



{LPCError.ar(AudioIn.ar, MouseX.kr(1,64))}.play

{LPCError.ar(SinOsc.ar(LFNoise0.kr(0.2,400,500)), MouseX.kr(1,64))}.play

{LPCError.ar(Resonz.ar(Mix(Saw.ar(100*[1,0.9,0.8,0.7,0.5])),1000,0.1,2), MouseX.kr(1,64))}.play







