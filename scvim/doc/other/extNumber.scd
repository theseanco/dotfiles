
extNumber 			extension to Number

Extension to Number to support spherical and 3D cartesian coordinates.
Part of SpherCoords, a spherical and 3D cartesian coordinate support library.


See also: Cartesian, Spherical, Point, Polar

Credits: Joseph Anderson, 2011 [j.anderson[at]ambisonictoolkit.net]


Conversion

@ (aValue)

If aValue is Number, create a new Point whose x coordinate is the receiver and whose y coordinate is Number. If aValue is a Point, create a new Cartesian whose x coordinate is the receiver, y coordinate is aValue.x and z coordinate is aValue.y.
spherical (theta, phi)
Create a new Spherical number whose radius is the receiver with the given azimuth and elevation angles.
asCartesian
Create a new Cartesian number whose x, y and z is the receiver.

Spherical Coordinate Support
rho
Answer the spherical radius of the number.
theta
Answer the spherical azimuth angle of the number, 0.
phi
Answer the spherical elevation angle of the number, 0.


