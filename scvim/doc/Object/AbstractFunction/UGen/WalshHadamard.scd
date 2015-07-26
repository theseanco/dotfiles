
WalshHadamard		decomposition into square waves, and reconstruction

WalshHadamard.ar(input, which=0, mul = 1.0, add = 0.0)

WalshHadamard transform to a basis of square wave like functions rather than the more conventional sine waves of Fourier analysis. The advantage is that the transform is really efficient (no need for trignometic functions) but the interpretation in a space of 'sequencies' and amplitudes is less intuitively comprehensible. 

The plug-in demonstrates the transform in the context of a filter; choose how many of the 64 basis elements to use in the reconstruction. 64 corresponds to the standard block size.  

input- Original signal to effect
which-  Basis elements whose Indices are below this number will be zeroed. The default 0 means the identity transform, all basis elements will be used in the reconstruction. 


{WalshHadamard.ar(SoundIn.ar, MouseX.kr(0,64))}.play




