
//shannon markov






a = ShannonMarkovSet.new(800);
s = Pseq([0,1,2,3]+10,inf).asStream;
(
120.do({ arg i;
	a.put(i,s.next)
})
);


v = a.asStream(3);
10.do({ v.next.postln });

a.next(11).postln;

a.data

x = 5;
a.nextIndex(x).postln;

// empty set test.

a = ShannonMarkovSet(256);
a.chooseIndex.postln;
a.nextIndex(0).postln;
v = a.asStream(8,1);
v.next.postln;


