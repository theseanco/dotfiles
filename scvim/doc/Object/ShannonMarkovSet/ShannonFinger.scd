
ShannonFinger				shannon implementation of a markov set

superclass: ShannonMarkovSet


The basic shannon implementation of a markov set is to simply leave the data as it is and to
iterate over it by doing random jumps and looking for the next matching item. The item that
follows that one is the next item of the chain. As this requires searching the data, which can
be of very irregular efficiency, this current implementation uses an identity dictionary to find
the indices of items in constant time. Higher order is slightly more costly, but still this is a major
speed increase.

This implementation allows to vary the order at each step and it is very fast in reading.
In difference to MarkovSet and MarkovSetN it can only read data as a chain, not as single nodes. 
Also it does not compress data, as the standard implementation does.


instance creation:


	*new(size)
	*fill(size, stream)
		


instance methods:
	
	next(obj, order)
		return the next node for the input obj, using nth order (default = 1)
		
	put(index, obj)
		put object in the data at index i
		
	wrapPut(index, obj)
		wrapPut object in the data at index i
		
	parse(stream, length)
		read length items of stream
		
	asStream(order, repeats)
		return a stream that reads from this set.
		order can be any object that returns a stream on .asStream, returning integers.





setting the data

m = ShannonFinger(16); // create a new instance with 16 slots.

"abc".do { |item,i| m.put(i, item) }; // fill the first 3 slots

m.data; 

"abcdefghij".do { |item,i| m.put(i, item) }; // fill all 10 slots

m.data; 

// fill the set directly:

m.data = "abcdefghij";

// setting higher indices throws an error:

m.put(20, $x);

// wrapPut:

m.wrapPut(20, $x);
m.data;


using the set with the message 'next'


m.next($b); // returns c.
m.next($c); // returns d

// now put a "c" at index 8:

m.put(8, $c);
m.data;

// generate some output on basis of c:

10.do { m.next($c).postln }; // returns sometimes j and d



generating a stream:



// crete a new, independent stream from m:
x = m.asStream;
60.do { x.next.post; Char.tab.post }

// whenever there is no next (at the last index), a random index is chosen
// to notify of this, set notify to true:

m.notify = true;



// minimal test:
m.data = (0..20);
m.next(2);
m.next(3);
m.data
m.lookUp;


x = m.asStream;
60.do { x.next.post; Char.tab.post }

// minimal test:
m.data = "abcdefghij";
m.next($a);
m.next($i);
m.data
m.lookUp;
m.put(0, $x);

x = m.asStream;
60.do { x.next.post; Char.tab.post }



// with stream

m = ShannonFinger.fill(30, Pseq([1, 2, Prand([3, 7])],inf).asStream);
m.data
m.lookUp;
x = m.asStream;
60.do { x.next.post; Char.tab.post }

SynthDescLib.read;

// listen to the set
(
Pbind(
	\degree, Pn(x),
	\dur, 0.25
).play;
)

// change the data slowly

m.parse(Pseq([1, 2, Prand([6, 9], 2)], inf), 20);
m.parse(Pseq([1, 5], inf), 20);
m.parse(Pseq([5, 0, -2], inf), 20);
m.data = [3, 4, 5, 4, 5, 6];
m.data







