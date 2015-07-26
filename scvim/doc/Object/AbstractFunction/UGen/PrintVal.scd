
//SLUGens released under the GNU GPL as extensions for SuperCollider 3, by Nick Collins, http://www.informatics.sussex.ac.uk/users/nc81/

PrintVal			debug assistance

PrintVal.kr(in, numblocks, id)

This is sometimes helpful just to check output values- it should post to the Post Window, but don't make it post too often or the CPU use will rise dramatically.  

NOTE: this UGen is now here really for backwards compatibility; try doing .poll to any running UGen to get printed data back.

in- input to sample (.kr rate)
numblocks- print the value after this number of control periods (44100/64 is about 689 per second)
id- give a tag to the printing so that you can use more than one in a patch to test multiple things


SynthDef("help-PrintVal",{PrintVal.kr(SinOsc.kr(440,0,0.1), 100)}).play


//two at once
(
SynthDef("help-PrintVal",{

PrintVal.kr(SinOsc.kr(440,0,0.1), 100, 1);

PrintVal.kr(LFNoise1.kr(100,0.1), 10, 2);

}).play
)






