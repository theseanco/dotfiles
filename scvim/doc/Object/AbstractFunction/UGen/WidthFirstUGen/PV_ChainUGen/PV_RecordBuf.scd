
PV_RecordBuf				records FFT data to a memory buffer

PV_RecordBuf stores FFT data to a buffer for use by a number of PV UGens. See also PV_PlayBuf, PV_BinPlayBuf, PV_BufRd and PV_BinBufRd.

PV_RecordBuf(buffer, recbuf, offset, run, loop, hop, wintype)

	buffer - the FFT buffer
	recbuf - the buffer to save frames of FFT data to.
	offset - an integer number of frames to offset into the recbuf file. Defaults to 0.0.
	run - if > 0.0, store data to the recbuf. 
	loop - if > 0.0, when the end of the databuf is reached, new data will begin to overwrite old data.
	hop - the hop size used in the FFT analysis UGen (this allows the PV_Player UGens to check for
		consistency).
	wintype - the wintype used in the FFT analysis UGen (this allows the PV_Player UGens to check for
		consistency).
		 
Examples:

// anazlyze a soundfile and store its data to a buffer

s.boot;

(
var sf;
// path to a sound file here
p = "sounds/a11wlk01.wav";
// the frame size for the analysis - experiment with other sizes (powers of 2)
f = 2048; 
// the hop size
h = 0.5;
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

// this does the analysis and saves it to 'y'... frees itself when done
(
SynthDef("pvrec", { arg recBuf=1, soundBufnum=2;
	var in, chain, bufnum;
	bufnum = LocalBuf.new(2048, 1);
	Line.kr(1, 1, BufDur.kr(soundBufnum), doneAction: 2);
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 0);
	// note the window type and overlaps... this is important for resynth parameters
	chain = FFT(bufnum, in, 0.25, 1); 
	chain = PV_RecordBuf(chain, recBuf, 0, 1, 0, 0.5, 1);
	// no ouput ... simply save the analysis to recBuf
	}).load(s);
	
a = Synth("pvrec", [\recBuf, y, \soundBufnum, z]);
)

// you can save your 'analysis' file to disk! I suggest using float32 for the format
// These can be read back in using Buffer.read

y.write(p++".scpv", "wav", "float32");

// play your analysis back ... see the playback UGens listed above for more examples.
(
SynthDef("pvplay", { arg out=0, recBuf=1;
	var in, chain, bufnum;
	bufnum = LocalBuf.new(2048);
	chain = PV_PlayBuf(bufnum, recBuf, 1, 0, 1, 1, 0.25, 1);
	Out.ar(out, IFFT(chain, 1).dup);
	}).send(s);
);
b = Synth("pvplay", [\out, 0, \recBuf, y]);

// stop the synth
b.free;

// free the buffers
[y, z].do({arg me; me.free});



