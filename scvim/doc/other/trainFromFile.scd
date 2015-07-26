
SOMTrain.trainFromFile

	SOMTrain.trainFromFile(path, init=\gridrand, numdims=2, netsize=10, numruns=1, server, action, nhood=0.5, initweight=1)

Here's how to train the SOM from a data file. The data file should be an audio-format file (e.g. AIFF or WAV) but in most cases it won't be audio but whatever kind of data it is you're interested in learning. Only the first argument is compulsory. 
	"action" can be a string, in which case it's the path for the SOM buffer to be written to (AIFF format); or it can be a function, in which case it is evaluated and passed the SOM buffer.

Note that the data should be pre-scaled to a range of +-1 on all axes, since this convenience method doesn't account for different dynamic ranges in the data.

First let's generate a file containing toy data. This will (as in the main SOMTrain helpfile) be 2D data with a sinusoidal relationship:

s.boot;

~toydata = { var num; num = 2pi.rand; [num - pi / pi, num.sin]}.dup(10000);
// Let's plot the data - looks just like noise?
~toydata.flatten.plot(numChannels: 2);
// The following will plot a sorted version so you can see the relationship:
~toydata.deepCopy.sort{|a,b| a[0] <= b[0]}.flatten.plot(numChannels: 2)
// OK enough fun, let's write it as a datafile
~toydata = ~toydata.flatten.as(FloatArray);
~sf = SoundFile.new.headerFormat_("AIFF").sampleFormat_("float").numChannels_(2);
~sf.openWrite("tmp_SOMTrain_sinedata.aiff");
~sf.writeData(~toydata);
~sf.close;

// Check it's still sinusoidal:
b = Buffer.read(s, "tmp_SOMTrain_sinedata.aiff");
b.loadToFloatArray(action:{|data| {data = data.clump(2); data.sort{|a,b| a[0] <= b[0]};data.flatten.plot(numChannels: 2) }.defer})

// OK, now let's train a SOM on it (we'll load the resulting data to the lang as ~somdata):
SOMTrain.trainFromFile("tmp_SOMTrain_sinedata.aiff", numdims: 1, netsize: 15, numruns: 2, action:{|sombuf| sombuf.loadToFloatArray(action:{|data| ~somdata = data.clump(2)}) });
// Let's plot it:
(
	~winsize = 700;
	w = Window("SOM node locations", Rect(300, 300, ~winsize, ~winsize));
	~somdata.do{|datum| SCStaticText(w, Rect(~winsize * 0.5 * (datum[0]+1), ~winsize * 0.5 * (datum[1]+1), 10, 10)).string_("x")};
	w.front
)


