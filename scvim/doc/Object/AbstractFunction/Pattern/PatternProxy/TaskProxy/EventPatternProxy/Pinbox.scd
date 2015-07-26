

a = Pinbox(\pat1);
b = Pinbox(\pat2);
c = Pinbox([\pat2, \pat1]);



Pdef(\x, Pn(a).trace).play;

Pdef(\x).set(\news, nil);
Pdef(\x).set(\news, (pat1: Pbind(\degree, Pseq([0, 4, 3], 2))));
Pdef(\x).set(\news, (pat1: Pbind(\degree, Pseq([0, [3, 4], 3], 2), \instrument, \sine)));

(
Pdef(\x).set(\news, (pat1: Ppar([ 
	Pbind('degree', Pseq([ 0, [ 3, 4 ], 3 ], 2), 'instrument', 'sine'), 
	Pbind('degree', Pseq([ 0, [ 3, 4 ], 3 ], inf), \dur, 0.34, 'instrument', 'sine') 
	], 1)))
);


Pdef(\x, Pn(c));
