
PVAna			create FFT Analysis files.

See also: PV_PlayBuf, PV_BufRd, PV_BinPlayBuf and PV_BinBufRd

Class Methods
	
	*new(sfpath)
		sfpath - the path for a mono sound file to analyze

Instance Methods

	ana(filPath, fftSize, winType, hop)
		filPath - the path to save the analysis to
		fftSize - size of the FFT - should be a power of two (default: 2048)
		winType - the FFT window type (see FFT - default is 1, Hann)
		hop - the amount of offset from one FFT analysis frame to the next, measured in multiples of the 
			analysis frame size.	Defaults to 0.25.
		
Usage:

	a = PVAna.new("sounds/a11wlk01.wav");
	a.ana("sounds/a11wlk01.scpv", 2048, 1, 0.25);


