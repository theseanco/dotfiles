
AtsFreq / AtsAmp			Use Freq and Amp data from a given partial
AtsParInfo					One UGen to return both Amp and Freq info

AtsFreq.kr(atsbuffer partialNum, filePointer, mul, add);

- returns frequency information for a given partial

	partialNumber - the number of the partial to return frequency data for.  Partial 0 is the first partial.

AtsAmp.kr(atsbuffer, partialNum, filePointer, mul, add);

- returns amplitude information for a given partial

	partialNumber - the number of the partial to return frequency data for.  Partial 0 is the first partial.
	
AtsParInfo.kr(atsbuffer, partialNum, filePointer, mul, add);

- returns amplitude and freq information for a given partial

	partialNumber - the number of the partial to return frequency data for.  Partial 0 is the first partial.
	
	
Usage
	 
For resynthesis purposes, an ATS file needs to be loaded into a buffer.  When loading an ATS file, you need to supply a buffer number to store ATS data in.

s.boot;

a = AtsFile.new("sounds/a11wlk01.ats").load;

( //use freq and amp information for a filter ugen (just the first 30 partials)
{
	var noise, freqs, amps, partials;
	partials = Array.series(30, 1, 1);
	// outputs an array of 30 freq values;
	freqs = AtsFreq.kr(a.bufnum, partials, MouseX.kr(0, 1));
	// outputs an array of 30 amp values
	amps = AtsAmp.kr(a.bufnum, partials, MouseX.kr(0, 1));
	// feed these into a reson filter, mix down to one channel
	Mix.ar(Resonz.ar(WhiteNoise.ar(20), freqs, 0.01, amps));
	}.play(s);
);

( //use freq and amp information for a filter ugen (just the first 30 partials)
{
	var noise, freqs, amps, freqs1, amps1, partials, out;
	partials = Array.series(30, 1, 1);
	// outputs an array of 30 freq values;
	out = AtsParInfo.kr(a.bufnum, partials, MouseX.kr(0, 1));
	// need to flop the array output
	#amps, freqs = out.flop;
	// outputs an array of 30 amp values
	// feed these into a reson filter, mix down to one channel
	Mix.ar(Resonz.ar(WhiteNoise.ar(20), freqs, 0.01, amps ));
	}.play(s);
);


