
	
	
	
	
	SuperCollider helpfile: FileWriter
	

    
    
    

	

FileWriter
easily create files that can be read by FileReader
Inherits from:: Object : AbstractFunction : Stream : IOStream : UnixFILE : File 

With FileWriter, you can create files that can be read by FileReader, and most common spreadsheet programs.
Subclasses: TabFileWriter, CSVFileWriter, SemiColonFileWriter
See also: FileReader, FilePlayer.


Creation / Class Methods


*new(pathName,mode,stamp,del)
Create a new instance of FileWriter
stamp
Whether or not to add a time stamp at the beginning of each line (default false)
del
The delimiter to use (default a space, or rather the classvar delim)
mode
Mode of writing (default "w"). Other useful option could be "a" to append to the file. Since we are writing a textfile, you should not use a binary format. See also File.
pathName
The filename to write to.




*delim
The default delimiter to use (is overridden in the subclasses)



Accessing Instance and Class Variables



writeLine(array)
Write a line to the file.
array
An Array with values to write. The contents of the Array will be written to the file as the compile string of each item, and delimited by the delimiter.



close
Close the file.


delimiter
The current delimiter.
delimiter_
Set the delimiter.

stringMethod
The current stringMethod.
stringMethod_
The stringMethod is the way the data is written to a file
 (default is \asString, other option could be \asCompileString).

timeStamp
Whether or not to add a time stamp at the beginning of each line (default false)
timeStamp_


timebase
  
timebase_
Whether to use local time or greenwich mean time (default: \local, other option: \gm)



 Example 1 
    
f = TabFileWriter.new( "testfile2.txt", "w", true);

Task({
    20.do{
        f.writeLine( Array.fill( 10, { 1.0.rand }));
        1.0.wait;
    };
    "done".postln;
}).play;

f.close;

This helpfile was created with the class HelpFile2
 
