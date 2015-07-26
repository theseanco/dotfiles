
Metro			metronome - outputs a single sample impulse according to bpm and numBeats

	*ar(bpm, numBeats, mul, add)
	*kr(bpm, numBeats, mul, add)	
		
		bpm		 	beats per minute
		numBeats	number of beats before the next pulse
		
	bpm and numBeats are polled on every impulse of output. These can be scalers, audio rate, control rate
		or Demand UGens
	
	// examples
	
	a = {Metro.ar(60, 1)}.play
	a.free;

	a = {Decay.kr(Metro.kr(XLine.kr(60, 120, 5), 1)) * SinOsc.ar(440, 0, 0.1)}.play;
	a.free;
	
	(
	a = {
		Decay.kr(
			Metro.kr(
				LFNoise2.kr(0.2).range(30, 240), 
				Dseq([1, 0.25, 0.5, 0.25], inf))) * 
		SinOsc.ar(440, 0, 0.1)
		}.play;
	)	
	
	a.free;
	


