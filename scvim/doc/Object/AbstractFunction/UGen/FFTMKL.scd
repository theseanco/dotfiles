
FFTMKL	Modified Kullback-Liebler Distance metric

	FFTMKL.kr(chain, epsilon=0.000001)

Calculates a modified version of the Kullback-Liebler Distance, which originates as a measure of similarity between probability distributions, but is modified here to a version particularly suited to onset detection. Specifically, we use equation 2.9 (p41) in

	P. Brossier, Automatic Annotation of Musical Audio for Interactive Applications, PhD thesis, Queen Mary, University of London, August 2006.


The calculation is the sum over all K bins of

	log(1 + mag[k][n] / (mag[k][n - 1] + epsilon))

The parameter epsilon "is designed to avoid large variations when very low energy levels are encountered, and thus prevents large peaks in the detection function at offset times." Feel free to fiddle with it.

This UGen is used in one of the modes of the onset detector [OnsetsDS].


Example


s.boot;
// Load an audio file and plot the MKL distance as a function of time
b = Buffer.alloc(s, 512, 1);
c = Buffer.read(s, "sounds/a11wlk01.wav");
(
x = {
var in, chain, mkl;
in = PlayBuf.ar(1, c.bufnum, BufRateScale.kr(c.bufnum));
chain = FFT(b.bufnum, in);
mkl = FFTMKL.kr(chain);
mkl.poll(10, "MKL distance");
Out.ar(0, in.dup * 0.1);
K2A.ar(mkl)
}.plot(c.numFrames/c.sampleRate, s);
)

x.free; b.free; c.free;


