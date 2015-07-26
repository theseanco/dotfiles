
ProxyChain  		playing multiple synth and filter functions flexibly in one proxy



ProxyChain keeps a global repertoire of sound functions by name. 
A ProxyChain has an ordered collection of sound functions and uses a nodeproxy 
to add or remove the sound functions to/from the signal chain individually, by name.

Like Ndef, Pdef, Tdef, ProxyChain keeps all named instances in a class variable "all".
ProxyChain(<name>) accesses a ProxyChain by name, 
ProxyChain(<name>, slotNames, ... ) puts a new instance there. 

See also Ndef, NodeProxy, - especially filtering, ProxyChainGui



	*add(name, func, name, func, ... )		add globally available functions to ProxyChain.allSources.

(
q = q ? ();

q.numChans = 5; 

		// add a sound source
ProxyChain.add(
	\dust, \mix -> { |dens=20, dustdec=0.02, dustfreq= 600| 
		Ringz.ar(Dust.ar(dens).lag(0.0001), dustfreq, dustdec) 
	}
);

		// an association with \filter becomes a filter,
		// and creates a wet/dry balance on the output.
		// several funcs can be added as key1, func1, key2, type -> func2, etc.
ProxyChain.add(	
	\ringmod, \filter -> { |in, randrate=5| 
		in.asArray[0] 	// force mono inputs
		* SinOsc.ar(LFNoise0.kr([randrate, randrate]).exprange(300, 3000)).sum 
	}, 
	\dist, \filter -> { |in, drive=10, amp=0.2| (in.asArray[0] * drive).clip2(0.5) * amp }
);
	
		// an association with \filterIn also becomes a filter,
		// but creates the wet/dry balance control on the filter input, 
		// on on the output like \filter. this can be useful for delays, reverbs etc.
ProxyChain.add(
	\riseComb5, \filterIn -> { arg in, delay = 0.023, dlDrift = 0.02, spread=0.5, 
		decayRise=0.5, decayFall=100;
		
		var delayscales = 2 ** ((0 .. q.numChans - 1) * 2 / (q.numChans - 1) - 1 * spread); 
		
		var dels = delayscales.scramble.collect { |dscale| 
		
			var timedrift = LFDNoise3.kr(0.3, dlDrift, 1) * dscale;
			var ampcomp = (20 * decayRise).dbamp * (decayFall ** -0.25);
			
			var combs; 
			in = in.asArray[0] * ampcomp.lag(0.2);
			combs = (decayFall * [ 1, decayRise]).collect { |decay| 
				CombL.ar(in, 1, delay * dscale, decay * delay) 
			};
			combs[0] - combs[1];	// combs come in slowly, like formlet. 
			
		};
		Splay.ar(dels)
	}, 
	\ampFin, \filter -> { |in, drive=1, ampLimit=1, lAmp=1| 
		Limiter.ar(in * drive, ampLimit) * lAmp;
	}
);

	// add specs for the controls used (for NodeProxyEditor).
Spec.add(\dens, [0.1, 1000, \exp]);
Spec.add(\dustamp, [0, 1, \amp]);
Spec.add(\dustdec, [0.0001, 0.1, \exp]); 
Spec.add(\dustfreq, \freq); 

Spec.add(\dt, [0.001, 0.2, \exp]); 
Spec.add(\dc, [0.01, 100, \exp]); 

Spec.add(\drive, [1, 100, \exp]); 

Spec.add(\spread, [0, 1, \amp]); 
Spec.add(\decayRise, [0, 0.9, \amp]); 
Spec.add(\decayFall, [1, 1000, \exp]); 
Spec.add(\dlDrift, [0, 0.1, \amp]); 

s.boot;
)
	
	*new(key, slotNames, numChannels, server)
		create a ProxyChain with its own independent Nodeproxy.
		numChannels - of the proxy that is created automatically.
		slotNames - define which functions from ProxyChain.allSources will be available in what order.	

			// the functions can be sources (func, \mix -> func) 
			// or filters (\filter -> func, \filterIn -> func)
(
c = ProxyChain(\alpha, [\dust, \ringmod, \dist, \riseComb5, \test]);
c.play;	// play the proxy
g = c.gui(12);	// make a gui for it with 12 slots - see ProxyChainGui
)


	// these methods are passed through to the proxy:
c.play;
c.stop;
c.playN;
c.end(2);


	*from(proxy, slotNames)	make a proxychain from an existing NodeProxy or Ndef.
		
Ndef(\bla).ar(2);
ProxyChain.from(Ndef(\bla), [\dust, \ringmod, \dist, \riseComb5, \test]);
ProxyChain(\bla).play;
ProxyChain(\bla).add(\dust);

ProxyChain.all;

	add(key, wet)		add a sound or filter function, wet is dry/wet balance

c.add(\dust, 0.123);
c.add(\dust, 0.2);
c.add(\ringmod, 0.5);
c.add(\dist, 1);


	// the automatically generated mix/wet balance names are
	// "mix" for sources and "wet" for filters, with an added 
	// index of 10, 20, 30, etc. 

ProxyChain(\xyz, [
	\dust, 		// the first node is a source, so "mix", and here: "mix10",
	\ringmod, 	// filters become "wet", so here, "wet20"
	\dist		// and "wet30";
]);


c.proxy.fadeTime = 2;
c.add(\riseComb5, 0.2);		// \filterIn not show correctly in NodeProxyEditor yet.

// add a local version of a source -
// this overrides the global version of \dust.
(
c.add(\dust, nil, \mix -> { |dens=20, dustdec=0.02, dustfreq= 600| 
		Ringz.ar(Dust.ar(dens).lag(0.0001), dustfreq * [0.62, 1, 1.62], dustdec).mean 
	});
)
c.sources.postcs;
c.sources.put(\dust, nil);	// back to global dust
c.add(\dust);
c.sources.postcs;

	remove(key)		remove a sound or filter function.
	
c.remove(\dist);		// nodemap removes settings as well, so ...
c.remove(\ringmod);
c.remove(\riseComb5);	// sometimes misses current value - why?

c.slotNames;		// all slotnames that are available, in the order they are in;
c.slotsInUse;		// which ones are playing now?

c.remove(\dust);


	gui(name, buttonList, nSliders)
		make a ProxyChainGui window for controlling the slots, and possible additional functions.

	// by default, buttonList nil is replaced with control buttons for all slots.
c.gui(20);

	// if specified, can be friendlier
(
g = c.gui(20,
[ 	
	[ \generators, \label ],  	// a label only
	[ \dust, \slotCtl, 0.25 ], 		// a control for a slot, starting level

	[ '1 > 1', \label ],  
	[ \ringmod, \slotCtl ], 		// 0 - dry  by default
	[ \dist, \slotCtl, 1 ], 		// 1 - all wet

	[ '1 > 5', \label ],  
	[ \riseComb5, \slotCtl ], 
	[ ],
		// extras:
		// e.g. an editor with more space for controls
	[\phatEdit, \extra, { c.makeEdit('Test', 40) } ],
	
		// or maybe bigger buttons play, end buttons
	[\play, \extra, { c.playN } ],	 
	[\end, \extra, { c.end(2, true) } ],
	
]
)
)



///////////////// Possible next extensions //////////////// 

*	insert new slotNames by name, or remove existing slotnames, keeping the structure consistent; 
	for reconfiguration of the list of proxychain slots that can be used. 
	That would require a better gui where the buttons can be updated. 

	////////////// not done yet //////////
	
	// replace a slot given by name
c.replace(\dust, \noyz, mix ->  { |nfreq1=1200| LFDNoise0.ar(nfreq1) }); 


	insertAt(index, name, funcOrAssoc) 
		inserts in the chain at this index, 
		replaces if a slot exists there.

c.insertAt(5, \noyz, mix ->  { |nfreq2=1200| GrayNoise.ar(nfreq2) }); 

	insertAfter(index, name, funcOrAssoc) 
	insertBefore(index, name, funcOrAssoc) 
		inserts after (or before) a given slot - halfway toward the neighbour.
		e.g. 
c.insertAfter(\dust, \klong, \filter -> { |in, freq=400, att=0.01, decay=0.3, slope=0.8| 
	Formlet.ar(in, freq * [0.71, 1, 1.4], att, decay * [1/slope, 1, slope]).sum;
});

	// after which slot, name, funcOrAssoc; 
c.insertBefore(\dust, \klong, \filter -> { |in, freq=400, att=0.01, decay=0.3, slope=0.8| 
	Formlet.ar(in, freq * [0.71, 1, 1.4], att, decay * [1/slope, 1, slope]).sum;
});



