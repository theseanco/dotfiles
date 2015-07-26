
m = MarkovSet.new;

// read in 2 files
m.parseFile("Help/More-On-Getting-Help.html".standardizePath);
m.parseFile("Help/Language/Intro-to-Objects.html".standardizePath);


// write 5 supermarkov html pages
m.writeHtml(nPages:5, pagelength:120);


// you can also create a string like this:
(
x = Pfsm2(m, inf).asStream;
300.do { x.next.post };
)


