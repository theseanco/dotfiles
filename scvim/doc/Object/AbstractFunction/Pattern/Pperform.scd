
Pperform			applies a selector to a list of patterns

superclass: Pattern

*new(selectorPattern, receiver, pat1, ... patN)

	selectorPattern - a pattern of symbols (binary operators) or functions of two arguments
	receiver, pat2, ... patN - a pattern of objects, receiver and arguments

see also: Preduce


// examples

// perform a sequence of addition and subtraction
(
a = Pperform(Pseq(['+', '-'], 16), Pseq([0, 1, 2, 3], inf), Pseq([3, 4, 5], inf));
x = a.asStream;
x.nextN(20);
)

// duplicate and multiply
(
a = Pperform(Pseq(['dup', '*'], 8), Pseq([0, 1, 2, 3], inf), Pseq([3, 4, 5, 6], inf));
x = a.asStream;
x.nextN(20);
)



