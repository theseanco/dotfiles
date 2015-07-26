
PanX			equal power pan across an array of speakers

PanX.ar(numChans, in, pos, level, width)

Multichannel equal power panner.

numChans - number of output channels
in - input signal
pos - a value between 0 and 1. 0 - first speaker, 1 is the last. Values < 0 fade out sound from the first speakers,
	and values > 1 fade out sound from the last speakers. Sound does NOT wrap.
level - a control rate level input.
width - The width of the panning envelope. Nominally this is 2.0 which pans between pairs
of adjacent speakers. Width values greater than two will spread the pan over greater numbers
of speakers. Width values less than one will leave silent gaps between speakers.

// five channel panning across an array
Server.internal.boot;
(
a = {
	PanX.ar(
		5, 				// numChans
		ClipNoise.ar, 	// in
		MouseX.kr(-0.5, 1.5), // pos
		0.5,			// level
		MouseY.kr(1, 3)			// width
	);
}.play(Server.internal);
Server.internal.scope(5);
)

a.free;


