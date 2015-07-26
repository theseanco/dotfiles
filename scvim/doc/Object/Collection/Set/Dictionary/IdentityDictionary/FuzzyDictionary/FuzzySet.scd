
FuzzySet			random lookup dictionary with singular elements

superclass: FuzzyDictionary




put(key, obj)		put an object into the dictionary. If there is already an object at that
				key, the new object is added to the list of choices. If the object exists already somewhere
				in the set at a certain key, it is removed there.


at(key)			retrieve an object at a key. 
				If there is several, one of them is chosen at random.
				

removeAt(key, obj)		remove an object from a certain key. 
				If there is several of the same kind, only one is removed

remove(obj)		remove an object from the set.


replace(obj, by)	replace an object by another one at the same key.


choose 			choose a key from all possible keys and then choose an object from it


doAt(key, function)
				iterate over all elements at a certain key


keyAt(key)		return the list of objects at a certain key






// example
a = FuzzySet.new;

// put the letters from a to j into the dictionary under their index
"abcdefghij".do { |c, i| a.put(i, c) };

a.postcs;

a.at(0);
a.removeAt(0, $a);

a.at(0)
a.at(1);


// now put the letters from l to u into the same indices
"lmnopqrstu".do { |c, i| a.put(i, c) };

// now at a certain index there is two objects, getting chosen at equal distribution
10.do { a[0].postln }; 

a[0] = 1000; // this could be any object.

10.do { a[0].postln }; 



// in difference to FuzzyDictionary, adding one object again, will remove the old one.

a[4] = $a;

10.do { a[0].postln }; // only "l" is left
10.do { a[4].postln }; // "a" is here






