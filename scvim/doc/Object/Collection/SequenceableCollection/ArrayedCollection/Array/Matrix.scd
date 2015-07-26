
Matrix
Superclass: Array

original class by sc.solar

Matrices are 2-dimensional Arrays whose slots may only contain (at the moment 'real' ) numbers.
Their shape is fully described by the number of rows and columns(cols). Each element can be
adressed by 2 indices (row,col), where row (col) ranges between 0 and rows-1 (cols-1).
For a lesson on matrices, read your math books from school.
Or this reference if you like it the hard way:
	http://www.ee.ic.ac.uk/hp/staff/dmb/matrix/intro.html#Intro

Array2D
Matrix uses an array-of-rows–notation. This is the same concept as found in [Array2D].
As a subclass of Array, Matrix responds to far more methods than given in
this helpfile. Be aware of strange results when using them. This is meant to support only the basic matrix
manipulations. Most of this is not designed for realtime action. To slow, not optimized.

Suggestions, bugs, improvements to 
	sc.solar(at)studiobeige.de or 
	tboverma(at)techfak.uni-bielefeld.de


Class Methods

*newClear(rows, cols)
	Create a new Matrix of shape (rows, cols) filled with zeros. 
	
	Matrix.newClear(3,3).postln;

*with(array)
	Create a new Matrix whose rows are filled with the given subarrays. 

	Matrix.with([[1,2,3],[4,5,6],[7,8,9]]).postln;

*withFlatArray( rows, cols, array)
	Create a new Matrix from a 1-dimensional array of shape (rows , cols).
	
	Matrix.withFlatArray(3,3,[1,2,3,4,5,6,7,8,9]).postln;

*newIdentity(n)
	Create a new identity matrix of shape (n,n).
	
	Matrix.newIdentity(3).postln;

*fill (rows, cols, function)
	fill the matrix by evaluating function.
	function is passed two arguments: row, col
	
*mul(ArrayA, ArrayB)
	a = [[1,2],[3,4]];
	b = [[1,2],[1,2]];

	Matrix.mul(a,b);

Instance Methods

rows
	returns the number of rows

cols
	returns the number of columns

shape
	returns the number of rows and columns as array [rows, cols]

postmln
	post the matrix as 2D representation.
	
	Matrix.withFlatArray(3,3,[1,2,3,4,5,6,7,8,9]).postln;
	Matrix.withFlatArray(3,3,[1,2,3,4,5,6,7,8,9]).postmln;

doRow (row, function)
	evaluate function for each element of row;
	function is passed two arguments: item, col

doCol (col, function)
	evaluate function for each element of col;
	function is passed two arguments: item, row

doMatrix (function)
	evaluate function for each element ;
	function is passed three arguments: item, row,col;


Changing Matrices:

put (row, col, value)
	put a single element at (row, col)

putRow (row, values)
	put a row of elements at (row)

	Matrix.newClear(3,3).putRow(0,[2,4,6]).postln

putCol (col, values)
	put a column of elements at (col)
	
	Matrix.newClear(3,3).putCol(1,[2,4,6]).postln

fillRow (row, function)
	fill a row by evaluating function for each element;
	function is passed two arguments: row, col.

fillCol (col, function)
	fill a column by evaluating function for each element;
	function is passed two arguments: row, col.

exchangeRow (rowA, rowB)
	exchange two rows

exchangeCol (colA, colB)
	exchange two cols


Return Arrays:

at (row, col)	
get (row, col)
	returns element at (row,col)

getRow (row)
	returns an array from row 

getCol (col)
	returns an array from column 

getDiagonal
	returns an array from the diagonal elements 

asArray
	returns an array of rows

flat
	returns a one slot array of all elements


Return  Matrices:

fromRow (row)
	returns a new matrix from row

fromCol (col)
	returns a new matrix from column

addRow (values)
	add a row (values) to the matrix and return.
	receiver is unchanged.

addCol (values)
	add a column (values) to the matrix and return.
	receiver is unchanged.
 
insertRow (col, values)
	insert a row (values) in matrix and return.
	receiver is unchanged.

insertCol (row, values)
	insert a column (values) in matrix and return.
	receiver is unchanged.
 
removeRow (row)
	returns a new matrix without row

removeCol (col)
	returns a new matrix without column

collect (function)
	returns a new matrix by evaluating function for each element.
	function is passed three arguments: item, row, col.

sub (row, col)
	returns a submatrix that results from matrix by crossing out row and  col

flop 
	returns the transpose of matrix

adjoint
	returns the adjoint or adjugate of a square matrix

inverse
	returns the inverse of a square matrix

gram
	returns the gram matrix
	(the transpose of matrix multiplied with matrix)
		T^t * T
psydoInverse
	returns the psydoinverse of a matrix

* matrix2
	returns the result of matrix multiplication: matrix * matrix2
	matrix.cols must equal matrix2.rows

* aNumber
	returns multiplication with aNumber for each element

+ matrix2
	returns (matrix + matrix2)
	matrix must have the same shape as matrix2

+ aNumber
	returns summation with aNumber for each element

- matrix2
	returns (matrix - matrix2)
	matrix must have the same shape as matrix2

- aNumber
	returns subtraction with aNumber for each element

center(mean)
	returns a matrix centred around the mean vector (which will be calculated for you if not supplied)

Return characteristic values

sum
	returns the sum of all elements

sumRow (row)
	returns the sum of all elements of desired row
sumCol (col)
	returns the sum of all elements of desired column
sumRows(function)
	return an array giving the sum for every row
sumCols(function)
	return an array giving the sum for every column
	
grammian
	returns the grammian of a  matrix
	(determinant of the gram matrix)

mean
	returns the mean array, calculated over the rows
cov(mean)
	returns the sample covariance, if rows represent observations
covML(mean)
	returns the Maximum-Likelihood covariance estimate, if rows represent observations and the distribution is assumed to be Gaussian


Return characteristic values of square  matrices:

det 
	returns the determinant

cofactor (row, col)
	returns the cofactor to element (row, col)
	this is the determinant of the matrix.sub(row, col) mutiplied with (-1)**(row+col)

trace
	returns the trace of matrix:
	(sum of the diagonal elements)

norm
	returns the euclidean norm of matrix
	( sqrt( tr [ A*A(T) ] ) )


testing

isSquare
	returns true for (n x n) - matrices

isSingular
	returns true if determiant is zero

isRegular
	returns true if determiant is Non-zero

isSymmetric
	returns true if matrix is symmetric

isAntiSymmetric
	returns true if matrix is antisymmetric

isPositive
	returns true if matrix is strictly positive

isNonNegative
	returns true if matrix is  positive / non negative (zeros allowed)

isNormal
	returns true if matrix is  normal

isZero
	returns true for a zero matrix

isIntegral
	returns true if matrix is integral
	An Integral matrix is one whose elements are all integers. 

isIdentity
	returns true if matrix is an identity matrix
	(the diagonal elements are all 1; the nondigonal elements are all zero)

isDiagonal
	returns true if matrix is diagonal
	a(i,j)=0 unless i=j. 

isOrthogonal
	returns true if matrix is orthogonal
	(the matrix multiplied with its transpose is an identity matrix)

isIdempotent
	returns true if matrix is idempotent
	(the squared matrix equals itself)

== matrix2
	returns true if matrix equals matrix2


unary operators: matrix.uop

neg, bitNot, abs, ceil, floor, frac, sign, squared, cubed, sqrt, exp, reciprocal;
	returns new matrices.


binary operators: 
usage: 	matrix  		bop  aNumber
or: 		aNumber 	bop matrix

 /, div, %, **, min, max;
	returns new matrices.



