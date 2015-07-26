
NdefPreset 		storing and morphing between presets for NodeProxies / Ndefs.

superclass: ProxyPreset.
ToDo 
	- write a xfade method for automated crossfades
	- write tests and help files for TdefPreset and PdefPreset. 
	

Creation / Class Methods

	*new (proxy, settings)	make a preset for an Ndef or nodeproxy
	
		proxy - the nodeproxy.
		settings - settings to use with the preset, if any.
				settings are typically stored to disk next to the patch itself.

	// make an Ndef
s.boot;
(
Spec.add(\dens, [1, 1000, \exp]);
Spec.add(\ring, [0.0001, 100, \exp]);

a = Ndef(\a, { |freq=300, dens=10, ring = 0.03, amp= 0.25| 
	Ringz.ar(Dust.ar(dens ! 2, (1/dens.max(1)).sqrt * amp), (freq * [1.01, 0.99]).lag(0.2), ring) 
}).play;

	// make a preset for Ndef(\a)
	// - stored by the Ndef's name in NdefPreset.all
z = NdefPreset(Ndef(\a));

w = Window("NdefPreset test", Rect(200, 200, 420, 250)).front;
w.addFlowLayout;
	// a gui for the NdefPreset
g = ProxyPresetGui(z, parent: w);
	// and one for the Ndef
b = NdefGui(a, 8, parent: w);
)

	*all		where all NdefPreset instances are stored by name.
			name is usually inferred from the proxy. 

	NdefPreset.all;
	NdefPreset.all[\a].dump;


Instance Variables
	
	proxy	the Ndef for which settings are stored.

z.proxy

	settings	the settings stored for the Ndef.
		
z.settings;


(		// add 3 settings to the list
a.set(\freq, 1000, \dens, 10, \amp, 0.15, \ring, 0.1);
z.addSet(\ada);
a.set(\freq, 1500, \dens, 30, \amp, 0.25, \ring, 0.05);
z.addSet(\bebe);
a.set(\freq, 2500, \dens, 30, \ring, 0.02, \amp, 0.1);
z.addSet(\coco);
)
	// these are all the settings now:
z.settings.printcsAll; "";


	morphVal		the current setting of the interpolation

z.morphVal;


Instance Methods

		Handling settings:

	postSettings	
	
	z.postSettings

	addSet (name, values, toDisk)	add one setting, usually the proxy's current setting.
	
		name - the name under which to add. default is "set1", "set2", etc.
		values - the name/value pairs to store. if nil, the current proxy values are stored.
		toDisk - a flag whether to write settings to disk as well.
		
		z.addSet(\blong, [\freq, 666]);

	addSettings (list)	add a list of settings. 
		
		list - list of name/value pairs.

		z.addSettings([\blong -> [\freq, 666], \kling -> [\freq, 999]]);
		

	removeSet (name)			remove a setting by name
	
		name - Explanation of name. Default value is nil. Other information.
		
		// inline example
		z.removeSet(\kling);

	removeSettings (names)
	
		Short prose description of method.
		names - Explanation of names. Default value is nil. Other information.

		z.removeSettings([\kling, \blong]);

	storeDialog (name)		convenience method to add setting by name.
			
		z.storeDialog


	deleteDialog (name) 	convenience method to remove settings
		
		z.deleteDialog
		

	currSet	the currently active setting. A list of [[name, value], [name, value] ... ].


z.currSet;
z.setCurr(\ada);
z.currSet;

	targSet	a second setting used for interpolation.

z.targSet;
z.setTarg(\bebe);
z.targSet;

	stepCurr(incr)

z.stepCurr(1); // step thru presets, up or down by increment
z.stepCurr(-1); // one down

	stepTarg(incr)
	
z.stepTarg(1); // step thru presets, up or down by increment
z.stepTarg(-1); // one down



		Finding settings by name or index: 
		
	keys, getIndex, getSet	
	currIndex, targIndex

z.keys;
z.getIndex(\coco);
z.getSet(\bebe);
z.currIndex;
z.targIndex;


		Synching from/to the proxy
	
	getFromProxy		ask the proxy for its current settings.
		
		z.getFromProxy

	currFromProxy	set the presets current setting from the proxy's setting.		

		z.currFromProxy

	setProxy (name)	set the proxy from a named setting
			
		z.setProxy(\coco);


		Randomizing presets 
(
// morphing and randomizing settings require specs for all params!
Spec.add(\dens, [1, 1000, \exp]);
Spec.add(\ring, [0.0001, 100, \exp]);
)

	randSet (rand, startSet, except)
	
		Generate a more or less randomized setting based on a named setting
		rand - By how much to randomize Default value is 0.25, a qurter of the spec range. 
		startSet - which set to vary. by default this is currSet.
		except - keys to except from variation.
		
			// except not working yet
		z.randSet(0.1, \ada, [\ring]);


	setRand (rand, startSet, except)
	
		Randomize a setting by some amount, and make it current.
		rand -  how much to vary (0.0 is no change, 1.0 is full range)
		startSet - which set to start with
		except - which keys not to vary
		
		z.setRand(0.03);

	someRand (rand, ratio)
	
		randomize some of the named values by some amount
		rand - how much to vary the values (from 0.0 to 1.0)
		ratio - which percentage (from 0.0 to 1.0) of the values to vary.
		
		z.someRand(0.5, 0.5)


		Morphing between presets:


	prepMorph	used internally.

	morph (val, name1, name2, mapped)	// morph between two named setting by a blend value.
	
		blend	- blend value between 0 and 1 - 0.0 is all name1, 1.0 is all name2
		name1 	- the left setting
		name2 	- the right setting
		mapped 	- a flag whether to interpolate by mapping/unmapping thru specs. 
				requires specs to be globally or locally present.
		
		// creates that setting, and sets proxy
		z.morph(0.0, \ada, \coco);
		z.morph(0.1, \ada, \coco);
		z.morph(0.3, \ada, \coco);
		z.morph(0.5, \ada, \coco);
		z.morph(1.0, \ada, \coco);
		z.morph(0.5, \ada, \coco);


	xfadeTo (target, dur)
	
		Short prose description of method.
		target - Explanation of target. Default value is nil. Other information.
		dur - Explanation of dur. Default value is nil. Other information.
		
		// inline example
		z.xfadeTo(\ada, 2);
		z.xfadeTo(\coco, 10);
		z.xfadeTo(\bebe, 2);


	blend (blend, name1, name2, mapped)	create a blend between settings name1 and name2
	
		blend 	- blend value between 0 and 1 - 0.0 is all name1, 1.0 is all name2
		name1 	- the left setting
		name2 	- the right setting
		mapped 	- a flag whether to interpolate by mapping/unmapping thru specs. 
				requires specs to be globally or locally present.
		
		// just creates that setting, does not set proxy
		z.blend(0.5, \ada, \coco);


		/////////////////// TO BE CONTINUED ////////////////
//	blendSets (blend, set1, set2)
//	
//		Short prose description of method.
//		blend - Explanation of blend. Default value is 0.500000. Other information.
//		set1 - Explanation of set1. Default value is nil. Other information.
//		set2 - Explanation of set2. Default value is nil. Other information.
//		
//		// inline example
//		g = ProxyPreset.blendSets;
//		g.doSomething; // explanation
//		g.cleanUpMethod;
//
//	specs
//		
//		Explanation including the type of specs and a link to its help file.
//		Default value is nil.
//
//	morphDur
//		
//		Explanation including the type of morphDur and a link to its help file.
//		Default value is nil.
//				
//	morphTask
//		
//		Explanation including the type of morphTask and a link to its help file.
//		Default value is nil.
//
//	dt
//		
//		Explanation including the type of dt and a link to its help file.
//		Default value is nil.
//
//								
//	mapSet (set)
//	
//		Short prose description of method.
//		set - Explanation of set. Default value is nil. Other information.
//		
//		// inline example
//		g = ProxyPreset.mapSet;
//		g.doSomething; // explanation
//		g.cleanUpMethod;
//
//
//	unmapSet (set)
//	
//		Short prose description of method.
//		set - Explanation of set. Default value is nil. Other information.
//		
//		// inline example
//		g = ProxyPreset.unmapSet;
//		g.doSomething; // explanation
//		g.cleanUpMethod;
//	
//		z.prepMorph;
//
//z.morphVal = 0.8;
//
//	// morph from one to the other:
//fork { 20.do { |i| 0.1.wait; z.morph(i + 1/ 20, \curr, \ada) } };
//
//
//z.removeSet(\set1); 
//z.removeSettings([\ada]); 
//z.settings;
//
//z.storeDialog;
//z.deleteDialog;
//
//z.randSet(rand: 0.01);	// make a randomized setting
//z.setRand(rand: 0.1, startSet: \curr);	// vary based on a given set;
//z.setRand(rand: 0.1, startSet: \set1, except: [\amp]);	// dont change amp
//
//
///* interpolation tests:
//
//	// unmap a set
//x = z.unmapSet(z.getSet(\bebe).value);
//
//	// unmap a second set
//y = z.unmapSet(z.getSet(\coco).value);
//
//	// does not check for names yet!
//z.blendSets(0.5, x, y);
//
//z.blend(0.2, \bebe, \coco);
//a.set(*z.blend(1.0.rand, \bebe, \coco).flat);
//
//	// interpolate
//fork { 20.do { |i| 0.1.wait; a.set(*z.blend(i + 1/ 20, \bebe, \coco).flat) } };
//
//fork { 20.do { |i| 0.1.wait; z.morph(i + 1/ 20, \coco, \bebe) } };
//
//*/
//
//
//
//		Storing settings to disk:
//		
//	storePath_(arg1)
//	storePath
//		
//		Explanation including the type of storePath and a link to its help file.
//		Default value is nil.
//
//	setPath (name)
//	
//		Short prose description of method.
//		name - Explanation of name. Default value is nil. Other information.
//		
//		// inline example
//		g = ProxyPreset.setPath;
//		g.doSomething; // explanation
//		g.cleanUpMethod;
//
//
//	presetPath (name)
//	
//		Short prose description of method.
//		name - Explanation of name. Default value is nil. Other information.
//		
//		// inline example
//		g = ProxyPreset.presetPath;
//		g.doSomething; // explanation
//		g.cleanUpMethod;
//
//
//	loadSettings (path, clear)
//	
//		Short prose description of method.
//		path - Explanation of path. Default value is nil. Other information.
//		clear - Explanation of clear. Default value is false. Other information.
//		
//		// inline example
//		g = ProxyPreset.loadSettings;
//		g.doSomething; // explanation
//		g.cleanUpMethod;
//
//
//	writeSettings (path, overwrite)
//	
//		Short prose description of method.
//		path - Explanation of path. Default value is nil. Other information.
//		overwrite - Explanation of overwrite. Default value is false. Other information.
//		
//		// inline example
//		g = ProxyPreset.writeSettings;
//		g.doSomething; // explanation
//		g.cleanUpMethod;
//
//	storeToDisk
//		
//		Explanation including the type of storeToDisk and a link to its help file.
//		Default value is nil.


