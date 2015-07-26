
	
	
	
	
	SuperCollider helpfile: FilePlayer
	

    
    
    

	

FilePlayer
reads space-delimited text files at specific lines.
Inherits from:: Object : AbstractFunction : Stream : FileReader 

FilePlayer is an enhanced version of FileReader, allowing to jump to specific lines in the file.Subclasses: TabFilePlayer, CSVFilePlayer, SemiColonFilePlayer.See also: FileReader

Creation / Class Methods


*new(pathOrFile,skipEmptyLines,skipBlanks,delimiter)
Create a new instance. For a description of arguments, see FileReader



Accessing Instance and Class Variables


next
Read the next line.

nextInterpret
Read the next line and interpret the result (element by element). Note: this is an extension to FileReader, so it can be used in that class too.

readAtLine(line)
Read at the given line number

readAtLineInterpret(line)
Read at the given line number, and interpret the result (element by element)


readAt(line)
Read at the given line number. Alternative for readAtLine. The difference between readAt and readAtLine is when substituting this class with a MultiFilePlayer instead; if you intend to make code that translates without code changes between the two, use readAtLine instead.

readAtInterpret(line)
Read at the given line number, and interpret the result (element by element). Alternative for readAtLineInterpret.


goToLine(line)
Go to the given line (this does not read the line)

readHeader(hs)
Read the header of the file. hs is the headerSize.

headerSize_


headerSize
Size of the file header (data labels); this is the number of lines that make up the header.

makeGui
Create a FilePlayerGui for this FilePlayer.


currentLine
The current line where we are in the file.

length
Length of the file

reset
Reset the stream. I.e. go to the start of the file.

setCurrentLine(cl)
Set the current line number (used internally)

lineMap
A map of which cumulative line index is at the start of which file. Used internally.



 Example 1 
    
// create a file:
f = TabFileWriter.new( "testfile2.txt", "w", true);

Task({
    20.do{
        f.writeLine( Array.fill( 10, { 1.0.rand }));
        1.0.wait;
    };
    "done".postln;
}).play;

f.close;

// view the file:
"testfile2.txt".openDocument;

// read it with the player:
a = TabFilePlayer.new( "testfile2.txt" );

a.next;

a.readAt( 10 );

a.readAt( 5 );


// returns nil: (no more lines)
a.readAt( 20 );

// close the file
a.close;


This helpfile was created with the class HelpFile2
 
