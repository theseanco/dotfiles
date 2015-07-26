
AtsSynth			Resynthesize sine data from an ATS analysis file

AtsSynth.ar(atsbuffer, numPartials, partialStart, partialSkip, filePointer, freqMul, freqAdd, mul, add)
	
- resynthesizes information from an ATS file, with transformations.

	atsbuffer -  the buffer number that contains the AtsFile information
	numPartials - the number of partials to synthesize
	partialStart - the partial in the analysis to start the synthesis on. Partial 0 is the first partial.
	partialSkip - an integer that indicates the increment of from partialStart of which partials to synthesize.
	filePointer - a value (between 0 and 1) that indicates which part of the file to synthesize.  Accepts ugens 
		or a static value.
	freqMul - a multiplier on the sinusoidal frequency information.
	freqAdd - a value to add to frequency information.
	
**WARNING** If you try to resynthesize partials that don't exist, those partials will fail silently.  All valid partials will still be synthesized.

Usage
	 
For resynthesis purposes, an ATS file needs to be loaded into a buffer.  When loading an ATS file, you need to supply a buffer number to store ATS data in.

s.boot;

a = AtsFile.new("sounds/a11wlk01.ats").load;

( //play just the resynth, with LFSaw pointing into the file
{
	AtsSynth.ar(a.bufnum, a.numPartials, 0, 1, 
		filePointer: LFSaw.kr(a.sndDur.reciprocal, 1, 0.5, 0.5), mul: 1)
	}.play(s);
);

( //multiply frequencies by 1.5
{
	AtsSynth.ar(a.bufnum, a.numPartials, 0, 1, 
		filePointer: LFSaw.kr(a.sndDur.reciprocal, 1, 0.5, 0.5), freqMul: 1.5, mul: 1)
	}.play(s);
);

( //add 100 to all frequencies
{
	AtsSynth.ar(a.bufnum, a.numPartials, 0, 1, 
		filePointer: LFSaw.kr(a.sndDur.reciprocal, 1, 0.5, 0.5), freqAdd: 100.0, mul: 1)
	}.play(s);
);

( //resynthesize every third partial only (partial skip)
{
	AtsSynth.ar(a.bufnum, a.numPartials * 0.3, 0, 3, 
		filePointer: LFSaw.kr(a.sndDur.reciprocal, 1, 0.5, 0.5), mul: 1)
	}.play(s);
);

( //resynthesize only the top half of the partials
{
	AtsSynth.ar(a.bufnum, a.numPartials * 0.5, a.numPartials * 0.5, 1, 
		filePointer: LFSaw.kr(a.sndDur.reciprocal, 1, 0.5, 0.5), mul: 1)
	}.play(s);
);


