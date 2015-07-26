
NFunc			A multi-dimensional function:  f:R^n -> R^m 

Inherits from: Array

part of zlbLib

Represents a multi-dimensional functions as an array of functions. The number of arguments in each function and the number of arguments passed to .value should be the same. 

See also: SystemNFunc, Solver

Examples

(
a = [
	{ |x,y| x+y },
	{ |x,y| x-y }
	].as(NFunc);
a.value(1,2)
)




