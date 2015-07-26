
BlitB3Square			Bipolar BLIT derived square waveform

BlitB3Square.ar(freq, leak, mul, add )

Bipolar (alternates 1.0 and -1.0) band limited impulse generator based on B-Spline interpolation of order 3, integrated to create a square waveform. 

freq You start to hear aliasing over 4000 Hz or so, otherwise perceptually indistinguishable from an analogue waveform.  Max frequency is half the sampling rate, but you'll hear aliasing well before that. Note that frequency can only be changed at the close of each period, so for very low frequencies, there will be a delay changing pitch. Audio rates for fundamental frequencies in the range of standard acoustic instrument pitches, ie piano keyboard or so, work best.  

leak leaky coefficient for integration. 0 would give back the impulses, higher numbers (up to near 1.0) fill out the inter-impulse space, integrating the waveform. 

See also: BlitB3Saw, BlitB3, BlitB3Tri 


{ BlitB3Square.ar(XLine.kr(1000, 20, 10)) }.play;

{ BlitB3Square.ar(MouseX.kr(20,1000,'exponential'),MouseY.kr(0.001,0.999)) }.play;

//comparison
//blit version is cheaper, but aliases once pushed over 4000 or so at 44100 SR
{ Pulse.ar(4000, 0.5) }.play;
{ BlitB3Square.ar(4000) }.play;


//spot the difference in CPU usage
{ Mix.fill(100, {Pan2.ar(0.1*BlitB3Square.ar( ((LFNoise0.kr(rrand(2,3))).range(0,36)+36).midicps), 1.0.rand2) }) }.play;

{ Mix.fill(100, {Pan2.ar(0.1*Pulse.ar( ((LFNoise0.kr(rrand(2,3))).range(0,36)+36).midicps, 0.5), 1.0.rand2) }) }.play;



