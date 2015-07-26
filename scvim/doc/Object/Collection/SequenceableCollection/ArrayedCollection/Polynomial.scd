
Polynomial				various methods for polynomial math operations	

Inherits from: Object : Collection : SequenceableCollection : ArrayedCollection

A class which makes possible various elementary polynomial math operations. Included are arithmetic methods like multiplication and division, (complex) root finding and evaluation at a specific point for arbitrary degree polynomials. All methods should work for real as well as complex coefficients.

Important notes
Note that for all binary arithmetic operations to give valid results, it is necessary that both coefficient arrays are of the same size. This means that in some cases it will be necessary to pad a coefficient array with zeros until it matches the other coefficient array in size. See the '/' operation for an example.


Creation / Class Methods

	*new(coefs)
	
		Creates a new instance of Polynomial. Returned is a polynomial of a degree equal to the number of coefficients minus one. The coefficients need to be supplied in increasing order: 
		a_0, a_1, a_2 ... a_n-1, a_n
		
		Polynomial[1, 2, 1]	//2nd degree polynomial
		Polynomial[0, 2, 1]	//Another 2nd degree polynomial with a_0 coefficient equal to 0
		Polynomial[1, 2, 0]	//1st degree polynomial, since a_2 coefficient is 0
			
	*expandBinomialFactors(binomials)

		Expands an array of first degree binomial factors.
		
		a = Polynomial[2, 2];
		b = Polynomial[3, 3];
		c = Polynomial[4, 4];

		Polynomial.expandBinomialFactors([a, b, c])
		

Instance Methods
	
	* (polynomial)
		
		Calculate the product of two polynomials by convolving the original coefficient sequences.
		
		Polynomial[1, 2, 3, 4, 5] * Polynomial[5, 4, 3, 2, 1];
		
		//Complex example
		a = Polynomial[Complex(2, 2.2), Complex(2.5, 5), Complex(7, 4)];
		a * a.performUnaryOp('conjugate');

	/ (polynomial)
		
		Divide two polynomials using synthetic division. Returned is an Array containing the remainder in the first slot and the quotient in the second slot, where: P(z)  / D(z) = Q(z) + R(z) / D(z)
		The degree of the numerator polynomial needs to be greater than or equal to the degree of the denominator polynomial.
		
		a = Polynomial[Complex(2, 1), Complex(0.2, -0.436), Complex(-1.9, -5)];
		b = Polynomial[Complex(-5, 4), Complex(3.5, 1.2)];
		#r, q = a / b;

		(b * q) + r.addAll([0, 0]);		//Check if we get back the original polynomial and notice 									//padding of the remainder in order to get a valid result

	pow(n)
		
		Calculate the n'th power of a polynomial. Negative, complex or fractional powers are allowed for binomials with the a_0 coefficient equal to one in order to calculate the binomial series which converges for:  |z| < 1
		
		Polynomial[1, 1].pow(0.5)		//Binomial series: (1 + x)^0.5

	eval(z)
		
		Evaluate the polynomial at the (complex) point z.
		
		Polynomial[0.2, 0.1, 0.3, 0.5].eval(1.0);
		
	evalDerivs(z)
		
		Evaluate the polynomial and all of its derivatives at the (complex) point z. Returned is an Array containing the results. Slot zero contains the function value and subsequent slots are filled with the values of all existing derivatives.
		
		Polynomial[0.2, 0.1, 0.3, 0.5].evalDerivs(1.0);
		
	findRoots(method)
	
		Find all the roots of the polynomial. The argument 'method' defaults to \laguerre, which works for polynomials  with real as well as complex coefficients. Another option is to use the method \eigenvalue to form the companion matrix which eigenvalues coincide with the roots of the polynomial. Although this method is more reliable than the first one, it is considerably slower and only works for polynomials with real coefficients. 
		
		a = Polynomial[80, 4, -24, -1, 1];
		b = a.findRoots;
		
		//Check if the roots we found make sense
		c = ([b.neg, [1, 1, 1, 1]].lace(8).reshape(4, 2).collect(_ .as(Polynomial)));
		Polynomial.expandBinomialFactors(c)		
		
	degree
	
		Returns the degree of the polynomial.
		
		Polynomial[0, 2, 0, 0, 6, 0, 0].degree;
		
	isMonomial
	
		Returns 'true' if the polynomial is a monomial.
		
		Polynomial[0, 0, 2, 0, 0].isMonomial;
		
	isBinomial
		
		Returns 'true' if the polynomial is a binomial.
		
		Polynomial[0, 2, 0, 0, 6].isBinomial;
	
Examples



// Example showing two alternative methods for dividing polynomials

a = Polynomial[2, 3, 4, 1];		// P(x) = 2 + 3*x + 4*x^2 + x^3
b = Polynomial[4, 5, 6, 0];		// P(x) = 4 + 5*x + 6*x^2

// First example: remainder and quotient are of the same order (standard behaviour)
#r, q = a / b;
// Get back original polynomial
(b[0..b.size-2] * q.add(0)) + r.addAll([0, 0]);

// Second example: quotient contains powers x^0 up to x^k and remainder starts from power x^(k+1)
b = b.insert(0, b.removeAt(b.size-1));
// We need to reverse the coefficients so that the powers are in increasing order again
#r, q = (a.reverse / b.reverse).performUnaryOp('reverse');
// Adjust degree of the remainder (must be 3rd degree in this case)
q.size.do({ r = r.insert(0, 0) });
// Get back original polynomial
(b[1..b.size-1] * q.add(0)) + r


