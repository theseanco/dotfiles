
MembraneCircle, MembraneHexagonal	Waveguide mesh physical models of drum membranes 

	MembraneCircle.ar(excitation, tension, loss)

MembraneCircle and MembraneHexagonal are rather similar, being triangular waveguide meshes of a drum-like membrane.  You input some excitation, such as a pulse of noise, and can adjust the tension and loss while it plays.

They're named after the shape made out of triangular meshes. Obviously you can't make a circle out of triangles, but it tries.  At the moment MembraneCircle is a bit bigger than MembraneHexagon, using more waveguides and therefore more CPU.

// Change MembraneCircle to MembraneHexagonal for a different shaped
// circular drum head 
s.boot;
s.reboot;
(
{ var excitation = EnvGen.kr(Env.perc, 
	                         MouseButton.kr(0, 1), 
                             timeScale: 0.1, doneAction: 0
                            ) * PinkNoise.ar(0.4);
  var tension = MouseX.kr(0.01, 0.1);
  var loss = MouseY.kr(0.999999, 0.999, 1);
  MembraneCircle.ar(excitation, tension, loss);
}.play;
)

These UGens are by Alex McLean (c) 2008.


More info

My stuff is here:
  http://doc.gold.ac.uk/~ma503am/

I also recommend the following thesis:
  The Physical Modelling of Drums Using Digital Waveguides
  JA Laird, University of Bristol - 2001 - University of Bristol

this book:
  Real Sound Synthesis for Interactive Applications, Perry R. Cook
  http://books.google.co.uk/books?id=20p7Jg_ZdkMC

and these websites:
  http://ccrma.stanford.edu/~jos/wg.html
  http://www-ccrma.stanford.edu/~be/drum/drum.htm


