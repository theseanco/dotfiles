
SOMAreaWr		Write data over an n-D area in a buffer

	SOMAreaWr.kr(bufnum, inputdata, coords, netsize, numdims, nhood, gate)

If you are training a SOM using SOMTrain, and you also want some data to be stored along with each node, generated during the training process, then you can simply use BufWr in combination with SOMRd.coordsToBufIndex. However, this won't let you write the datum to a neighbourhood, just to a single node. Using SOMAreaWr you can write to a hypercubic area of your data storage buffer. You need to feed it coords for writing, which you'd typically get using SOMRd.

 - bufnum	- A reference to a Buffer where the data will be written (NOT the SOM buffer).
 - inputdata	- An Array of the input signals to be stored.
 - netsize	- The size of the neural net along one dimension.
 - numdims - The dimensionality of the neural net. Choose from 1, 2, 3, or 4.
 - nhood	- The size of the neighbourhood you want to write to, a modulateable value between 0 and 1. Zero means write to just one location. One means definitely write to all locations.
 - gate 	-  A simple on-or-off control. When off (gate<=0) the incoming data is ignored.

The buffer must be of the right size to hold the data you're interested in, namely

	b = Buffer.alloc(s, netsize**numdims, inputdata.size);



TESTING:
Let's create a zero'ed Buffer representing 2D data in just one channel, then run SOMAreaWr very briefly, then plot the results to see that the correct value has been written over the correct expanse.

s.boot;
~netsize = 20;
~numdatadims = 3; // We only "really" use 1 dim in this visualisation, but we write the data to all dims
b = Buffer.alloc(s, ~netsize**2, ~numdatadims);
// You only need to run these for a second:
x = {SOMAreaWr.kr(b, [-0.33333333].dup(~numdatadims), [10, 10], ~netsize, 2, 1)}.play;
x.free;
x = {SOMAreaWr.kr(b, [-0.15].dup(~numdatadims), [2, 18], ~netsize, 2, 0)}.play;
x.free;
x = {SOMAreaWr.kr(b, [0.5].dup(~numdatadims), [6, 6], ~netsize, 2, 0.1)}.play;
x.free;
x = {SOMAreaWr.kr(b, [1.0].dup(~numdatadims), [14, 10], ~netsize, 2, 0.2)}.play;
x.free;
// Now the heatmap should show us some neat squares:
b.loadToFloatArray(action: {|arr| {arr.clump(~numdatadims).flop.choose.clump(~netsize).flop.heatMap(colscheme:\coals)}.defer});

// This generates more intricate data (rerun the heatmap line above to see the result):
(
x = {
	var location = {LFNoise1.kr(50).range(0, ~netsize-1)}.dup(2);
	var size = XLine.kr(1, 0.000000001, 1, doneAction: 2);
	var value = Line.kr(0, 9                      , 1, doneAction: 2).dup(~numdatadims);
	SOMAreaWr.kr(b, value, location, ~netsize, 2, size);
}.play;
)


