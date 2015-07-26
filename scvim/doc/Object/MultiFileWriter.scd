
	
	
	
	
	SuperCollider helpfile: MultiFileWriter
	

    
    
    

	

MultiFileWriter
writes multiple files to disk, and keeps an index of these files.
Inherits from:: Object 

MultiFileWriter writes multiple files to disk, and keeps in index of these files. Additionally, it can zip each file that is written, and bundle them in a tar-ball. This class uses the programs tar and gzip for the bundling and compression. The interface is written so that you can use this class easily instead of another file-writing class, since any methods that are not known by this class, are forwarded to the class used for writing the single files.

Creation / Class Methods


*new(fn)
Create a new instance.
fn
The basic filename to use. MultiFileWriter checks the path of this filename for its extension (this will be the extension used for the individual files), for the base file name (without extension), this is used as the basic filename for each individual file; individual files will have a sequential index number and a timestamp added to the filename. Finally it checks for the folder in which it lives. If the folder is not empty, it will create a folder with the same basename, and use this folder to put files into.






Accessing Instance and Class Variables


open
Open a new individual file. This adds the new file name to the index file.

close
Close an individual file. This will move the newly written file to the directory, zip the file (if zipSingle is true), and create a new bundle (if tarBundle is true).

fileClass_
  
fileClass
The fileclass to use for writing the individual files (default TabFileWriter).

zipSingle_
  
zipSingle
Whether or not to compress the individual files with gzip.


tarBundle_
  
tarBundle
Whether or not to create tar-bundles of the file collection (default is true).


fileName
The base filename.

extension
The file extension.

pathDir
Directory in which we are writing.



createTarBundle(newf)
Creates a tar bundle. This is called internally.

curfn
Filename that is currently written to.

curFile
Instance of the current file being written to.

index
Current file index.

doesNotUnderstand(selector,args)
Forwards any methods (e.g. writing data to the file) to the fileClass.



 Example 1 - zip and bundle
    
m = MultiFileWriter.new( "testfile14.txt");

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
 Example 2 - don't zip and bundle 
    
m = MultiFileWriter.new( "testfile13.txt");
m.zipSingle = false;
m.tarBundle = false;

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

This helpfile was created with the class HelpFile2
 
