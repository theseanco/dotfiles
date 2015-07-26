
"ScatterView2";

(
// three dimensional dataset
d = ({1.0.rand}!9000).clump(3);

w = SCWindow.new("ScatterView Example");
v = ScatterView2(w, Rect(10, 10, 380, 380), d);
v.selectionMode = \nextNeighbour;
v.background = Color.black;
w.front;
)

v.selectModes.add(\abc -> ((1..100)))
v.selectionMode = \abc;

v.selectionMode = \nextNeighbour;

v.selectModes.add(\nextNeighbour -> {|view, data, pos, itemSize|
	var threshold, index, selected;

	threshold = itemSize*2;
	index = data.detectIndex{|item|
		(item - pos).abs.sum <= threshold;
	};
	index
})


v.select((1..900))
v.selection
v.selectionMode = \surrounding;
v.selectRegion = 0.021
v.itemSize = 5

v.data = d;
v.action = {|indices|
	indices.postln;
	d[indices].postln
}


v.colorFunc = {|idx, selected|
	selected.if({Color.red}, {Color.hsv(d[idx][2], 1, 0.2)})
}

v.colorFunc = Color.red(1, 0.5)


