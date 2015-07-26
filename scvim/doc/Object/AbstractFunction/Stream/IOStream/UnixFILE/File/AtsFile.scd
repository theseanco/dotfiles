
AtsFile			For working with ATS file data


Working with ATS files

ATS (Analysis-Transformation-Synthesis) files are analysis files created using Oscar DeLiscia, Juan Pampin and Pete Moss's atsa command-line analysis tool (available at http://www.dxarts.washington.edu/ats). The analysis of the sound first attemps to track and record frequency data into sinusoidal partials.  Then, any sound that couldn't be analyzed into partial information is analyzed as noise information. The information can then be tranformed and resynthesized using this information.

Once installed, type atsa at the command line to see flag options and usage.

An example from within the SuperCollider_f directory:

	atsa sounds/a11wlk01.wav  sounds/a11wlk01.ats -H5000
	
-H5000 limits the analysis to frequencies below 5kHz.

Class Methods

Loading an ATS file with AtsFile

*new(path, server) - load an ATS file into memory at path with buffer number bufnum.  server defaults to Server.default. 

	a = AtsFile.new("sounds/a11wlk01.ats");
	
Instance Methods

load(buffer) - loads the information of the ATS file into a buffer for use by the AtsSynth UGens. If buffer is nil, one will be allocated for you. Only for real-time usage.

	a.load;
	
freeBuffer - releases the ATS buffer

info - returns info about the ATS object

getParFreq(par) - returns an array of frequencies of partial number par (starting with 0) per frame of analysis.

getParAmp(par) - returns an array of amplitudes of partial number par (starting with 0) per frame of analysis.

getFrameFreq(frame) - returns an array of frequenciesfor a given frame (starting with 0).

getFrameAmp(frame) - returns an array of frequenciesfor a given frame (starting with 0).

saveForSC(path) - save the ATS file as an AIFF that can be loaded into a buffer (for NRT and fast loading file data in real-time)

 


