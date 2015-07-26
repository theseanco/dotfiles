
SystemNFunc			A multi-dimensional function of the type  f:(R^n)^p -> (R^m)^p 	

Inherits from: Array

Represents a multi-dimensional functions as an array of arrays of functions.

See also: NFunc, Solver

Examples

(
a = [[{ |x,y| x+y },
	{ |x,y| x-y }],
	[{ |x,y| 2x },
	{ |x,y| y+1 }]].as(SystemNFunc);
	

a.value(1,2)
)


