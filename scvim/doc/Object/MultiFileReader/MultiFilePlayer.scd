
	
	
	
	
	SuperCollider helpfile: MultiFilePlayer
	

    
    
    

	

MultiFilePlayer
reading back multiple files as created by MultiFileWriter with a FilePlayer
Inherits from:: Object : MultiFileReader 

This class allows you to read back files that you created with MultiFileWriter. It reads the files back with a (subclass of) FilePlayer, thus allowing to read any data from any line out of any file.

See also: MultiFileWriter, 
MultiFileReader, and
FilePlayer


Creation / Class Methods


*new(fn,fc)
Create a new instance.
fn
The filename, this is either the path to the tarfile, or to the folder containing all files.
fc
The fileClass to use for reading the individual files (default TabFilePlayer). This must be a (subclass of) FilePlayer.






Accessing Instance and Class Variables


readAtLine(line)
Read at (cumulative) line number line

readAtLineInterpret(line)
As readAtLine, but interpret the result.

readAt(line,fileid)
Read from file with fileid, at line number line

readAtInterpret(line,fileid)
Read from file with fileid, at line number 
line, and interpret the result (element by element).


makeGui
Create a MultiFilePlayerGui for this MultiFilePlayer.


fileClass_


fileClass
The Class used to open the individual files; this has to be a FilePlayer, or one of its subclasses.


headerSize_


headerSize
Size of the file header (data labels).

readHeader(fileid, hs)
Read the header of file fileid. hs will set the headerSize.

lineMap
A map of which cumulative line index is at the start of which file. Used internally.


currentLine
Get the current line we are at, adjusted for the header size.

goToLine( lineid )
Go to the specified line.






 Example 1 
    
m = MultiFileWriter.new( "testfile15.txt");

Task({

    3.do{
        m.open;

        20.do{
            m.writeLine( Array.fill( 10, { 1.0.rand }));
            0.25.wait;
        };
        m.close;
        
        1.0.wait;
    };
    "done".postln;
    
}).play;

n = MultiFilePlayer.new( "testfile15.tar");

n.readAt( 4, 2 );

n.readAt( 10 , 2 );

n.readAt( 2, 0 );

n.readAt( 4, 1 );

n.closeFile;

n.close;

This helpfile was created with the class HelpFile2
 
