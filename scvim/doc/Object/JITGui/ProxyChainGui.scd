
ProxyChainGui 		a gui for ProxyChain


see also: ProxyChain 


		// prepare for making a proxy chain
(
q = ();
q.numChans = 2;

ProxyChain.add(
	\dust, \mix -> { |dens=20, dustdec=0.02, dustfreq= 600| 
		Ringz.ar(Dust.ar(dens).lag(0.0001), dustfreq, dustdec) 
	}
);

ProxyChain.add(	
	\ringmod, \filter -> { |in, randrate=5| 
		in.asArray[0] 	// force mono inputs
		* SinOsc.ar(LFNoise0.kr([randrate, randrate]).exprange(300, 3000)).sum 
	}, 
	\dist, \filter -> { |in, drive=10, amp=0.2| (in.asArray[0] * drive).clip2(0.5) * amp }
);
	// add specs for the controls used (for NodeProxyEditor).
Spec.add(\dens, [0.1, 1000, \exp]);
Spec.add(\dustamp, [0, 1, \amp]);
Spec.add(\dustdec, [0.0001, 0.1, \exp]); 
Spec.add(\dustfreq, \freq); 

c = ProxyChain(\test, [\dust, \ringmod, \dist, \riseComb5 ]);

s.boot;
)

	*new(chain, name, buttonList, nSliders)
		chain 		the proxychain to show 
		name 		the name the window will have
		buttonList		which buttons should be created. 
					by default, buttonList nil is replaced with control buttons for all the slots.
					if given, buttonList is in pairs of [label, type], where type can be 
					\slotCtl for a slot name, 
					\label for a label, 
					\extra for a button with a user-defined function.

g = ProxyChainGui.new(c, 12);
c.key.postcs;
c.proxy.key;

	// define buttons more specifically
(
g = c.gui(20, 
[ 	
	[ \generators, \label ],  	// a label only
	[ \dust, \slotCtl, 0.25 ], 		// a control for a slot, and initial volume

	[ 'mono FX', \label ],  
	[ \ringmod, \slotCtl, 0.5 ], 	// initial mix level
	[ \dist, \slotCtl ], 

	[ 'multichan', \label ],  		
	[ \riseComb5, \slotCtl ], 		// off (0) by default.
	[],
		// extras:
		// e.g. an editor with more space for controls
	[\phatEdit, \extra, { c.gui(40) } ],
	
		// or maybe bigger buttons play, end buttons
	[\play, \extra, { c.playN } ],	 
	[\end, \extra, { c.end } ],
	
]
)
)


