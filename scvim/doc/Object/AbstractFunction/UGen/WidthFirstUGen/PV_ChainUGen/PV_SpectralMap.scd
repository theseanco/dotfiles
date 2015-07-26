
PV_SpectralMap				maps the spectral envelope of one FFT
									process onto another (acts as a spectral
									filter)

WARNING: Use of a FFTs with a large window size may cause CPU spikes.

PV_SpectralMap(buffer, specBuffer, floor, freeze, reject)

	buffer - the FFT buffer to filter
	specBuffer - the FFT buffer to derive the spectral curve from
	floor - the spectral curve is a normalized representation of the magnitudes in specBuffer (between 0 
		and 1). if floor > 0, mags in the spectral curve BELOW this number are also zeroed out.
	freeze - if > 0, freeze the current spectral curve. The 'floor' parameter is ignored once the spectral
		curve is frozen.
	mode - if mode == 0, PV_SpectralMap does not have any effect. > 0 acts as a bandpass filter, < 0 
		a bandreject.
	norm - normalization mode. If <=0, the specBuffer's magnitudes are normalized on a frame by
		fram basis. >0, normalized according to the the sum of the FFT window's sample values.
	window - the window used for the FFT - this will effect scaling if norm is > 0.
			 
Examples:


s.boot;
z = Buffer.read(s, "sounds/a11wlk01.wav");

(
x = SynthDef(\specMap, {arg sndBuf, freeze = 0;
	var a, b, chain1, chain2, out;
	a = LocalBuf.new(2048);
	b = LocalBuf.new(2048);
	chain1 = FFT(a, LFSaw.ar(120)); // to be filtered
	chain2 = FFT(b, PlayBuf.ar(1, z, 1, loop: 1));
	// mouse x to play with floor. 
	chain1 = PV_SpectralMap(chain1, chain2, 0.0, freeze, MouseX.kr(-1, 1), 1);
	out = IFFT(chain1);
	Out.ar(0, out.dup);
}).play(s, [\sndBuf, z, \freeze, 0])
)

x.set(\freeze, 1)
x.set(\freeze, 0);

x.free;

z.free;


