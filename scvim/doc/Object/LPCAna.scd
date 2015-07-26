
LPCAna			creates LPC analysis file (adapted and expanded from R. Moore's LPC 
					analysis code from 'Computer Music' ...

See also: LPCFile, LPCSynth, LPCVals

Class Methods
	
	*new(path)
		path - the path for a mono sound file to analyze

Instance Methods

	ana(nPoles, frameSize, hop, channel, minFreq, maxFreq, check, conditionSignal, completion)
		nPoles - the number of poles for the all-pole filter (default: 35, must be less the 200)
		frameSize - the number of samples to use for each from of analysis (default: 400)
		hop - a percentage of the frameSize to skip for the next window (default: 0.5)
		channel - the channel to analyze if the file at 'path' is multi-channel (default: 0)
		minFreq - a minFreq to search for in pitch tracking (defautl: 70)
		maxFreq - a maxFreq to search for in pitch tracking (default: 200)
		check - attempts to check poles for stability. WARNING: Somewhere in this code, I've made 
			a terrible mistake. It actually CAUSES instabilities rather then getting rid of them... but
			I can't, for the life of me, see where the error is. Don't use it. Moore's basic algorithm is 
			pretty good, and the filters seems fairly stable. If you have problems, try increasing the 
			number of poles (default: 0)
		conditionSignal - if 0, does nothing, if 1, applies a simple low pass filter to each window
			before doing the analysis (which helps avoid instabilities), or 2, apply a DRASTIC low pass
			filter to the signal that I saw in some of CSounds LPC code. This REALLY smoothes out
			the signal, and usually causes some pretty crazy instabilities because the output of the
			filter is SO resonant. (default: 0, 1 works well, choose 2 if you want exploding filters that
			might (?) be interesting.
		completion - a function to evaluate when the analysis is finished. Handy for bulk analyzing files, 
			and auto saving them.

	lperr(numTurns) - low pass the error signal numTurns times
	lprms(numTurns) - low pass the overall rms signal numTurns times
	lppch(numTurns) - low pass the pchcps signal numTurns times
	
	saveToLPCFile(path) - save file to an LPC file usable by LPCFile, LPCSynth and LPCVals.
	saveToFiles(path) - save file to an LPC file usable by LPCFile, LPCSynth and LPCVals, as well as a 
		floating point .aif data file for use in NRT.
	
Usage:

	a = LPCAna.new("sounds/a11wlk01.wav");
	a.ana(50, 400, 0.5, 0, 70, 300);
	
	// low pass an aspect of the analysis
	a.err.plot
	a.lperr;
	a.err.plot;
	
	a.pchcps.plot;
	a.lppch;
	a.pchcps.plot;


