
SCEnvelopeEdit			envelope editor view


SCEnvelopeEdit.new(parent, bounds, env, pointsPerSegment)


SCEnvelopeEdit is a vector-based breakpoint editor for the Env class.  It takes an Env object as an argument that is modified from the GUI.  Changing properties of the Env object directly will not be reflected on the GUI.  You must call 'refresh' after doing this.  You cannot add breakpoints.

The breakpoints are color coded as follows:
	blue -	normal
	red -		sustain node
	green -	loop node

Public Methods:

refresh()
If the Env object is modified directly, this needs to be called to update the GUI.


minLevel_(float)
Changes minimum level shown in editor.

maxLevel_(float)
Changes maximum level shown in editor.

minTime_(float)
Changes minimum time (sec) shown in editor.  Negative times are okay because Env uses inter-node 
durations.

maxTime_(float)
Changes maximum time (sec) shown in editor.


(
// make a basic editor
e = Env.adsr;
w = SCWindow("Env Editor", Rect(200,200,300,200));
v = SCEnvelopeEdit(w, w.view.bounds.moveBy(20,20).resizeBy(-40,-40), e, 20).resize_(5);
w.front;
)

v.maxLevel_(2);	// to give more headroom
v.maxTime_(2);	// to increase release point
v.minTime_(-1);	// to increase attack time

e.curves = 'sin';	// env object is changed
v.refresh;		// must refresh editor




Controlling a Synth

s=Server.internal;

(
e = Env([0, 1, 0.7, 0.9, 0], [0.03, 0.03, 0.03, 0.03], 'sin');
f = Env([0, 1, 0.7, 0.9, 0], [0.03, 0.03, 0.03, 0.03], 'sin');
w = SCWindow("Shards", Rect(100, 100, 500, 400));
v = SCEnvelopeEdit(w, w.view.bounds.resizeBy(-20, -200), e, 10).resize_(2);

SCStaticText(w, v.bounds).string_(" amplitude").resize_(2);
x = SCEnvelopeEdit(w, v.bounds.moveBy(0, 200), f, 10).resize_(2);
SCStaticText(w, x.bounds).string_(" frequency").resize_(2);
w.front;
)

(
SynthDef("sineBlip", { 
	arg freq=440, vol=0.1, la0, la1, la2, la3, la4, ta0, ta1, ta2, ta3, crva,
		lf0, lf1, lf2, lf3, lf4, tf0, tf1, tf2, tf3, crvf;
	var signal, fenv, aenv;
	fenv = EnvGen.ar(Env([lf0,lf1,lf2,lf3,lf4],[tf0,tf1,tf2,tf3], crvf));
	aenv = EnvGen.ar(Env([la0,la1,la2,la3,la4],[ta0,ta1,ta2,ta3], crva), doneAction: 2);
	signal = SinOsc.ar([freq, freq*2] * fenv) * aenv * vol;
	Out.ar(0, signal.dup);
}).send(s);
)

(
Routine({
	var par, indices;
	indices = (2..21);
	loop({
		par = (indices +++ (v.env.levels ++ v.env.times ++ v.env.curves ++ x.env.levels ++ x.env.times ++ x.env.curves)).flatten;
		s.sendBundle(s.latency, [\s_new, "sineBlip", -1, 1, 1, \freq, exprand(4e3,11e3)] ++ par);
		0.04.wait;
	});
}).play;
)
