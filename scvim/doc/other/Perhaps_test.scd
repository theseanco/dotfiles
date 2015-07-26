

// test. all should be true.
(

a = Perhaps(8).name_("a");
b = Perhaps { a.glue }.name_("b");
b.value == 8;

b.connected.includes(b).not;
b.connected.includes(a);

a.value = 9;
b.connected.size == 1;
a.value = { a.glue };
a.value;
b.connected.size == 1;

a.connected.collect(_.name)

a.value
b.value
a.verbose = true;