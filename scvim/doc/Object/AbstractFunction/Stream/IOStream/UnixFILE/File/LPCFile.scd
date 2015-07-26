
LPCFile			For working with CSounds LPC file data


Working with LPC files

This class acts as a bridge between CSound's LPC analysis files created with the lpanal command line tool. 

Class Methods

Loading an LPC file with LPCFile

*new(path, buffer, server) - load an LPC file into memory at path with buffer number bufnum.  server defaults to Server.default. If bufnum is left empty, one will be allocated for you.

	a = LPCFile.new("sounds/fate.lpc");
	
Instance Methods

loadToBuffer - loads the information of the LPC file into a buffer for use by the LPCSynth UGens

	a.loadToBuffer;
	
buffer -  returns the buffer number LPC data is stored in.

freeBuffer - releases the LPC buffer.



