

p = GenericSpace.push(s);
p.proxyspace.clear;


~t_mine = { loop { 1.wait; "233".scramble.postln } };

~t_mine.play;





// normal envir
~out = 9;

~out + 10;

// pattern proxy
~p_x = 5;

~p_y = ~p_x + 9;


// instant combination of event pattern proxy with node proxy
~n_out = ~pe_y;

~pe_y = Pbind.new;

~n_out.play;



~x = 100;

~n_out = Pbind(\freq, Pseq([~n_freq, ~x, ~f_x], inf));

~n_freq = { MouseX.kr(300, 800) };


p.envir
p.at(\p_y)

~f_x = 119;
~f_y = ~f_x;
~f_y.value;