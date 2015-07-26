
GenLaguerre			calculate the generalized Laguerre polynomials	

Inherits from: Object

Calculates the generalized Laguerre polynomials of degree n and order alpha. When alpha is set to zero it reduces to the normal Laguerre polynomials. 


Creation / Class Methods

	*new(n, alpha)
	
		Creates a new instance of GenLaguerre.
		n - An instance of Integer.
		alpha - An instance of SimpleNumber.
		
	*calc(n, alpha, x)
		
		Calculates the generalized Laguerre polynomial of degree n and order alpha for x.
		n - An instance of Integer.
		alpha, x - Both an instance of SimpleNumber.	

Instance Methods
	
	setN(n)
		
		Set the degree of the generalized Laguerre polynomial. 
		
	getN(n)	
		
		Get the degree of the generalized Laguerre polynomial.
		
	setAlpha(alpha)
	
		Set the order of the generalized Laguerre polynomial. When alpha is set to zero, it reduces to a normal or simple Laguerre polynomial.
	
	getAlpha(alpha)
	
		Get the order of the generalized Laguerre polynomial.	
		
	setNAlpha(n, alpha)
	
		Set the degree n and order alpha of the generalized Laguerre polynomial.
		
	getNAlpha(n, alpha)
	
		Get the degree n and order alpha of the generalized Laguerre polynomial.
		
	calc(x)
	
		Calculate the generalized Laguerre polynomial for x.
	
Examples



//Create an instance of GenLaguerre with degree 4 and order 1.5 and calculate for x = 10
a = GenLaguerre.new(4, 1.5);
a.calc(10)

//Also possible to calculate directly
GenLaguerre.calc(4, 1.5, 10);

//Graph the polynomial for x running from 0 to 12
a = GenLaguerre.new(4, 1.5);
1000.collect({ |i| i = (i / 999) * 12; a.calc(i) }).plot



