
TrigAvg			triggered signal averager

TrigAvg.kr(in, trig)

Averages the absolute values of its input between triggers.
in - Signal Input
trig - When triggered, TrigAvg forgets the past average and starts averaging from zero.

See also: WAmp Amplitude


// average some values
x = { TrigAvg.kr(MouseX.kr(0,1000).round(100), MouseY.kr(-1, 1)).poll }.play;
x.free;

x = { TrigAvg.kr(SinOsc.ar(1), Impulse.kr(0.5)).poll }.play;
x.free;



