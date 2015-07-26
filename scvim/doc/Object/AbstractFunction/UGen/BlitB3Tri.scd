
BlitB3Tri			Bipolar BLIT derived triangle

BlitB3Tri.ar(freq, leak, leak2 mul, add )

Bipolar (alternates 1.0 and -1.0) band limited impulse generator based on B-Spline interpolation of order 3, integrated twice to create a triangle waveform. In this case, richer sound, but probably turns out not to be as useful (less efficient, distortion issues) as LFTri or an integration of square wave. But also see DPW3Tri. 

See also: BlitB3Saw, BlitB3Square, BlitB3, DPW3Tri



{ BlitB3Tri.ar(XLine.kr(1000, 20, 10)) }.play;

//unfortunately, aliasing returns at higher frequencies (over 5000Hz or so) with a vengence
{ BlitB3Tri.ar(MouseX.kr(20,8000,'exponential').poll,0.99,MouseY.kr(0.001,0.99)) }.play;

//more efficient, some aliasing from 3000, but not so scary over 5000. Duller sound (less high harmonics included for lower fundamentals)
{ LFTri.ar(MouseX.kr(20,8000,'exponential').poll) }.play;


//comparison
//LFTri version cheaper, and less aliasing! 
x = { LFTri.ar(4000) }.play;
x = { BlitB3Tri.ar(4000) }.play;



