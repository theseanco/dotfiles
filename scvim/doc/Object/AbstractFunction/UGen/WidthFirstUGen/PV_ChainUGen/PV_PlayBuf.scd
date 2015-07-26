
PV_PlayBuf				plays FFT data from a memory buffer

PV_PlayBuf will play back FFT data stored to a buffer with PV_RecordBuf.

WARNING: Resynth of a FFTs with large window sizes may cause CPU spikes.

PV_RecordBuf stores FFT data to a buffer for use by a number of PV UGens. See also PV_RecordBuf, PV_BinPlayBuf, PV_BufRd and PV_BinBufRd.

PV_PlayBuf(buffer, playbuf, rate, offset, loop, hop, wintype)

	buffer - the FFT buffer to fill data into
	playbuf - the buffer to read frames of FFT data fram.
	rate - rate of playback of FFT data. Fractional time frames will use linearly interpolated phase and 
		magnitude values. Can be negative.
	offset - an integer number of frames to offset into the playbuf file. Defaults to 0.0.
	run - if > 0.0, store data to the recbuf. 
		 
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
SynthDef("pvrec", { arg bufnum=0, recBuf=1, soundBufnum=2;
	var in, chain;
	Line.kr(1, 1, BufDur.kr(soundBufnum), doneAction: 2);
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 0);
	bufnum = LocalBuf.new(1024, 1); // uses frame size from above
	// note the window type and overlaps... this is important for resynth parameters
	chain = FFT(bufnum, in, 0.25, 1); 
	chain = PV_RecordBuf(chain, recBuf, 0, 1, 0, 0.25, 1);
	// no ouput ... simply save the analysis to recBuf
	}).send(s);
)
a = Synth("pvrec", [\recBuf, y, \soundBufnum, z]);

// you can save your 'analysis' file to disk! I suggest using float32 for the format
// These can be read back in using Buffer.read

y.write(p++".scpv", "wav", "float32");

// play your analysis back ... see the playback UGens listed above for more examples.
(
SynthDef("pvplay", { arg out=0, recBuf=1;
	var in, chain, bufnum;
	bufnum = LocalBuf.new(1024, 1);
	chain = PV_PlayBuf(bufnum, recBuf, MouseX.kr(-1, 1), 50, 1);
	Out.ar(out, IFFT(chain, 1).dup);
	}).send(s);
);
b = Synth("pvplay", [\out, 0, \recBuf, y]);

// stop the synth
b.free;

// vary the rate... experiment with different FFT sizes and overlaps in the analysis:
(
SynthDef("pvplay", { arg out=0, recBuf=1;
	var in, chain, bufnum;
	bufnum = LocalBuf.new(1024, 1);
	chain = PV_PlayBuf(bufnum, recBuf, LFNoise2.kr(0.2).range(-1, 2), 0, 1);
	Out.ar(out, IFFT(chain, 1).dup);
	}).send(s);
)
b = Synth("pvplay", [\out, 0, \recBuf, y]);

// stop the synth
b.free;

// free the buffers
[y, z].do({arg me; me.free});



