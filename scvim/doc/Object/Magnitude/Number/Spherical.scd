
Spherical 			spherical coordinates

superclass: Number

Represents spherical coordinates.
Part of SpherCoords, a spherical and 3D cartesian coordinate support library.


See also: Cartesian, Point, Polar

Credits: Joseph Anderson, 2011 [j.anderson[at]ambisonictoolkit.net]

Creation

new(rho, theta, phi)

Create a new spherical coordinate with the given radius, rho, and angles in radians, theta and phi.


Accessing

rho

Get the rho coordinate value.

theta

Get the theta coordinate value.

phi

Get the phi coordinate value.

rho_(aValue)

Set the rho coordinate value.

theta_(aValue)

Set the theta coordinate value.

phi_(aValue)

Set the phi coordinate value.


Math

+   -   *   /

The math operations of addition, subtraction, multiplication and division are accomplished by
first converting to cartesian coordinates, then answering to spherical coordinates.

scale(aNumber)

Scale the radius by some value.

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

neg

Rotate theta by pi and negate phi. This operation is equivalent to negating rho, and is a synonym for mirrorO.


Conversion
magnitude

Answer the radius.

angle

Answer the azimuth angle, theta, in radians.

phase

Answer the azimuth angle, theta, in radians.

angles

Answer the azimuth and elevation angles, theta and phi, in radians. Returns: [ theta, phi ]

phase

Answer the azimuth and elevation angles, theta and phi, in radians. Returns: [ theta, phi ]

x

Answer the cartesian coordinate x of the receiver.
y

Answer the cartesian coordinate y of the receiver.

z

Answer the cartesian coordinate z of the receiver.
real

Answer the cartesian coordinate x of the receiver.

imag

Answer the cartesian coordinate y of the receiver.

asSpherical

Returns the receiver.

asPolar

Convert to Polar, discarding z.

asComplex

Answers a Complex with x as the real part and y as the imaginary part, discarding z.

asPoint

Convert to Point, discarding z.

asCartesian

Convert to Cartesian.


