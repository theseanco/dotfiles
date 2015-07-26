
AverageOutput

The mean average output since the last received trigger.

Class methods

*ar(in, trig, mul, add)
*kr(in, trig, mul, add)


in - input signal.

trig -  if changes from <= 0 to > 0, resets average and count to zero.


Examples

// stepper cycles between 0 and 1, average hovers around 0.5
a = { AverageOutput.kr(Stepper.kr(Impulse.kr(1), min: 0, max: 1)).poll }.play;

a.free;


