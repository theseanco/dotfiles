
extPoint 			extension to Point

Extension to Point to support spherical and 3D cartesian coordinates.
Part of SpherCoords, a spherical and 3D cartesian coordinate support library.


See also: Cartesian, Spherical, Polar

Credits: Joseph Anderson, 2011 [j.anderson[at]ambisonictoolkit.net]

Accessing
z
Answer the cartesian coordinate z of the receiver, 0.
Math
mirrorX
Mirror x, reflecting across Y axis.
mirrorY
Mirror y, reflecting across the X axis.
mirrorO
Mirror across the origin. A synonym for neg.

Conversion

phi

Answers 0.

asCartesian

Convert to Cartesian, with z = 0.
@ (aValue)

If aValue is Number, create a new Cartesian whose x coordinate is this.x, y coordinate is this.y and whose z coordinate is aValue. If aValue is a Point, create a new Rect.


