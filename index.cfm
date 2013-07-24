<cfparam name="url.print_js_resources" type="boolean" default="true" />
<cfparam name="url.toggledebug" type="boolean" default="true" />
<cfsetting requesttimeout="3600"><!-- 1 hour -->

<cfscript>
	
	testSuite = new org.railo.cfml.test.RailoTestSuite();
	testSuite.addPackage('tickets');
	
	
	results = testSuite.run();
    echo(results.getResultsOutput('html'));
	

/*
TODO

overwrite TestResult.getHTMLResults();
testSuite.maxParallelThread(); // default 1
testSuite.addTestCase('...',1000); // timeout setting for the testcase, it should be possible to define this also on suite level 
*/

</cfscript>


