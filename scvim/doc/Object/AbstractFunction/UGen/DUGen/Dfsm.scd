

Dfsmdemand rate finite state machine

Dfsm(rules, n, randgen)


Similar to "SC://Pfsm"Pfsm,Dfsm implements a markov chain. Each state has a number of next states out of which one is randomly chosen.


rules - array in the format: 
[
		 [ entry states ],
		item, [ next states ],
		item, [ next states ],
		 ...
		end item
 ]

Eachitem can be a number, or a ugen, typically demand rate. If noend item is given,0.0 is used as default.
 
n - number of items from each state to embed. Ifinf, they are embedded completely.

randgen- demand rate random number generator that should ouput values between 0.0 and 1.0. If a deterministic ugen is used, the choice of next states of the finite state machine can be controlled (i.e. 0 will allways choose the first, 1 always the last, else in between).








s.boot;

// random jumps
(
{
	var a, b, trig = Impulse.kr(MouseX.kr(4, 100, 1));
	a = Dfsm([[1], 1.5, [0, 1], 2.5, [0, 1]]);
	b = Demand.kr(trig, 0, a).poll(trig);
	SinOsc.ar(b * 200 + 300) * 0.1
}.play
);

// 2.5 may come after 1.5, but not the other way round.
(
{
	var a, b, trig = Impulse.kr(MouseX.kr(4, 100, 1));
	a = Dfsm([[0], 1.5, [0, 0, 1], 2.5, [1, 2], 0.5, [0]]);
	b = Demand.kr(trig, 0, a).poll(trig);
	SinOsc.ar(b * 200 + 300) * 0.1
}.play
);



// embed demand ugens, embed 2 of each, end with series of 4, 5, 3.
(
{
	var a, n = 2, trig = Impulse.kr(MouseX.kr(4, 100, 1));
	a = Dfsm([
		[0], // entry states
		Dseq([-2, -3], inf), [1], 
		Dseq([1, 2, 1.5], inf), [0, 0, 0, 1, 2], 
		Dseq([4, 5, 3], inf) // exit state
	], n);
	b = Demand.kr(trig, 0, a).poll(trig);
	SinOsc.ar(b * 200 + 700) * 0.1
}.play
);


// direct audification
(
{
	var a, b, pseudorandomness;
	pseudorandomness = Dswitch1((0..1000).scramble / 1000, Dwhite(0, 1, inf)
		* MouseY.kr(1, 1000, 1));
	a = { 
		Dfsm([
			[0, 1, 2], 
			Dseq([0, 0, 1], inf), [1], 
			Dseq([-1, 0].clipExtend(10.rand + 2), inf), [2],
			Dseq([1, 0, -1, 0].clipExtend(10.rand + 4), inf), [1, 1, 3, 0],
			Dwhite(0, 1, inf), [0],
			0
		], 
		MouseX.kr(1, 1115, 1),
		pseudorandomness
	) } ! 10;
	b = Splay.ar(Duty.ar(SampleDur.ir, 0, a)) * 0.1;
}.play
);




