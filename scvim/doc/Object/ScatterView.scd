
ScatterView
2005 by till bovermann
bielefeld university

plots a dataset into a view.

*new (parent, bounds, data, specX, specY)
	returns a new ScatterView
	parent	the Parent GUI element
	bounds	the bounds (a Rect)
	data		the data; format: [[aX, aY],[bX, bY],[cX, cY],[dx, dy], ... ]
	specX	the ControlSpec indicating the Specification of the X-Axis
	specY	the ControlSpec indicating the Specification of the Y-Axis


background(color)
	set background-color
	
symbolColor(color)
	set color of symbols
	
drawMethod(aSymbol)
	set the method used to draw an item; either
	aSymbol	one of \fillRect, \fillOval, \lineTo

isHighlight(bool)
	switch for highlight on/off
	
highlightItem(index)
	set item to be highlighted.
	Index could be either index or array of indices.
	
highlightItemRel(val)
	set highlighted item relative
	val	in [0 .. 1.0]
	
highlightSize(point)
	set highlight extend
	
highlightColor(color)
	set color of highlighted item

Examples

// you may want to use Swing or Cocoa
SwingOSC.default.boot
GUI.swing


(
var data = 1000.collect{ [1.0.rand, exprand(0.01, 1)]};
w = GUI.window.new(bounds: Rect(40, 40, 800, 800)).front;
a = ScatterView(w, Rect(10, 10, 760, 760), data, [0,1].asSpec, [0,1].asSpec);
a.drawAxis_(true).drawMethod_(\fillOval)
	.symbolColor_(Color.blue(0.5, 0.5)).symbolSize_(5)
	.xAxisName_("uniform").yAxisName_("exponential");
)

(
var numItems = 630;
w = GUI.window.new(bounds: Rect(40, 40, 800, 150)).front;
a = ScatterView(w, Rect(10, 10, 760, 100), {|i| [sin(i/50), sin(0.05*i)]}!numItems, [-1,1].asSpec, [-1,1].asSpec);
a.isHighlight = true;
GUI.slider.new(w, Rect(10, 120, 760, 20)).action_{|me|
	a.highlightItemRel = me.value;
	a.refresh;
	// a.highlightItem = (me.value*numItems).asInteger.min(numItems-1);
};
a.drawMethod = \lineTo;
a.symbolColor = Color.blue(0.7, 0.3);
a.highlightSize = 10@10;
a.refresh;
)


a.highlightItem = (1, 3..99);
w.refresh;
a.highlightRangeRel(0, 0.3);
w.refresh;
a.highlightRange(0, 100);
w.refresh;

(
a.symbolSize = 30@3;
a.drawMethod = \strokeOval;
a.isHighlight = false;
w.refresh;
)

a.symbolColor = Color.red(0.2, 0.2);
w.refresh

// dynamics
(
l = {inf.do{|i|
	a.symbolSize = (cos(i*0.1)*40+3)@(cos(i*0.1+1)*40+3);
	{w.refresh}.defer;
	0.1.wait;
}}.fork
)
l.stop;
// end dynamics

(
a.background = Color.gray(1,0.5);
a.isHighlight = true;
a.highlightSize = 6000@500;
a.highlightColor = Color.green;
a.symbolSize = 1;
a.drawMethod = \lineTo;
w.refresh;
)


// reset the Data
(
a.data = {|i| [cos(i/50), sin(0.05*i)]}!150;
w.refresh;
)

// use other drawMethods
a.drawMethod = \fillOval;
w.refresh


// use two views stacked
(
var numItems = 630;
w = SCWindow.new(bounds: Rect(40, 40, 800, 150)).front;
a = ScatterView(w, Rect(10, 10, 760, 100), {|i| [sin(i/50), sin(0.05*i)]}!numItems, [-1,1].asSpec, [-1,1].asSpec);
b = ScatterView(w, Rect(10, 10, 760, 100), {|i| [sin(i/21), sin(0.05*i)]}!numItems, [-1,1].asSpec, [-1,1].asSpec);
a.background = Color.gray(0, 0);
a.isHighlight = true;
SCSlider(w, Rect(10, 120, 760, 10)).action_{|me|
	a.highlightItemRel = me.value;
	w.refresh;
	//a.highlightItem = (me.value*numItems).asInteger.min(numItems-1);
};
a.drawMethod = \lineTo;
a.symbolColor = Color.blue(0.7, 0.3);
a.highlightSize = 10@10;
w.refresh;
)




(
var numItems = 630;
w = SCWindow.new(bounds: Rect(40, 40, 800, 150)).front;
a = ScatterView(w, Rect(10, 10, 760, 100), {|i| [sin(i/50), sin(0.05*i)]}!numItems, [-1,1].asSpec, [-1,1].asSpec);
a.isHighlight = true;
SCRangeSlider(w, Rect(10, 120, 760, 10)).action_{|me|
	a.highlightRangeRel(me.lo, me.hi);
	w.refresh;
	// a.highlightItem = (me.value*numItems).asInteger.min(numItems-1);
};
a.drawMethod = \lineTo;
a.symbolColor = Color.blue(0.7, 0.3);
a.highlightSize = 10@10;
w.refresh;
)


