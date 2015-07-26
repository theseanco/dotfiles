
Dtag			demand rate tag system

superclass: DbufTag

	
	*new(bufsize, v, axiom, rules, recycle, mode)
	
	
	bufsize		maximum string size - when this size is reached, the process ends (dependent on mode). 
				Theoretically, tag systems have an infinite "tape" (memory) size - practically, one may want to try different finite sizes. This value is static.
				for a version that runs on a separate buffer, see [DbufTag]

	v			deletion number (ν). Number of symbols that are deleted at each step.
	
	axiom		the string to start with - use integers from 0 to N, which correspond to rule indices.
	
	rules		the production rules are given as an array of arrays. 
				for each integer the production rule at that position is chosen (see rule schema below).
				
	recycle		if this is not zero, the tag system simply adds this value as an offset to its write position 
				and continues where it normally would end. 
				This results in a recycling tag system (see below).
	
	mode		this parameter decides in what case to apply the above recycle parameter. 
				If recycle = 0, only mode 4 makes a difference.
				
				mode 0: both recycle when string overrun or string empty (default case)
				mode 1: recycle only when string overrun, halt when empty
				mode 2: recycle only when string empty, halt when overrun
				mode 3: always halt
				mode 4: always halt and post information.
				mode 5: same, but post buffer values (max 32) and rule number.

	
Most inputs, also rule values, may themselves be demand rate ugens, or any other ugen or value. Thus, while the rule sizes stay the same, the rule values may dynamically changed. If those values are demand rate ugens, the rule values and the deletion number are evaluated each cycle, recycle is called each time the system ends.

At each step, Dtag outputs the tagged symbol, which is the rule index for the next step. If the appended string is needed instead, this can be done by applying the method allSymbols to the UGen.

// rule schema
	
	0 -> 00
	1 -> 1101
	
	is written as [[0, 0], [1, 1, 0, 1]]
	
	
	0 -> 02
	1 -> 1101
	2 -> 01
	
	is written as [[0, 2], [1, 1, 0, 1], [0, 1]]


	
Emil Post's tag systems
		
Emil Post developed tag systems from the 1920s onward as an instrument of generalization of symbolic logic, hoping that it would allow the study of properties like decidability and completeness. Due to their intractibility he gave up the attempt to prove their unsolvability. Minsky showed later that tag systems are recursively unsolvable, i.e. of equivalent to a universal turing machine [2].

This type of rewriting system consists of an initial string of symbols (axiom), a set of rules and a deletion number (ν). In our implementation, Post's parameter μ (size of the alphabet) is implicit is the number of letters in the alphabet used. The deletion number is a very interesting parameter, since it determines what part of the string forms the instructions for the process and what part is omitted. Post described three classes of behaviour: termination, periodicity, and divergence. "The classes with μ = 1 or ν = 1 or ν = μ = 2 were proven solvable. The case with μ = 2, ν > 2 he calls intractable, while he terms the cases μ > 2, ν = 2 as being of 'bewildering complexity'" [4].


Further reading 

[1] Martin Davis, The undecidable. Basic papers on undecidable propositions, unsolvable problems and computable functions, New York 1965. (see "Account of an anticipation”).
[2] Marvin Minsky. Recursive unsolvability of post’s problem of tag and other topics in the theory of turing machines. Annals of Mathematics, 74:437–455, 1961.
[3] Elizabeth de Mol, Tracing Unsolvability. A Mathematical, Historical and Philosophical analysis with a special focus on tag systems. http://logica.ugent.be/centrum/writings/doctoraten.php. (thanks a lot for introducing me to this topic!)
[4] Elizabeth de Mol, Closing the circle: An analysis of emil post’s early work., The Bulletin of Symbolic Logic 12.
[5] Emil Post, Formal reductions of the combinatorial decision problem, American Journal of Mathematics, 65 (2), 197-215 (1943). (see p.203ff.)

More poetically, looking out for complex messages hidden in noise: Stanisłav Lem, His Master's Voice, 1968.


How it works
	
In the beginning, the string is the axiom, and its first symbol is tagged. 
At each step, the rule is looked up that corresponds to this tagged symbol: 1 corresponds to the rule with index 1 (the 2nd), 0 corresponds to the rule with index 0 (the 1st) etc.

If no rule is found, the process halts. Otherwise, two things happen: 
		ν number of symbols are dropped from the string by moving the tag ν steps forward, 
		At the other end of the string, the symbols of the corresponding production rule are appended.
		
When the string is empty (i.e. the tag has reached its rightmost end), or the maximum memory size is reached, the process halts. When you set mode to 4, this information is posted (be careful, because posting at very high frequencies can overload the system).


// One of the examples by Emil Post
// printout: "|" represents the tag, ">" represents the end of the string.
// the printout is limited to 32 characters
(
{ 
	var tag, trig;
	trig = Impulse.kr(2); // advance 2 times a second
	tag = Dtag(
		2048, // maximum string size
		3, // advance three steps each turn
		[1, 0, 1], // axiom
		[[1, 0], [1, 1, 0, 1]], // rules
		0, // no recycle
		5 // print mode
	);
	Demand.kr(trig, 0, tag);
	0.0 // silence for now
}.play;
)


Recycling tag systems: a variant of tag systems

Like in an early procedure by Emil Post, in this implementation the symbols are not deleted from the end, but the reading position is advanced (the tag is moved forward). Mathew Cook developed a variant, where instead of a single axiom, one has a list of axioms that is used one after the other [3].

Instead of assuming an infinite tape or such an axiom list, one now can try and see what happens if one assumes a cyclic tape instead - while this may not add any expressive power to the concept, it is an interesting special case. At the loop point (a certain limit string size), a new axiom is chosen from the beginning (r > 0), or backward, from the end of the tape (r < 0).

If recycle is not 0, instead of halting, the old string is reused by cutting out an axiom of that length from the current position and the process continues. For r > 0 the read position is advanced by r steps, for r < 0 the tag is moved back by r steps.
If mode = 1, recycling happens only when the string is too large. 
If mode = 2, recycling happens happens only when the string is empty. (see above)

// example: 
0 1 0|0 1 1 (vertical line is the tag. with r= 2, the new axiom would be 01, v= -3 it would be 010)

In the metaphor of the tag game, the recycle parameter (r) is the head start for the runaway writer before the tagger (see: http://en.wikipedia.org/wiki/Tag_%28game%29)
	



Examples


s.boot;


// the examples by Emil Post again
// directly listen to the tag system output (audification)
// when the string size exceeds the size, the synth is freed (doneAction: 2)
(
{ 
	var tag, axiom, rules, size, dt;
	dt = SampleDur.ir; // play with audio rate
	size = SampleRate.ir * 2;
	axiom = [1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1];
	// axiom = axiom.scramble.keep(rrand(4, 16)).postln;
	v = 3;
	rules = [[1, 0], [1, 1, 0, 1]];
	tag = Dtag(size, v, axiom, rules);
	
	TDuty.ar(dt, 0, tag, doneAction: 2).dup * 0.1
}.play;
)

// the above as a frequency input for a sine oscillator
// control delta time by cursor position
(
{ 
	var tag, axiom, rules, size, dt, sineFreq;
	dt = MouseX.kr(1e-1, 1e-4, 1); 
	size = 48000 * 2;
	axiom = [1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1];
	v = 3;
	rules = [[1, 0], [1, 1, 0, 1]];
	tag = Dtag(size, v, axiom, rules);
	sineFreq = Duty.ar(dt, 0, tag, doneAction: 2)
		* 200 + 300;
	(SinOsc.ar(sineFreq.lag(dt)) * AmpCompA.kr(sineFreq) * 0.2).dup
}.play;
)


// a slow demonstration
// see DbufTag for an output of the string itself
(
{ 
	var tag, index, trig, rules, axiom;
	axiom = [1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1];
	rules = [[0, 0], [1, 1, 0, 1]];
	trig = Impulse.kr(4);
	tag = Dtag(256, 2, axiom, rules, mode: 5);
	index = Demand.kr(trig, 0, tag).poll(trig);
	SinOsc.ar(index* 100 + 300 + SinOsc.kr([4, 4.1], 0, 8)) * 0.1
}.play;
)


/*
1 0 1 0 1 0 0 1 1 1 0 1 0 1 1 1 1 0 0 1
    1 0 1 0 0 1 1 1 0 1 0 1 1 1 1 0 0 1 1 1 0 1
        1 0 0 1 1 1 0 1 0 1 1 1 1 0 0 1 1 1 0 1 1 1 0 1
            0 1 1 1 0 1 0 1 1 1 1 0 0 1 1 1 0 1 1 1 0 1 1 1 0 1
                1 1 0 1 0 1 1 1 1 0 0 1 1 1 0 1 1 1 0 1 1 1 0 1 0 0
                    0 1 0 1 1 1 1 0 0 1 1 1 0 1 1 1 0 1 1 1 0 1 0 0 1 1 0 1
                        0 1 1 1 1 0 0 1 1 1 0 1 1 1 0 1 1 1 0 1 0 0 1 1 0 1 0 0
                          1 1 1 1 0 0 1 1 1 0 1 1 1 0 1 1 1 0 1 0 0 1 1 0 1 0 0 0 0 0
                              1 1 0 0 1 1 1 0 1 1 1 0 1 1 1 0 1 0 0 1 1 0 1 0 0 0 0 0 1 1 0 1
                    	...
                    
              
creating the series: 1 1 1 0 1 0 0 1 1 ...                                  
*/



// demonstrating the mechanism of a recycling tag system
// the tag game round the house
(
{ 
	var tag, trig;
	var deletionNumber = 3;
	var axiom = [0, 1, 2];
	var rules = [[0, 1], [2, 0], [1, 1]];
	var recycle = -3; // head start when writer was tagged.
	tag = Dtag(9, deletionNumber, axiom, rules, recycle, 5);
	
	SinOsc.ar(
		Duty.kr(1, 0, tag, doneAction:2)
		* 100 + 300 + SinOsc.kr([4, 4.1], 0, 8)
	) 
	* 0.1 ! 2
}.play;
)




// a more complicated tag system whith a random axiom.
// μ = 4
// v varies [1..6] with cursor position
// reinitialised when ended, a 1 sec pause each overrun.
(
{
	var tag, index, axiom, rules, freq, size;
	var deletionNumber = MouseX.kr(1, 6);
		// this is a big buffer, which is expensive to alloc in real time.
		// for large buffers, you may want to use DbufTag.
	size = 48000 * 4; 
	freq = 15000;
	
	axiom = Array.fill(14, { #[0, 1, 2, 3].choose });
	axiom.join(" ").postln;
	rules = [[0, 1, 1], [1, 3, 2, 0], [1, 2], [3, 1, 1]];
	
	tag = Dtag(size, deletionNumber, axiom, rules, 0, mode: 4);
	tag = Dseq([tag, Dseq([0], freq)], inf); 
	index = Duty.ar(1 / freq, 0, tag, doneAction:2);
	SinOsc.ar(index * 1200 + 400).dup * 0.1
	
}.play;
)


// aliens calling
// μ = 4, recycling tag system.
// v varies (1..16) (cursor horizontal)
// varying recycle value (cursor vertical)
(
{ 
	var tag, index, axiom, rules, freq, size;
	var deletionNumber = MouseX.kr(1, 16).floor;
	var recycle = MouseY.kr(-60, 60).floor;
	recycle = recycle + (recycle.abs < 1); // avoid 0.
	freq = SampleRate.ir;
	size = 6000; // small max string size. increase for higher complexity
	axiom = Array.fill(14, { #[0, 1, 2, 3].choose });
	axiom.join(" ").postln;
	deletionNumber.poll(label: "deletionNumber");
	recycle.poll(label: "recycle");
	
	rules = [[0, 1, 1], [1, 3, 2, 0], [1, 2], [3, 1, 1]];
	
	tag = Dtag(size, deletionNumber, axiom, rules, recycle);
	index = Duty.ar(1 / freq, 0, tag, doneAction:2);
	SinOsc.ar(index * 1200 + 400).dup * 0.1
	
}.play;
)


