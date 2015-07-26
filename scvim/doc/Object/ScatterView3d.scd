
ScatterView3d
till bovermann, uni bielefeld 2006


GUI.swing
GUI.cocoa

(
var data;
data = {{2.0.rand2}!3}!150;
w = GUI.window.new("3D Scatterplot", Rect(40,40, 500, 500)).front;
a = ScatterView3d(w, Rect(10,10, 450, 450), data, [-2, 2].asSpec);
a.drawMethod = \fillRect;
a.symbolSize = 3;
a.symbolColor = Color.blue;
a.background = Color.black;

// Y Slider
GUI.slider.new(w, Rect(10, 470, 450, 10)).action_{|me|
	a.rotY = me.value * 2pi;
	a.refresh;
};
// X Slider
GUI.slider.new(w, Rect(470, 10, 10, 450)).action_{|me|
	a.rotX = me.value * 2pi;
	a.refresh;
};
// Z Slider
GUI.slider.new(w, Rect(490, 10, 10, 450)).action_{|me|
	a.rotZ = me.value * 2pi;
	a.refresh;
};
)

a.isHighlight = true
a.highlightColor = Color.green;
a.highlightSize = 10@10
a.highlightItem = 99
a.refresh


