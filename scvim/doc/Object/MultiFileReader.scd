
	
	
	
	
	SuperCollider helpfile: MultiFileReader
	

    
    
    

	

MultiFileReader
reading back multiple files as created by MultiFileWriter.
Inherits from:: Object 

This class allows you to read back files that you created with MultiFileWriter.

See also: MultiFileWriter 
and MultiFilePlayer


Creation / Class Methods


*new(fn,fc)
Create a new instance.
fn
The filename, this is either the path to the tarfile, or to the folder containing all files.
fc
The fileClass to use for reading the individual files (default TabFileReader)






Accessing Instance and Class Variables


next
Read the next line in the files

nextInterpret
Read the next line in the files and interpret


openFile(ind)
Open a file from the bundle.
ind
The id of the file (the line at which it occurs in the index file)



fileClass_


fileClass
The Class used to open the individual files.


reset
Go back to the beginning of the first file.


closeFile
Close the individual file.


close
Close the index file, and any open current file.


skipToNextFile
Skips to the next file.

tarBundle
Whether or not we are reading from a tarfile.

zipSingle
Whether the single files are zipped. This is detected from the index file.



openIndexFile
Opens the index file (called automatically from new).

readIndexLine( ind )
Reads the line ind and returns the result.


fileName
The base filename.

pathDir
The base path in which the tarfile or the folder lies.

indexFile
The file instance of the index file

indexfn
The filename of the index file.

curFile
The instance of the currently open file.

curid
ID of the currently open file.





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

n = MultiFileReader.new( "testfile15.tar");

n.next;
n.next;
n.next;

// MultiFileReader will automatically jump to the next file, if we
// are at the end of the current file.


// Jump to another file, and continue reading from there:
n.openFile( 2 );
n.next;

n.closeFile;

n.close;

This helpfile was created with the class HelpFile2
 
