
AtsNoiSynth			Resynthesize sine and noise data from an ATS analysis file

AtsNoiSynth.ar(atsbuffer, numPartials, partialStart, partialSkip, filePointer, sinePct, noisePct, freqMul,
	freqAdd, numBands, bandStart, bandSkip, mul, add)
	
- resynthesizes information from an ATS file, with transformations.

	atsbuffer -  the buffer number that contains the AtsFile information
	numPartials - the number of partials to synthesize
	partialStart - the partial in the analysis to start the synthesis on. Partial 0 is the first partial.
	partialSkip - an integer that indicates the increment from partialStart of which partials to synthesize.
	filePointer - a value (between 0 and 1) that indicates which part of the file to synthesize.  Accepts ugens 
		or a static value.
	sinePct - a scaler on the sinusoidal portion of the resynthesis.
	noisePct - a scaler on the noise portion of the resynthesis.
	freqMul - a multiplier on the sinusoidal frequency information.
	freqAdd - a value to add to frequency information.
	numBands - the number of critical bands (noise) to synthesize.  There are 25 critical bands.
	bandStart - the critical band to start resynthesis on. Partial 0 is the first band.
	bandSkip - an integer that indicates the increment from bandStart of which bands to synthesize.
	
**WARNING** If you try to resynthesize partials or bands that don't exist, those partials will fail silently.  All valid partials will still be synthesized.

Usage
	 
For resynthesis purposes, an ATS file needs to be loaded into a buffer.  When loading an ATS file, you need to supply a buffer number to store ATS data in.

s.boot;

a = AtsFile.new("sounds/a11wlk01.ats").load;

( //play just the resynth, with LFSaw pointing into the file
{
	AtsNoiSynth.ar(a.bufnum, a.numPartials, 1, 1, 
		filePointer: LFSaw.kr(a.sndDur.reciprocal, 1, 0.5, 0.5), noisePct: 1, mul: 1)
	}.play(s);
);

( //play noise only, don't resynthesize sine info
{
	AtsNoiSynth.ar(a.bufnum, 0, 0, 1, filePointer: LFSaw.kr(a.sndDur.reciprocal, 1, 0.5, 0.5), 		mul: 1)
	}.play(s);
);

( //resynthesize every other noise band
{
	AtsNoiSynth.ar(a.bufnum, 0, 0, 1, filePointer: LFSaw.kr(a.sndDur.reciprocal, 1, 0.5, 0.5), 
		numBands: 12, bandStart: 1, bandSkip: 2, mul: 10)
	}.play(s);
);

( //resynthesize only the upper bands of noise
{
	AtsNoiSynth.ar(a.bufnum, 0, 0, 1, filePointer: LFSaw.kr(a.sndDur.reciprocal, 1, 0.5, 0.5), 
		numBands: 12, bandStart: 12, bandSkip: 1, mul: 10)
	}.play(s);
)



