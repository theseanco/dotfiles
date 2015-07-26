
PV_BinPlayBuf				plays FFT data to a memory buffer

PV_PlayBuf will play back FFT data stored to a buffer with PV_RecordBuf.

WARNING: Resynth of a FFTs with large window sizes may cause CPU spikes.
WARNING: Unlike PV_PlayBuf, PV_BinPlayBuf needs to have an FFT Ugen preceding it in the 
	processing chain.

PV_RecordBuf stores FFT data to a buffer for use by a number of PV UGens. See also PV_RecordBuf, PV_PlayBuf, PV_BufRd and PV_BinBufRd.

PV_BinPlayBuf(buffer, playbuf, rate, offset, binStart, binSkip, numBins, loop, hop, wintype)

	buffer - the FFT buffer to fill data into
	playbuf - the buffer to read frames of FFT data fram.
	rate - rate of playback of FFT data. Fractional time frames will use linearly interpolated phase and 
		magnitude values. Can be negative.
	offset - an integer number of frames to offset into the playbuf file. Defaults to 0.0.
	binStart, binSkip and numBins - see below.
	loop - if > 0.0, when the end of the databuf is reached, new data will begin to overwrite old data.
	clear - if > 0.0, bins that don't correspond to the desirœed bins to synthesize will have their magnitude
		zeroed out.
		 
With binStart, binSkip and numBins, you have some control over which bins to synthesize. 
	e.g. binStart = 0
	        binSkip = 2
	        numBins = 10
	bins to synthesize = [0, 2, 4, 6, 8, 10, 12, 14, 16, 18]
	
All values for these parameters are truncated to integers when used by the UGens (you can't start an bin 1.5 or skip 2.3).

Examples:

// anazlyze a soundfile and store its data to a buffer

s.boot;

(
var sf;
// path to a sound file here
p = "sounds/a11wlk01.wav";
// the frame size for the analysis - experiment with other sizes (powers of 2)
f = 1024; 
// the hop size
h = 0.25;
// get some info about the file
sf = SoundFile.new( p );
sf.openRead;
sf.close;
// allocate memory to store FFT data to... SimpleNumber.calcPVRecSize(frameSize, hop) will return 
// the appropriate number of samples needed for the buffer
y = Buffer.alloc(s, sf.duration.calcPVRecSize(f, h));
// allocate the soundfile you want to analyze
z = Buffer.read(s, p);
)

// this does the analysis and saves it to buffer 1... frees itself when done
(
SynthDef("pvrec", { arg recBuf=1, soundBufnum=2;
	var in, chain, bufnum;
	Line.kr(1, 1, BufDur.kr(soundBufnum), doneAction: 2);
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 0);
	bufnum = LocalBuf.new(1024);
	// note the window type and overlaps... this is important for resynth parameters
	chain = FFT(bufnum, in, 0.25, 1); 
	chain = PV_RecordBuf(chain, recBuf, 0, 1, 0, 0.25, 1);
	// no ouput ... simply save the analysis to recBuf
	}).send(s);
)
a = Synth("pvrec", [\bufnum, x, \recBuf, y, \soundBufnum, z]);

// you can save your 'analysis' file to disk! I suggest using float32 for the format
// These can be read back in using Buffer.read

y.write(p++".scpv", "wav", "float32");

// play your analysis back ... see the playback UGens listed above for more examples.
(
SynthDef("pvplay", { arg out=0, recBuf=1, playbuf, clear = 0.0;
	var in, chain, bufnum;
	bufnum = LocalBuf.new(1024);
	chain = FFT(bufnum, PlayBuf.ar(1, playbuf, BufRateScale.kr(playbuf), loop: 1));
	// start at bin 10, skip 3, resynth 50 - replace these bins. MouseX controls rate
	chain = PV_BinPlayBuf(chain, recBuf, MouseX.kr(-0.8, 0.8), 0, 10, 3, 50, 1, clear);
	Out.ar(out, IFFT(chain, 1).dup);
	}).send(s);
);

// analyze and resynth soundfile AND replace selected bins with PV_BinPlayBuf data 
b = Synth("pvplay", [\out, 0, \bufnum, x, \recBuf, y, \playbuf, z, \clear, 0]);

// stop the synth
b.free;

// clear out the bins that PV_BinPlayBuf doesn't touch
b = Synth("pvplay", [\out, 0, \bufnum, x, \recBuf, y, \playbuf, z, \clear, 1.0]);

// stop the synth
b.free;

// fill in different bins with different information
(
SynthDef("pvplay", { arg out=0, recBuf=1, playbuf, clear = 0.0;
	var in, chain, bufnum;
	bufnum = LocalBuf.new(1024);
	chain = FFT(bufnum, PlayBuf.ar(1, playbuf, BufRateScale.kr(playbuf), loop: 1));
	// start at bin 10, skip 3, resynth 50 - replace these bins. MouseX controls rate
	chain = PV_BinPlayBuf(chain, recBuf, MouseX.kr(-0.8, 0.8), 0, 10, 1, 40, 1, clear);
	chain = PV_BinPlayBuf(chain, recBuf, MouseX.kr(-0.2, 0.2), 0, 90, 7, 30, 1, 0.0);
	Out.ar(out, IFFT(chain, 1).dup);
	}).send(s);
);

// analyze and resynth soundfile AND replace selected bins with PV_BinPlayBuf data 
b = Synth("pvplay", [\out, 0, \bufnum, x, \recBuf, y, \playbuf, z]);

// stop the synth
b.free;

// clear out the bins that PV_BinPlayBuf doesn't touch
b = Synth("pvplay", [\out, 0, \bufnum, x, \recBuf, y, \playbuf, z, \clear, 1.0]);

// stop the synth
b.free;
// free the buffers
[y, z].do({arg me; me.free});



