
Trafo

A geometrical basis.
// Till Bovermann, Uni Bielefeld 2006

[ Creation ]

*new(basis, d)
	creates new Basis from basis Vectors.
	basis 	default:  
		[[1, 0, 0],
		 [0, 1, 0],
		 [0, 0, 1]];
	d		position-vector, default 0.
(
t = Trafo([
	[0, 2, 0], 
	[0, 0, 6], 
	[5, 0, 0]
], [3, 4, 5])
)
t = Trafo.new(d: [0,0,0])

*basicNew(trans)
	creates new Basis from transformation
	
*from3dPoints(a, b, c)
	creates new Basis from 3d Points.
(
t = Trafo.from3dPoints(
	[0, 2, 0], 
	[3, 3, 0], 
	[15, 2, 0]
)
)
/* returns
Trafo.basicNew( Matrix[ 
	[ 0.94868329805051, 0.31622776601684, 0, 0 ],
	[ 0.31622776601684, -0.94868329805051, 0, 2 ],
	[ 0, 0, -1, 0 ],
	[ 0, 0, 0, 1 ]
 ] )
*/

// don't work, since basis is collinear...
t = Trafo.from3dPoints(
	[0, 2, 0], 
	[0, 2, 0], 
	[15, 2, 0]
)

*inverseFrom3dPoints(a, b, c)
	creates new Basis from 3d Points.
(
t = Trafo.inverseFrom3dPoints(
	[0, 2, 0], 
	[3, 3, 0], 
	[15, 2, 0]
);
u = Trafo.inverseFrom3dPoints(
	[0, 2, 0], 
	[3, 3, 0], 
	[15, 2, 0]
);
)

(
{200.do{
	Trafo.inverseFrom3dPoints(
		[0, 2, 0], 
		[3, 3, 0], 
		[15, 2, 0]
	);
}}.bench;
{200.do{
	Trafo.from3dPoints(
		[0, 2, 0], 
		[3, 3, 0], 
		[15, 2, 0]
	).inverse;
}}.bench;
)



[ Accessing ]

rotMatrix
	returns the used rotation matrix
(
t = Trafo.from3dPoints(
	[0, 0, 0], 
	[pi, 3, 0], 
	[15, 2, 0]
);
t.rotMatrix
)
(
t = Trafo.new;
t.rotMatrix
)

basis
	returns the basis vectors as 
	[[x1, x2, x3],[y1, y2, y3],[z1, z2, z3]]
(
t = Trafo([
	[0, 2, 0], 
	[3, 0, 0], 
	[0, 0, 15]
]);
t.basis
)
	
position
	returns the translative part
(
t = Trafo.new;
t.position
)

[ Transforming ]

inverse
	returns new Trafo where (t * t.inverse vmul: v) == v;
	
(
t = Trafo.new;
t.inverse
)

vmul(aVec, scale)
	transforms aVec with scaling scale to the trafo-inherited basis.

t = Trafo.new; // the identity
t.vmul( [1, 0, 0]);
(
{2000.do{
	t = Trafo.new({{1.0.rand}!3}!3, {1.0.rand}!3);
	t vmul: ({1.0.rand}!3)
}}.bench
)

t = Trafo.from3dPoints(
	[0, 0, 0], 
	[pi, 3, 0], 
	[15, 2, 0]
)
t.vmul( [1, 0, 0])


