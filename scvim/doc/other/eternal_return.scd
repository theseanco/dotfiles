





// eternal return. 
// nonlinear history for live and experimental just in time programming.
// Julian Rohrhuber 2007

/*


This program will give access to any ProxySpace (or subclass of LazyEnvir / EnvironmentRedirect) that is present as current environment. If none is present, it will create a ProxySpace and push it.

It creates a document window with some temporal navigations. 
This document is a throw away GUI, it can be closed anytime.

- the black stripe is the current time. here the edits become visible.
- the first number box is the current time
- the last number box represents the length of history, after which we return to beginning

Buttons:
_	navigate in time without entering it (toggles)
->	start time / stop time (toggles)
<<	rewind to beginning of time
:<	step back to previous edit
>:	step forward to next edit	
<	backward 0.25 sec in time
>	forward 0.25 sec in time
#	post the complete history


*/


(


	var w, txt, value = 0, mapVal, valMap, b2, scaledValue = 0, tmax = 30, delta = 0.25;
	var ff, fne, fla, fba, fne2, fla2, m,  v, vv, mmax, task, changed, running = false;
	var drawLine, playRout, windowFollow,toggleHistory, dispatch, onTime = false;
	var browseBut, browseMode = false;
	var nietzsche, temporaryPseudoEnvironment, proxyspace;
	
	temporaryPseudoEnvironment = EnvironmentRedirect.new;
	
	b2 = Rect(10, 10, 340, 20);
	w = GUI.window.new("---", Rect(128, 64, 640, 30));
	w.view.decorator = FlowLayout( w.view.bounds );
	
	
	running = { task.isPlaying };
	toggleHistory = {
		if(running.value) { task.play(AppClock) } { task.stop };
	};
	
	
	
	// get the next appropriate point in time,
	// either the next delta step, or, if closer, the next timepoint
	task = Task {
		var nextDelta, nextIndex;
		loop {
			nextIndex = dispatch.timepoints.indexOfGreaterThan(scaledValue);
			if(nextIndex.isNil) {
				if(dispatch.timepoints.last.notNil 
					and: {dispatch.timepoints.last >= (scaledValue + delta)}) {
					nextDelta = tmax - scaledValue;
				} {
					nextDelta = delta
				}
			} {
				nextDelta = min(delta, dispatch.timepoints.at(nextIndex) - scaledValue);
			};
			scaledValue = (scaledValue + nextDelta % tmax);
			valMap.(scaledValue);
			nextDelta.wait;
		}
	
	};
	if(currentEnvironment.isKindOf(EnvironmentRedirect).not) {
		proxyspace = p = ProxySpace.push(s.boot);
	} {
		proxyspace = currentEnvironment;
	};
	dispatch = proxyspace.dispatch;
	if(dispatch.isNil) {


		proxyspace.dispatch = dispatch = HistoryDispatch.new;
	};
	dispatch.manual = true;
	dispatch.alwaysReplace = false;


	
	changed = { |val| 
		var str, envir, changed, pairs;
		envir = dispatch.envir;
		if(browseMode) {
			pairs = dispatch.getPairsForTime(val);
			if(pairs.isNil) { d.string = "" } {
				d.string = pairs.collect { |pair|
						format("\n~% = %;\n\n", pair[0], pair[1].asCompileString)
					}.join;
			};
		} {
			changed = dispatch.setTime(val);
			if(changed) {
				str = dispatch.envir.asCompileString;
				d. string_( String.streamContents { arg str; 
					envir.storeOn(str, includeSettings: false); 
				});
			}
		};
	};
	
	
	
	drawLine = { |x, inset=0|
			GUI.pen.beginPath;
			GUI.pen.moveTo(x @ (5 + inset));
			GUI.pen.lineTo(x @ (vv.bounds.height + 5 - inset));
			GUI.pen.stroke;
	};
	w.drawHook_{
		GUI.pen.use {	
			GUI.pen.setSmoothing(false);
			GUI.pen.width = 1;
			
			Color.white.set;
			drawLine.(value, 0);
			
			Color.new255(230, 123, 155).set;
			dispatch.timepoints.do {|x=(0)|
				x = x.clip(0, tmax);
				drawLine.(x / tmax * vv.bounds.width + vv.bounds.left, 3);
			};

		};
	};
	
	mapVal = {|x|
			if(x.inclusivelyBetween(vv.bounds.left, vv.bounds.left + vv.bounds.width)) {
				value = x;
				scaledValue = x - vv.bounds.left / vv.bounds.width * tmax;
				m.value = scaledValue;
				//onTime = dispatch.timepoints.includes(scaledValue);
				w.refresh;
			}
	};
	
	valMap = {|x|
			if(x.notNil) {
				x = x.clip(0, tmax);
				m.value = scaledValue = x;
				value = x / tmax * vv.bounds.width + vv.bounds.left;
				changed.value(scaledValue);
			//	onTime = timepoints.includes(scaledValue);
				w.refresh;
			}
	};
	vv = GUI.compositeView.new(w, b2).background_(Color.black);
	v = GUI.userView.new(vv, Rect(0, 0, w.bounds.width, w.bounds.height))
		
		.mouseMoveAction_({|v,x| mapVal.value(x) })
		.mouseUpAction_({|v,x| mapVal.value(x); changed.value(scaledValue); })
		.mouseDownAction_({|v,x| mapVal.value(x); });
	
	
	m = GUI.numberBox.new(w, Rect(0, 0, 40, 20));
	m.value = 0;
	m.action = { valMap.value(m.value) };
	
	vv.keyDownAction = { |v, char|
		char.postln;
		if(char == $ , toggleHistory);
	};

	browseBut = GUI.button.new(w, Rect(0, 0, 20, 20))
		.states_([["_", Color.black], ["-", Color.black]])
		.action_({|b| 
			browseMode = b.value == 1;
			if(b.value == 0) {
				valMap.(scaledValue);
			//	currentEnvironment = proxyspace;
			//	proxyspace.dispatch = dispatch;
			} {
			//	currentEnvironment = temporaryPseudoEnvironment;
			//	temporaryPseudoEnvironment.dispatch = dispatch;
			};
			d.background = [Color.white, Color.grey(0.8)][b.value];
		});

	ff = GUI.button.new(w, Rect(0, 0, 20, 20)).states_([["->", Color.black], ["||", Color.red]]);
	
	fba = GUI.button.new(w, Rect(0, 0, 20, 20)).states_([["<<", Color.black]]);
	
	fla = GUI.button.new(w, Rect(0, 0, 20, 20)).states_([[":<", Color.black]]);
	fne = GUI.button.new(w, Rect(0, 0, 20, 20)).states_([[">:", Color.black]]);
	
	fla2 = GUI.button.new(w, Rect(0, 0, 20, 20)).states_([["<", Color.black]]);
	fne2 = GUI.button.new(w, Rect(0, 0, 20, 20)).states_([[">", Color.black]]);
	
	ff.action = { if(ff.value == 1) { task.play(AppClock);  } { task.stop } };
	fba.action = { valMap.(0.0) };
	fne.action = { 
		i = dispatch.timepoints.indexOfGreaterThan(scaledValue) ? 0; 
		valMap.(dispatch.timepoints.at(i))
	 };
	fla.action = { 
		i = dispatch.timepoints.indexOfGreaterThan(scaledValue - 0.01);
		i = i ? dispatch.timepoints.lastIndex;
		if(i.notNil and: { i > 0 }) {
			valMap.(dispatch.timepoints.wrapAt(i-1))
		}
	};
	
	fne2.action = { 
		valMap.(scaledValue + delta % tmax)
	 };
	fla2.action = {
		valMap.(scaledValue - delta  % tmax)
	};
	
	
	GUI.button.new(w, Rect(0, 0, 20, 20)).states_([["#", Color.black]])
		.action_({dispatch.document});
	
	mmax = GUI.numberBox.new(w, Rect(0, 0, 40, 20));
	mmax.value = tmax;
	mmax.action = { tmax = mmax.value; valMap.(scaledValue); };
	
	
	GUI.button.new(w, Rect(0, 0, 20, 20)).states_([["$", Color.black]])
		.action_({ 
				dispatch.removeAllAtTime(scaledValue);
				changed.(scaledValue);
				w.refresh;
		});
	w.front;
	d = Document.new("history doc").bounds_(Rect(20, 280, 670, 481));
	d.onClose = { w.close; windowFollow.stop; CmdPeriod.remove(playRout); };
	w.onClose = { windowFollow.stop; CmdPeriod.remove(playRout); };
	d.toFrontAction = d.toFrontAction.addFunc {
		if(w.isClosed.not) { ff.valueAction = 0 };
	};
	nietzsche = #["Alles Laufenkoennen muss gelaufen sein", "Der Torweg muss auch gelaufen sein", "Der Augenblick zieht alles nach sich, auch sich selbst", "Alles Laufenkoennen muss noch laufen", "Out of damp and gloomy days, out of solitude, out of loveless words directed at us, conclusions grow in us like fungus: one morning they are there, we do not know how, and they gaze upon us.", "Woe to the thinker who is not the gardener but only the soil of the plants that grow up in him!"];
	windowFollow = Routine { 
		var x;
		loop {
		0.06.wait;
		if(d.bounds != x) {


		 	w.bounds = 
		 	Rect(d.bounds.left, d.bounds.top + d.bounds.height, d.bounds.width, w.bounds.height);
		 	if(0.3.coin) { nietzsche.choose.postln };
		 	 
		 	 w.front;
		 	 0.01.wait;
		 	 d.front;
			
		 };
		 x = d.bounds;
		
		  0.3.wait;
		}
	
	};
	playRout = { windowFollow.play(AppClock) };
	CmdPeriod.add(playRout);
	
	playRout.value;
	valMap.value(0);
	

)
