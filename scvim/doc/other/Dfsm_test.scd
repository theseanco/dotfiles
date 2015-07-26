




// reset test.
(
{
	var a, trig = MouseButton.kr > 0.5;
	a = Dfsm([[0], Dseq([-2, -3], inf), [1, 7], Dseq([0.1, 0.2], inf), [0, 1], Dseq([900], inf)]);
	Demand.kr(trig, 0, a); // should end after final state.
	Silent.ar;
}.play
);


// reset test.
(
{
	var a, trig = ;
	a = Dfsm([[0], Dseq([-2, -3], inf), [1, 7], Dseq([0.1, 0.2], inf), [0, 1], Dseq([900], inf)]);
	Demand.kr(trig, MouseButton.kr > 0.5, Dseq([a], inf));
	Silent.ar;
}.play
);

// embedding test
(
a = { |t_reset|
	var trig = MouseButton.kr > 0.5;
	a = Dfsm([[0], Dseq([-2, -3, -4], inf), [7], Dseq([0.1, 0.2], 1), [0, 1], Dseq([900, 90], inf)],
		2);
	Demand.kr(trig, t_reset, a);
	Silent.ar;
}.play
);

a.set(\t_reset, 1);


