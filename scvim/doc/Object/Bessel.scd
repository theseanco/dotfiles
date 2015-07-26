
Bessel			calculate Bessel functions.	Part of MathLib

Inherits from: Object

Calculates Bessel functions of the first kind. This creates a table, so looking up many different n values is efficient.


Creation / Class Methods

	*new (x)
	
		Create new Bessel functions, for x
		All calculations are for J[n](x)


Instance Methods
	

	j0 
		Resturns 0th order Bessel function of the first kind
		
		// Example
		
		b = Bessel(5); // 5 is the x value
		b.j0; // 0 is the n value, so this returns J[0](5)
		
	j1 
		Resturns 1th order Bessel function of the first kind
		
		// Example
		
		b = Bessel(5); // 5 is the x value
		b.j1; // 1 is the n value, so this returns J[1](5)

	jn (n)
		Calculate nth order Bessel function of the first kind
		
		// Example
		
		b = Bessel(5); // 5 is the x value
		b.jn(2); // 2 is the n value, so this calculates J[2](5)




