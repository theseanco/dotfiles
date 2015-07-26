
SOMTrain three-dimensional example

In this example of SOMTrain in action, we create a 3D neural net and fit it to a data set which is a 3D lumpy mattress in a 4D space - it should be OK for a 3D SOM to fit to the hills and valleys. This is similar to SOMTrain_2D_example

s.boot;
~numnodes = 15;
~traindur = 100000;
~dataspacelength = 100;
~dataspacechanwidth = 10;
// First create the data (the third dimension is just amplitude in this case, so we don't store it: ~dataspace is 2D)
~dataspace = Buffer.alloc(s, ~dataspacelength, ~dataspacechanwidth);
~data = ~dataspacechanwidth.collect{|index| ((0..~dataspacelength)*2*pi/~dataspacelength).sin * ((8 * index/~dataspacechanwidth).sin) }
//~data.heatMap(title: "training data (array)"); // You need the "heatMap" quark to run this line - visualises the data nicely
~dataspace.loadCollection(~data.flop.flatten);
//~dataspace.heatMap(title: "training data (buffer)");
// Allocate space for the SOM, and initialise it
~som = SOMTrain.allocBuf(s, ~numnodes, 3, 4);
SOMTrain.initBufGridRand(~som, ~numnodes, 3); // 3D grid, randomly oriented in the 4D space
// Also, just for demonstration purposes, we're going to write the error values to a buffer so we can see how they evolve
~errorvals = Buffer.alloc(s, ~traindur);
// Now train the SOM. To train it with data "randomly sampled" from the data buffer, we just wiggle the phase around and feed [phase, val] to the SOM.
(
x = {
	var phase1, phase2, thirddim, val, remain, err, trig;
	trig = 1;
	phase1 = WhiteNoise.kr.range(0, ~dataspace.numFrames-1);
	phase2 = WhiteNoise.kr.range(0, ~dataspace.numChannels);
	thirddim = WhiteNoise.kr.range(0, 1);
	val = Select.kr(phase2.floor, BufRd.kr(~dataspace.numChannels, ~dataspace, phase1, 1)) * thirddim;
	phase1.poll(trig, label: "phase1");
	phase2.poll(trig, label: "phase2");
	val.poll(trig, label: "val");
	// Here the ranges are reshaped to be +-1
	# remain, err = SOMTrain.kr(~som, [phase1 * 0.02 - 1, phase2 * 0.2 - 1, thirddim, val], ~numnodes, 3, ~traindur, nhood: 0.5, gate: trig, initweight: 0.5);
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
o = OctaveSC.new;
o.init;
(
~som.loadToFloatArray(action: {|arr|
	var x, y, w, z;
	x = arr[0,4..];
	y = arr[1,5..];
	w = arr[2,6..];
	z = arr[3,7..];
	"x range: % to %".format(x.minItem, x.maxItem).postln;
	"y range: % to %".format(y.minItem, y.maxItem).postln;
	"w range: % to %".format(w.minItem, w.maxItem).postln;
	"z range: % to %".format(z.minItem, z.maxItem).postln;
	x = x.clump(~numnodes);
	y = y.clump(~numnodes);
	w = w.clump(~numnodes);
	z = z.clump(~numnodes);
	o.("figure; hold on");
	// Plot the SOM slice by slice
	~numnodes.do{|offset|
		o[\xtemp] = x[offset, offset + ~numnodes .. ];
		o[\ytemp] = y[offset, offset + ~numnodes .. ];
		o[\wtemp] = w[offset, offset + ~numnodes .. ];
		o[\ztemp] = z[offset, offset + ~numnodes .. ];
		o.("mesh(xtemp, ytemp, ztemp)");
	}
});
);


