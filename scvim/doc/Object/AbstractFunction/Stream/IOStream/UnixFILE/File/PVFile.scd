
PVFile			reads and prepares data from CSounds pvanal program

Inherits from: Object : AbstractFunction : Stream : IOStream : UnixFILE : File

See also: PVSynth, PVInfo

Some Important Issues Regarding PVFile

This currently only works with .pv files. .pvx and CSound 5 files will be implemented soon.

Creation / Class Methods

	*new (path, server)

		a = PVFile.new("sounds/cl-c4.pv", s);	

		path - path to a CSound pv file
		server - The server that data will be loaded on to. Defaults to Server.default
		

	*load (path, server)
	
		Read and load directly to the server.

Accessing Instance and Class Variables
	
	minFreq
		
		From the header, the lowest freq analyzed.

	maxFreq

		From the header, the highest freq analyzed.

						
	sndDur
		
		The duration of the sound file analyzed
				
	header
		
		Returns the pv file's header. (well... most of it).
				
	nFrames
		
		The number of frames in the analysis

	nBins
		
		The number of bins in the analysis
								
	buffer
		
		The buffer number where PVFile stores data to a server
	data
		
		An array showing the data form the pv file
				

	saveForSC (path)
	
		To use NRT - you must re-write the data file out as a sound file!
		path - The path to save the soudfile to. This can then be allocRead 'd into a Score.

	loadToBuffer (buf)
	
		Load pc data to a buffer for real-time performance. 
		buf - A buffer to load to. If nil, one is allocated for you.

	freeBuffer
	
		liberates the buffer from SuperCollider tyranny.

	getBinFreqs (bin)
	
		Returns an array of freqs of nFrames length for bin.

	getBinMags (bin)
	
		Returns an array of mags of nFrames length for bin.

	getFrameFreqs (frame)
	
		Returns an array of freqs of nBins length for a given frame
		
	getFrameMags (frame)
	
		Returns an array of mags of nBins length for a given frame

	magScale
	
		A (possibly vain) attempt to figure out an appropriate amplitude to scale the output of PVSynth by. 
		Returns the reciprocal of the average of all mags times the number of bins.
		
		(mags.flat.mean * nBins).reciprocal


