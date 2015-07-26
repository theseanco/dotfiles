
Quaternion

/*




*/

Quaternion(1, 1, 1, 1) * Quaternion(1, 1, 1, 1);


a = Quaternion(1, 1, 1, 1);
a.conjugate;
a.conjugate.conjugate;


b = Quaternion.rand(-10, 10);
c = Quaternion.rand(-10, 10);

norm(b * c) == (norm(b) * norm(c)); // true

b.reciprocal.reciprocal == b; // true



i = Quaternion(0, 1, 0, 0);
j = Quaternion(0, 0, 1, 0);
k = Quaternion(0, 0, 0, 1);

(i * i) == (j * j) // true



