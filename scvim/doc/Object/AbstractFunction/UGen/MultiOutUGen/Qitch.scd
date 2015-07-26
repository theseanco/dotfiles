
//Copyright (C) 2006  Nick Collins distributed under the terms of the GNU General Public License

Qitch						constant Q transform pitch follower

#freq, hasFreq = Qitch.kr(in, databufnum,ampThreshold, algoflag, ampbufnum, minfreq, maxfreq)
			
This alternative pitch follower works in the frequency domain rather than Pitch's time domain correlation. Tradeoffs are made between latency and frequency resolution. It is meant to provide a relatively stable resultant tracked pitch based on a harmonic template.  

You must load one of the auxilliary data files into a Buffer and pass the bufnum to the routine. These files take the form:

 QspeckernN1024SR44100.wav
 QspeckernN2048SR44100.wav
 QspeckernN4096SR44100.wav
 QspeckernN8192SR44100.wav
 QspeckernN2048SR48000.wav
 QspeckernN4096SR48000.wav

Only use the one for your output sampling rate. Bigger N means more stability and resolution but longer delay and higher average CPU cost. N= 2048 is a good tradeoff if you don't want to track over 1000Hz fundamentals. The 48000 SR files are untested and provided without any promises. 

in- the audio rate input signal
databufnum- you must provide the initialisation data required by Qitch. This in the form of a .wav file that must be loaded to a buffer (see examples below).  The data files should have come with this UGen. 
ampThreshold- Qitch outputs a 0 in hasFreq if the input amplitude is below this threshold. Same as original Pitch. 
algoflag- 0 means use just the constant Q template pattern matcher. 1 flags the refinement based on the phase estimate.
ampbufnum- you may provide an 11 component buffer with template amplitudes- see example below. 
minfreq- minimum output frequency in Hz
maxfreq- maximum output frequency in Hz

In technical terms, this UGen calculates an FFT, applying Brown and Puckette's efficient constant Q transform on a quartertone scale, base note F3= 174.6Hz. Cross correlation search leads to the best match for a harmonic spectrum grid with falling amplitude components. A further fine tuning takes place based on instantaneous frequency estimation (rate of change of phase) for the winning FFT bin. 

The algorithms are based on the following papers:
 
Judith C. Brown and Miller S. Puckette, 1992, An efficient algorithm for the calculation of a constant Q transform. Journal of the Acoustical Society of America. 92(5); 2698-701.
   
Judith C. Brown, 1992, Musical Fundamental Frequency Tracking Using a Pattern Recognition Method. Journal of the Acoustical Society of America. 92(3); 1394-402.
   
Judith C. Brown and Miller S. Puckette, 1993, A High-Resolution Fundamental Frequency Determination Based on Phase Changes of the Fourier Transform. Journal of the Acoustical Society of America. 94(2); 662-7.
         

Examples: (use headphones!)

s = Server.local;

//assumes data file is in SC home application directory; else provide full path
b = Buffer.read(s, "QspeckernN4096SR44100.wav"); 
//this line is absolutely essential! You must load the data required by the UGen! 

b.numFrames //it's not that much data


(
a= SynthDef("testqitch",{arg infreq=440;
	var in, freq, hasFreq, out;
	
	in=SinOsc.ar(infreq);
	
	# freq, hasFreq = Qitch.kr(in, b.bufnum,0.01,1);
	
	Out.ar(0,[SinOsc.ar(freq,0.1),in]);
}).play(s);
)

a.set(\infreq,237);



c=Buffer.read(s,"/Volumes/data/audio/nikkisitar/warmup.wav"); //sitar test file, try anything you have on your disk

c.numFrames

( //sample tracking
SynthDef("pitchFollow1",{
	var in, amp, freq, hasFreq, out;
	
	in = PlayBuf.ar(1,c.bufnum, loop:1);
	amp = Amplitude.kr(in, 0.05, 0.05);
	
	# freq, hasFreq = Qitch.kr(in, b.bufnum, 0.1,1, -1,261, 800 );
	
	out = Mix.new(VarSaw.ar(freq * [0.5,1,2], 0, LFNoise1.kr(0.3,0.1,0.1), amp));
	
	Out.ar(0,[out,in])
}).play(s);
)


b = Buffer.read(s, "QspeckernN2048SR44100.wav"); //quicker response with this data set

d = Buffer.alloc(s,11); //make an amp template
d.setn(0, [1,0.98,0.92,0.88,0.84,0.8,0.76,0.72,1.68,1.64,1.6]); //must have 11 components

//analogous to example in the Pitch helpfile 
(
SynthDef("pitchFollow1",{
	var in, amp, freq, hasFreq, out;
	in = Mix.new(AudioIn.ar([1,2]));
	amp = Amplitude.kr(in, 0.05, 0.05);
	# freq, hasFreq = Qitch.kr(in, b.bufnum, 0.02, 1, d.bufnum, 160, 880);
	
	//freq = Lag.kr(freq.cpsmidi.round(1).midicps, 0.05);
	out = Mix.new(VarSaw.ar(freq * [0.5,1,2], 0, LFNoise1.kr(0.3,0.1,0.1), amp));
	6.do({
		out = AllpassN.ar(out, 0.040, [0.040.rand,0.040.rand], 2)
	});
	Out.ar(0,out)
}).play(s);
)






