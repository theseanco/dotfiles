
BufMin	UGen detects the smallest value (and its position) in a Buffer

# val, index = BufMin.kr(bufnum, gate)

Finds the smallest value in a Buffer, and outputs the value and the index.

You don't need to make use of the gate control: if you do use it, the calculation is only performed when gate>0.

(Note: doesn't currently handle multichannel buffers in any clever way, treats them as if they were single-channel.)

See also: BufMax


Example

s.boot;

b = Buffer.alloc(s, 100);
b.zero;
b.set(33, -1.034);
// This should detect the 33rd value as the lowest...
x = {BufMin.kr(b).poll}.play;

// ...until we set a new winner...
b.set(74, -1000000);


