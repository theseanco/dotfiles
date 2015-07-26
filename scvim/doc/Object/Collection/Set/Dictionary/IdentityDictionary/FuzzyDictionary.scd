
FuzzyDictionary			random lookup dictionary

superclass: IdentityDictionary




put(key, obj)		put an object into the dictionary. If there is already an object at that
				key, the new object is added to the list of choices.


at(key)			retrieve an object at a key. 
				If there is several, one of them is chosen at random.
				

removeAt(key, obj)		remove an object from a certain key. 
				If there is several of the same kind, only one is removed


choose 			choose a key from all possible keys and then choose an object from it


doAt(key, function)
				iterate over all elements at a certain key


keyAt(key)		return the list of objects at a certain key


collect(func)		return a new fuzzy dictionary with the items passed into the func.
				arguments to the func: elem, key, index, listindex	





// example
a = FuzzyDictionary.new;

// put the letters from a to j into the dictionary under their index
"abcdefghij".do { |c, i| a.put(i, c) };

a.postcs;

a.at(0)
a.at(1);

// now put the letters from l to u into the same indices
"lmnopqrstu".do { |c, i| a.put(i, c) };

// now at a certain index there is two objects, getting chosen at equal distribution
10.do { a[0].postln }; 

a[0] = 1000; // this could be any object.

10.do { a[0].postln }; 

// removing an object

a.removeAt(0, 1000);

10.do { a[0].postln }; 




