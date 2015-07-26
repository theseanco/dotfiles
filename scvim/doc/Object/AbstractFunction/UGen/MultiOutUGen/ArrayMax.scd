
ArrayMax		detect the largest value (and its position) in an array of UGens

# val, index = ArrayMax.ar(array)
# val, index = ArrayMax.kr(array)

Finds the maximum value in an Array of UGens, and outputs the value and the index.

This is for use in a SynthDef. If you simply need to find out which is the maximum in an array of numbers, use the maxIndex and/or maxItem methods defined for any Collection.

See also: ArrayMin, BufMax


Example

Here we generate a three-channel signal containing some simple test curves, and analyse it to generate a plot:

s.boot;
(
{
	var son, val, index;
	son = [
		Line.ar(10, 1, 0.5),  // a linear descent in half a second
		XLine.ar(1, 10, 1),   // an exponential ascent in one second
		DC.ar(3)              // a constant
		];
	# val, index = ArrayMax.ar(son);
	[val, index]
}.plot(1, minval: nil, maxval: nil);
)

Here we use the operation as an audio effect:

(
x = {
	// A collection of different tones:
	var son = SinOsc.ar((100, 100.3 .. 110));
	var val = ArrayMax.ar(son).at(0);
	val = LeakDC.ar(val); // the operation tends to induce DC offset
	Pan2.ar(val)
}.play
)
x.free


