
SOMTrain two-dimensional example

In this example of SOMTrain in action, we create a 2D neural net and fit it to a data set which is a 2D surface in a 3D space - it should be quite straightforward for a 2D SOM to fit to the hills and valleys. See also SOMTrain_3D_example

Hint: self-organising maps work best when the training dimensions have a similar dynamic range (e.g. similar variance), so in this example we normalise the ranges of the input data. You should probably do a similar thing.

s.boot;
~numnodes = 20;
~traindur = 100000;
~dataspacelength = 100;
~dataspacechanwidth = 10;
// First create the data
~dataspace = Buffer.alloc(s, ~dataspacelength, ~dataspacechanwidth);
~data = ~dataspacechanwidth.collect{|index| ((0..~dataspacelength)*2*pi/~dataspacelength).sin * ((8 * index/~dataspacechanwidth).sin) }
//~data.heatMap(title: "training data (array)"); // You need the "heatMap" quark to run this line - visualises the data nicely
~dataspace.loadCollection(~data.flop.flatten);
//~dataspace.heatMap(title: "training data (buffer)");
// Allocate space for the SOM, and initialise it
~som = SOMTrain.allocBuf(s, ~numnodes, 2, 3);
SOMTrain.initBufGridRand(~som, ~numnodes, 2, scales: 3); // Grid init - a 2D grid is randomly oriented in the target space (which here is 3D)
//~som.plot(minval:nil.dup(3), maxval: nil.dup(3));
// Also, just for demonstration purposes, we're going to write the error values to a buffer so we can see how they evolve
~errorvals = Buffer.alloc(s, ~traindur);
// Now train the SOM. To train it with data "randomly sampled" from the data buffer, we just wiggle the phase around and feed [phase, val] to the SOM.
(
x = {
	var phase1, phase2, val, remain, err, trig;
	trig = 1;
	phase1 = WhiteNoise.kr.range(0, ~dataspace.numFrames-1);
	phase2 = WhiteNoise.kr.range(0, ~dataspace.numChannels);
	val = Select.kr(phase2.floor, BufRd.kr(~dataspace.numChannels, ~dataspace, phase1, 1));
	phase1.poll(trig, label: "phase1");
	phase2.poll(trig, label: "phase2");
	val.poll(trig, label: "val");
	// Here the ranges are reshaped to be +-1
	# remain, err = SOMTrain.kr(~som, [phase1 * 0.02 - 1, phase2 * 0.2 - 1, val], ~numnodes, 2, ~traindur, nhood: 0.75, gate: trig, initweight: 1);
	remain.poll(trig, label: "remain");
	err.poll(trig, label: "err");
	BufWr.kr(err.sqrt, ~errorvals, ~traindur-remain);
	Out.ar(0, Pan2.ar(K2A.ar(val) * 0.01));
}.play
)
// Once the training is finished...
x.free;

// How do the errors look? Should be a very noisy curve gradually decreasing, but won't necessarily stabilise
~errorvals.plot(maxval: nil, minval: nil);

// Now let's look at the mesh of points represented by the SOM. Do they fit the training data?
// Here's a pure SC plot, the colouring of the points representing the third dimension - you should be able to see the undulation
(
~cols = (1, 0.99 .. 0).collect{|cold| Color(0, cold * 0.1, cold)} ++ (0.01, 0.02 .. 1).collect{|hot| Color(hot, 0, 0)};
~som.loadToFloatArray(action: {|arr| {
	w = GUI.window.new("SOM nodes", Rect(200, 800, 600, 600)); // SCWindow
	(0,3..arr.size-1).do{|index|
		GUI.staticText.new(w, Rect(
				(arr[index]      +1 * 300 ), 
				(arr[index+1] +1 * 300 ), 
				20, 20)).string_("x").background_(~cols[arr[index+2].linlin(-1, 1, 0, ~cols.size-1)]) // SCStaticText
					
	};
	w.front;
}.defer})
)

// Or if you have OctaveSC you can plot a very nice 3D mesh:
o = OctaveSC.new;
o.init;
(
~som.loadToFloatArray(action: {|arr|
	var x, y, z;
	x = arr[0,3..];
	y = arr[1,4..];
	z = arr[2,5..];
	"x range: % to %".format(x.minItem, x.maxItem).postln;
	"y range: % to %".format(y.minItem, y.maxItem).postln;
	"z range: % to %".format(z.minItem, z.maxItem).postln;
	x = x.clump(~numnodes);
	y = y.clump(~numnodes);
	z = z.clump(~numnodes);
	o[\xtemp] = x;
	o[\ytemp] = y;
	o[\ztemp] = z;
	o.("figure; hold off");
	o.("mesh(xtemp, ytemp, ztemp)");
});
);
(
~dataspace.loadToFloatArray(action: {|arr|
	var x, y, z;
	
	arr = arr.clump(~dataspace.numChannels);
	
	x = (0..arr.size-1).dup(~dataspace.numChannels).flop;
	y = (0..~dataspace.numChannels-1).dup(arr.size);
	z = arr;
	"x size: [%, %]".format(x.size, x[0].size).postln;
	"y size: [%, %]".format(y.size, y[0].size).postln;
	"z size: [%, %]".format(z.size, z[0].size).postln;
	o[\xtemp] = x;
	o[\ytemp] = y;
	o[\ztemp] = z;
	o.("figure; hold off");
	o.("mesh(xtemp, ytemp, ztemp)");
});
);

// Dump the xyz coordinates:
~som.loadToFloatArray(action: {|arr|   arr.clump(3).do(_.postln)   });


