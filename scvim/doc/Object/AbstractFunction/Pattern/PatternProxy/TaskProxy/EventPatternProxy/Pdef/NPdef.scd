
NPdef
a shortcut for a Pdef controlling a node proxy
Inherits from:: Object : AbstractFunction : Pattern : PatternProxy : TaskProxy : EventPatternProxy : Pdef
NPdef creates a shortcut for creating a Pdef that controls a NodeProxy. Instead of sending arguments directly to the server, this uses the 'npset' event type, which uses the set method of the NodeProxy.
After you have created an NPdef, you can also access it by using Pdef and the symbol of the nodeproxy's variable name (at least in proxyspace).
Since the actual lookup is done in the Pdef's dictionary, you can easily interchange NPdef and NPxdef with one another, to change the event type. 
See also NPxdef which is similar but crossfades.
Creation / Class Methods
*initClass
This adds the event type 'npset' to the list of possible events.
*new(proxy,src)
Create an instance of NPdef, or access an old one, if one with the same name already exists.
proxy
The nodeproxy, which you want to control with this pattern stream. This pattern is chained to ( type: 'npset', id: 'proxy')
src
The pattern (Pbind or so)
The event type 'npset''
The event type 'npset' is used to set arguments of a NodeProxy. The key id should be used to indicate which NodeProxy is going to be controlled. It automatically checks which arguments are relevant to the NodeProxy and only sets these, using the method set of NodeProxy.
Example 1
s.boot;
p = ProxySpace.push(s);

~sine = { |freq=300| SinOsc.ar( freq, 0, 0.3 )};
~sine.play;

NPdef( ~sine, Pbind( \freq, Pseq( (3..10)*100, inf)));
Pdef(\sine).play;
Pdef(\sine).stop;
~sine.stop;

	// you can give the NPdef a different name/key:
NPdef( ~sine, Pbind( \freq, Pseq( (6..20)* 50, inf), \dur, 0.25), key: \sineFast);
~sine.play;
Pdef(\sineFast).play;
Pdef(\sineFast).stop;
~sine.stop;

p.free;

	// with Ndefs: 
Ndef(\imp, { |freq=300| LPF.ar(Impulse.ar( freq ), 1500)}).play;
NPdef( Ndef(\imp), Pbind( \freq, Pseq( (3..10)*100, inf)));
Pdef(\imp).play;
Pdef(\imp).stop;

	// you can give the NPdef a different name/key: 
NPdef( Ndef(\imp), Pbind( \freq, Pseq( (3..10)*100, inf), \dur, 0.2), key: \impCtl);
Pdef(\impCtl).play;
Ndef(\imp).end;
 
This helpfile was created with the class HelpFile2


