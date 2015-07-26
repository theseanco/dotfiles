
MarkovSetN				nth order markov set

superclass: LookupMarkovSet

constant order set. for variable order see ShannonFinger
uses an optimized identity lookup in which arrays of elements are stored internally as symbols.


instance creation:


	*new(args, order,  updateSeeds)
		
		
		args
			a list of arrays that each represent 
			one node in the set:
			[[array_of_elements], [next_elements], [weigths]]
			
			array_of_elements
				should be of size 'order'.
			
			next_elements
				the next node is searched by simple equality.
				if nil, this is a terminator node
			weights
				the array is normalized.
				if weigths is nil, equal weight is used
			
			if args is nil, the set is created and may be trained by the 
			other methods.
		
		order
			the order of the set.
		
		updateSeeds
			if set to true, each element is always added to the seeds.


	*fill( n, stream, order ) 
	
		
		n			number of items to read
		stream		a function or stream that returns items to read
		order		order of the new set
	
	
	
other methods see superclass MarkovSet



// direct node definition
(
m = MarkovSetN([
			[[100, 120], [120, 130]],
			[[120, 100], [100, 1900]]
		], 2);
)

8.do { m.next([100, 120]).postln };
8.do { m.next([120, 100]).postln };

// training by a stream

m = MarkovSetN.fill(100, Pseq([1, 2, 3, 4, Prand([5, 55, 555])], inf).asStream, 2);
8.do { m.next([1,2]).postln };
8.do { m.next([3,4]).postln };
8.do { m.next([4,5]).postln };





		


