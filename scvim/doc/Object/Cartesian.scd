
Cartesian		Cartesian point in 3D space
Superclass: Object

Defines a point in 3D Cartesian space.

Part of SpherCoords, a spherical and 3D cartesian coordinate support library.


See also: Spherical, Polar, Point

Credits: Joseph Anderson, 2011 [j.anderson[at]ambisonictoolkit.net]


Creation

new(inX, inY,inZ)

Defines a new Cartesian point.


Accessing

x

Get the x coordinate value.

y

Get the y coordinate value.

Z

Get the y coordinate value.

x_(aValue)

Set the x coordinate value.

y_(aValue)

Set the y coordinate value.

z_(aValue)

Set the z coordinate value.

set(inX, inY,inZ)

Sets the Cartesian point x, y and z values.

Testing

== aPoint

answers a Boolean whether the receiver equals the argument.

hash

returns a hash value for the receiver.


Math

+ aCartesianOrPointOrScalar

Addition.

- aCartesianOrPointOrScalar

Subtraction.

* aCartesianOrPointOrScalar

Multiplication.

Returns: Cartesian.new(this.x * scale.x, this.y * scale.y, this.z * scale.z)

Note that the result of * for a 3D Cartesian point does not match that of Point, where the result is interpreted as the multiplication of complex numbers.


/ aCartesianOrPointOrScalar

Division.

Returns: Cartesian.new(this.x / scale.x, this.y / scale.y, this.z / scale.z)

Note that the result of / for a 3D Cartesian point does not match that of Point, where the result is interpreted as the division of complex numbers.

translate(aCartesian)

Addition by a Cartesian

scale(aCartesian)

Multiplication by a Cartesian.

rotate(aNumber)

Rotation about the origin in the XY plane by the angle given in radians.
tilt(aNumber)

Rotation about the origin in the YZ plane by the angle given in radians.
tumble(aNumber)

Rotation about the origin in the XZ plane by the angle given in radians.
rotateXY(aNumber)

A synonym for rotate.
rotateYZ(aNumber)

A synonym for tilt.
rotateXZ(aNumber)

A synonym for tumble.

mirrorX

Mirror x, reflecting across the YZ plane.

mirrorY

Mirror y, reflecting across the XZ plane.

mirrorZ

Mirror z, reflecting across the XY plane.

mirrorO

Mirror across the origin.

abs

Absolute value of the point.

rho

Return the spherical coordinate radius of the receiver.

theta

Return the spherical coordinate azimuth angle of the receiver.

phi

Return the spherical coordinate elevation angle of the receiver.

angle

Return the spherical coordinate azimuth angle of the receiver.

angles

Return the spherical coordinate azimuth and elevation angles of the receiver.

dist(aCart)

Return the distance from the receiver to aCart.

transpose

Return a Cartesian point whose x and y coordinates are swapped.

Discussion: Matches the return value for Point.transpose.

transpose

Return a Cartesian point whose x and y coordinates are swapped.

Discussion: A synonym for transpose.

transposeYZ

Return a Cartesian point whose y and z coordinates are swapped.

transposeXZ

Return a Cartesian point whose x and z coordinates are swapped.

round(quantum)

Round the coordinate values to a multiple of quantum.

trunc(quantum)

Truncate the coordinate values to a multiple of quantum.


Conversion

asCartesian

Returns the receiver.

asPoint

Returns a Point, discarding z.

asComplex

Returns a Complex with x as the real part and y as the imaginary part, discarding z.

asPolar

Returns a Polar, discarding z.

asSpherical

Returns a Spherical.

asArray

Returns an Array: [ x, y, z ]



