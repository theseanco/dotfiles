
UnitTestScript			run test scripts

In order to make sure a method works correctly, a test can be implemented that assures the correct behavior.
It is a common practice to write tests to clarify how an object should respond, and it may avoid inconsistencies on the long run. 

Test scripts are simply plain text files ending with "_unittest.scd", which are interpreted. 
Scripts may be located next to a class in the classpath or one folder below.

If they return a function, the UnitTestScript is passed in, allowing to call methods like assert etc. (see UnitTest)

superclass: Object : UnitTest

UnitTestScript mimics some of the behavior of Method, to be compatible with UnitTest.


An example script: myUnitTest_unittest


To run only the test scripts:

	UnitTestScript.run;
	
The scripts are to be found under the class UnitTestScript in the GUI:

	UnitTest.gui
	


