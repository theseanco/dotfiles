
WAmp			windowed amplitude follower

WAmp.kr(in, winSize)

Averages and outputs the absolute value of incoming signals received between now and (now - winSize) seconds.
in - Signal input.
winSize - The window size in seconds. Not modulatable. (Default: 0.1)

See also: Amplitude TrigAvg


// Averaging WhiteNoise, 5 seconds.
x = { WAmp.kr(WhiteNoise.ar(), 5).poll }.play;
x.free;


