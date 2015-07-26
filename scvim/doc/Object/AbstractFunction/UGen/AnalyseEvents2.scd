
//This file is part of MLfftwUGens. Copyright (C) 2006  Nicholas M.Collins distributed under the terms of the GNU General Public License full notice in file MachineListening.license

//This file is part of The BBCut Library. Copyright (C) 2001  Nick M.Collins distributed under the terms of the GNU General Public License full notice in file BBCutLibrary.help

AnalyseEvents2

On-the-fly event analyser, based on onset detection/on-the-fly analysis described in my academic papers. Best for percussive events. Recommended that you go via the Segmentation (for one-pass) and AnalyseEventsDatabase (for on-the-fly) classes in standard usage, don't use this directly. 

Note: you will need bbcut2 for  further classes and capabilities. This UGen is included in sc3-plugins for cross-platform building. 

Class Methods

*ar(in,bufnum, threshold, triggerid, circular, pitch)

in- Audio input to track

bufnum- A buffer within which results of the analysis are place

threshold- A parameter acting as the onset detector threshold, default of 0.34 was determined as the best performing over a database of percussive onset, but you might want to change this to change the sensitivity (though you always increase the risk of false positives or false negatives)

triggerid- A trigger ID number used for communication from the UGen to the Lang to mark that a new event was received. Only passed for on-the-fly analysis.

circular- A flag to note on-the-fly analysis assuming a circular buffer. If you only need a one-pass analysis on a file, you won't use this. 

pitch- Can take a .kr pitch detection UGen as input. Will take the median fundamental frequency over a note event from values recorded from this pitch input. 

No examples are given, to discourage solo use. 


