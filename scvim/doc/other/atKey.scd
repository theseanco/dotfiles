
	
	
	
	
	SuperCollider helpfile: NPdef
	

    
    
    

	

atKey
access one key in another Pattern.


atKey allows you to access one key in another Pattern, i.e. PatternProxy (e.g. Pdef), Pbind and Pchain.



 Example

    
s.boot;
Pdef( \one, Pbind( \degree, Pseq( (1..7), inf ), \dur, 1, \pan,-1 ) );

Pdef( \two, Pbind( \degree, Pdef(\one).atKey(\degree), \dur, 1, \pan, 1) );

Pdef( \one ).play; Pdef( \two ).play;

// now change the first one:
Pdef( \one, Pbind( \degree, Pseq( [1,3,5,7,5,3], inf ), \dur, 1, \pan, -1) ) ); // the second one still has the previous pattern

Pdef( \two, Pbind( \degree, Pdef(\one).atKey(\degree), \dur, 1, \pan, 1 ) ); // now it has the same pattern at one again

Pdef( \one).stop;
Pdef( \two).stop;




