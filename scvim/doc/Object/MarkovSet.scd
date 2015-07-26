
MarkovSet				first order markov set



instance creation:


	*new(args, updateSeeds)
		args
			a list of arrays that each represent 
			one node in the set:
			[element, [next_elements], [weigths]]
			
			next_elements
				the next node is searched by simple equality.
				if nil, this is a terminator node
			weights
				the array is normalized.
				if weigths is nil, equal weight is used
			
			if args is nil, the set is created and may be trained by the 
			other methods.
		
		updateSeeds
			if set to true, each element is always added to the seeds.


	*fill(n, stream) 	
		n			number of items to read
		stream		a function or stream that returns items to read
		
			

instance methods

		read(prev, next)
			read a pair of values
		
		put(element, next_elements, weights)
			insert a node. any old node is overwritten
		
		remove(prev, next)
			remove a pair of values
			
		next(for)
			return a next item for the arg value.
			if arg is nil, choose from seeds.
		
		parse(stream, length)
			read length items into the set from the stream
			
		asStream
			returns a stream that creates a markov chain
		
		spy
			decrepated: use Pspy (see examples)
			
			
// examples:


// direct node definition
(
m = MarkovSet([
			[100, [120, 130]],
			[120, [100, 1900]],
			[130, nil],
		]);
)

8.do { m.next(100).postln };
8.do { m.next(120).postln };
8.do { m.next(130).postln };

// training by a stream

m = MarkovSet.fill(100, Pseq([1, 2, 3, 4, Prand([5, 55, 555])], inf).asStream);
8.do { m.next(1).postln };
8.do { m.next(4).postln };
8.do { m.next(55).postln };

// training bit by bit

m = MarkovSet.new;
m.read(\x, \y);
m.read(\x, \z);
m.read(\z, \abcde);
m.read(\y, nil);

8.do { m.next(\x).postln };
8.do { m.next(\y).postln };
8.do { m.next(\z).postln };

m.read(\y, \mmmm);
8.do { m.next(\y).postln }; // now it sometimes terminates

m.remove(\y, \mmmm);
8.do { m.next(\y).postln };


//////////  creating streams

(
m = MarkovSet([
			[100, [120, 130]],
			[120, [100, 1900]],
			[130, [100]],
			[1900, [1000, 2000, 3000]],
		]);
)

m.makeSeeds;
x = m.asStream;
32.do { x.next.postln };


// spy out a stream to feed it in

z = Pseq([100, 200, 300, Prand([1.2, 1.4, 1.5])],inf).asStream;
z = Pspy(m, z).asStream;

32.do { x.next.postln };
15.do { z.next } // add some more elements from z
32.do { x.next.postln };


// event streams
(
SynthDef("mark", { arg out, freq, sustain=1, amp=0.1, pan;
	var env, u=1;
	env = EnvGen.kr(Env.perc(0.03, sustain, 5), 1, doneAction:2);
	3.do { var d; d = exprand(0.01, 1); u = SinOsc.ar(d * 300, u, rrand(0.1, 0.4) * d, 1) };
	Out.ar(out, Pan2.ar(SinOsc.ar(u + 1 * freq, 0, amp * env), pan));

}).store;
)

(
a = Pbind(
	\freq, Pshuf([203, 490, 231, 764, 234], inf), 
	\dur, Pshuf([0.5, 0.5, 1.0, 0.25, 0.125, 0.5], inf)
);
m = MarkovSet.fill(20, Pevent(a, Event.default).asStream);
)

m.dict.keysValuesDo { |key, val| postf("key: %\t\tvalue: %\n", key, val) }; ""

// compare:
b = Pchain(Pfsm2(m), (instrument: \mark));
c = Pchain(a, (instrument: \mark));

Ppar([b, c]).play;







