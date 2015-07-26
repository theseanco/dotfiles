
EnvFollow			Envelope Follower

EnvFollow.ar(input, decaycoeff, mul, add )

Envelope follower from Hoffmann and Cook 2008 DAFx paper. 



{ var source = SinOsc.ar(40); var env = EnvFollow.ar(source, 0.999); [source,env] }.plot(0.5)


{ var source = SoundIn.ar; var env = EnvFollow.ar(source, MouseX.kr(0.9,0.999)); env }.play


