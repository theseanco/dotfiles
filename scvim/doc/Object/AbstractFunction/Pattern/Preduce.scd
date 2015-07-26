
Preduce			reduces a list of patterns to a single one using an operator

superclass: Pattern

*new(selectorPattern, pat1, pat2, ... patN)

	selectorPattern - a pattern of symbols (binary operators) or functions of two arguments
	pat1, pat2, ... patN - a pattern of objects responding to the selector.




// examples

// perform a sequence of addition and subtraction
(
a = Preduce(Pseq(['+', '-'], 16), Pseq([0, 1, 2, 3], inf), Pseq([3, 4, 5], inf));
x = a.asStream;
x.nextN(20);
)

// duplicate and multiply
(
a = Preduce(Pseq(['dup', '*'], 8), Pseq([0, 1, 2, 3], inf), Pseq([3, 4, 5, 6], inf));
x = a.asStream;
x.nextN(20);
)

// reduce 8 patterns to one.
(
b = { Pshuf([-2, -1, 1, 2, 0], inf) }.dup(8);
a = Preduce(Pseq(['+', '-'], inf), *b);
x = a.asStream;
x.nextN(20);
)


//  set theory examples:


// an array of sets
k = [[0, 3, 4], [0, 5, 7], [1, 3, 4], [-3, 4, 5]].collect(_.as(Set));


// combine the array with a scrambled version of itself.
// set operations: union (|) intersection (&) and symmetric difference (--)

a = Preduce(Pseq(['|', '&', '--'], 3), Pseq(k, inf), Pseq(k.scramble, inf));
x = a.asStream;

x.nextN(16)


(
Pbind(
	\strum, 0.3,
	\degree, a.setConvert.trace,
	\dur, 1
).play;
)



