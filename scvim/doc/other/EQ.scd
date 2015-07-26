

s.boot;
// LoShelf
(
Patch({ arg bypass=0, ffreq=120.0, boostcut=0.0, amp=0.1;
	var dry, filter;
	
	dry = AudioIn.ar([1,2]);
	
	filter = LoShelf.ar(dry, ffreq, boostcut.dbamp);
	
	((dry * bypass) + (filter * (bypass < 0.5))) * amp;
}).gui
)

// HiShelf
(
Patch({ arg bypass=0, ffreq=2200.0, boostcut=0.0, amp=0.1;
	var dry, filter;
	
	dry = AudioIn.ar([1,2]);
	
	filter = HiShelf.ar(dry, ffreq, boostcut.dbamp);
	
	((dry * bypass) + (filter * (bypass < 0.5))) * amp;
}).gui
)

// Tone
(
Patch({ arg bypass=0, tone=0.0, amp=0.1;
	var dry, filter;
	
	dry = AudioIn.ar([1,2]);
	
	filter = Tone.ar(dry, tone.dbamp) * (bypass < 0.5);
	
	((dry * bypass) + filter) * amp;
}, [
	nil,
	KrKnobEditor.new(0.0, \boostcut),
	nil
]).gui
)
