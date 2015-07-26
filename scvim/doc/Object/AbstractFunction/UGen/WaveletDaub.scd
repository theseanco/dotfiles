
WaveletDaub		decomposition into Daub4 wavelets, and reconstruction

WaveletDaub.ar(input, n=64, which=0, mul = 1.0, add = 0.0)

Wavelet transform using the Daub4 basis. 

The plug-in demonstrates the transform in the context of a filter; choose how many of the n basis elements to use in the reconstruction. 

input- Original signal to effect
n- size of wavelet transform. Must be divisible by 64, the standard blocksize.
which-  Basis elements whose indices are below this number will be zeroed. The default 0 means the identity transform, all basis elements will be used in the reconstruction. 



{var n= 1024; WaveletDaub.ar(SoundIn.ar, n, MouseX.kr(0,n))}.play

{var n= 1024; WaveletDaub.ar(Saw.ar(MouseY.kr(50,10000, 'exponential'),0.5), n, MouseX.kr(0,n))}.play




