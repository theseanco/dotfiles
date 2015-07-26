
UnitTest			a class for programmatic testing of classes

In order to make sure a method works correctly, a test can be implemented that assures the correct behavior.
It is a common practice to write tests to clarify how an object should respond, and it may avoid inconsistencies on the long run. A test is always a subclass of UnitTest, implementing at least one method starting with test_.

superclass: Object

see also: UnitTestScript (tests independent of classes).
Most tests are located in the CommonTest quark:

("open " ++ ("%/%".format(Quarks.local.path, "CommonTests").escapeChar($ ))).unixCmd;

Running tests

*gui 
	For a graphical interface to all tests, run this line:

	UnitTest.gui
	
*runTest(methiodName)

	Run a single test in the name format "TestPolyPlayerPool:test_prepareChildrenToBundle"
	
	UnitTest.reset; 
	UnitTest.runTest("TestUnitTest:test_assert");

*runAll

	runs all subclasses of UnitTest
	
	UnitTest.reset; 
	UnitTest.runAll;
	

run
	All method names that start with test_ are invoked. 
	TestUnitTest.new.run;

	
runTestMethod(method)

	Run a single test method of this class
	TestUnitTest.new.runTestMethod(TestUnitTest.findMethod(\test_assert));




Writing tests by subclassing UnitTest


YourClass.test

	Runs the test class for YourClass, which is assumed to be named TestYourClass.
	If no test class if found it politely declines.


	UnitTests for Common library classes are kept in the CommonTests quark.
	This enables you to easily install and uninstall these tests.


setUp / tearDown
	Implement these methods in a subclass, to be called before and after a test.


assert(test, message, report, onFailure)
	
	Make sure that the test returns true. Post the message if report is true. 
	If onFailure is not nil, a failure stops the tests and evaluates this function.
	
	UnitTest.new.assert(2 == 2, "Two does equal two.");
	UnitTest.new.assert(2 == 2.00001, "Two does equal two.");


 
assertEquals(a, b, message, report, onFailure)
	
	Make sure that a equals b.  Post the message if report is true. 
	If onFailure is not nil, a failure stops the tests and evaluates this function.
	
	UnitTest.new.assertEquals(2, 2, "Two does equal two.");
	UnitTest.new.assertEquals(2, 2.00001, "Two does equal two.");

assertFloatEquals(a, b, message, within, report, onFailure)
	
	Make sure that the two floats a and b equal within a given range (within). 
	Post the message if report is true. 
	If onFailure is not nil, a failure stops the tests and evaluates this function.
	
	UnitTest.new.assertFloatEquals(2, 2.00001, "Two does equal two.", 0.00001);
	UnitTest.new.assertFloatEquals(2, 2.001, "Two does equal two.", 0.0001);

assertArrayFloatEquals(a, b, message, within, report, onFailure)
	
	Make sure that the two arrays of floats a and b equal within a given range (within). 
	Post the message if report is true. 
	If onFailure is not nil, a failure stops the tests and evaluates this function.
	
	UnitTest.new.assertArrayFloatEquals([2, 3], [2, 3] + 0.00001, "Same Floats", 0.000001);

ifAsserts(boolean, message, ifPassedFunc, ifFailedFunc, report)
	
	Make a further assertion only if it passed, or only if it failed.
	
	(
	a = UnitTest.new;
	a.ifAsserts(2 == 3, "yes", { a.assert(2 == 4) }, { a.assert(1 == 1, "but this is correct") });
	)
	
wait(condition, failureMessage, maxTime)
	
	Wait for a condition, consider failed after maxTime. Only valid within a test (or a routine)
	
	(
	{
		s.reboot;
		UnitTest.new.wait(s.serverRunning, "server failed to boot in time", 2);
	}.fork
	)
	
bootServer(server)
	
	Wait for server boot until continued. Only valid within a test (or a routine).
	If already booted, then freeAll and create new allocators
	
	(
	{
		UnitTest.new.bootServer(s);
	}.fork
	)

failed(method, message, report)
	
	call failure directly.
	
	UnitTest.new.failed(message: "this failed");
	

passed(method, message, report)
	
	call failure directly.
	
	UnitTest.new.passed(message: "this passed");
	



Example for a UnitTest class

	TestYourClass : UnitTest {
	
		setUp {
			// this will be called before each test
		}
		tearDown {
			// this will be called after each test
		}
		 
		test_yourMethod {
		 	
		  	// every method named test_
		  	// will be run
		 	
		  	this.assert( 6 == 6, "6 should equal 6");
		 	
		  	this.assertEquals( 9, 9, "9 should equal 9");
		 	
		  	this.assertFloatEquals( 4.0 , 1.0 * 4.0 / 4.0 * 4.0, 
		  		"floating point math should be close to equal");
		 
		  	// we are inside a Routine, you may wait
		  	1.0.wait;
		 	
		  	// this will wait until the server is booted
		  	this.bootServer;
		 	
		  	// if the server is already booted it will free all nodes
		  	// and create new allocators, giving you a clean slate
		 	
		  	p = { SinOsc.ar };
		  	p.play;
		  	p.register;
		 	
		  	// will wait until the condition is true
		  	// will be considered a failure after 10 seconds
		  	this.wait( { p.isPlaying }, "waiting for synth to play", 10);
		 	
		}
		
	}



