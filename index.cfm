<cfparam name="url.print_js_resources" type="boolean" default="true" />
<cfparam name="url.toggledebug" type="boolean" default="true" />
<cfparam name="url.action" type="string" default="none" />
<cfsetting requesttimeout="3600"><!-- 1 hour -->



<cfscript>
directory sort="dateLastModified desc"  action="list" directory="./tickets" name="dir" filter="*.cfc";

</cfscript>

<cfoutput>
<h1>Jira Tickets</h1>
<ul>
	<li><a href="index.cfm?action=all">Run all tickets</a></li>
	<li><a href="index.cfm?action=latest">Run latest 10 tickets</a></li>
	<ul>
		
	<cfloop query="#dir#" endrow="10">
		<cfset n=mid(dir.name,1,len(dir.name)-4)>
		<!--- 
		TODO get information about the ticket directly from jira
		<cfset cfcName='tickets.'&n>
		<cfset cfc=createObject('component',cfcName)>
		<cfset meta=getMetadata(cfc)>--->
		<li>
			<a href="index.cfm?action=single&ticket=#n#">Run #n#</a>
			<!---<cfif !isnull(meta.hint) && len(meta.hint)><br>#meta.hint#</cfif>--->
		</li>
	</cfloop>
	</ul>
	<li>
		<form action="index.cfm">Run
		<input type="hidden" name="action" value="single">
		<input type="text" name="ticket" value="<cfif isNull(url.ticket)>Jira<cfelse>#url.ticket#</cfif>">
		<input type="submit" name="submit" value="Go">
		</form>
	</li>
</ul>
</cfoutput>
<cfif url.action EQ "list">
	

</cfif>


<cfscript>
if(url.action != "none") {
	
	
	testSuite = new org.railo.cfml.test.RailoTestSuite();
	//testSuite.maxTheads(20);
	
	if(url.action == "all") {
		testSuite.addPackage('tickets');
		testSuite.addPackage('general');
	}
	else if(url.action == "single") {
		cfcName='tickets.'&url.ticket;
		cfc=createObject('component',cfcName);
		testSuite.addAll(cfcName,cfc);
	}
	else if(url.action == "latest") {
		loop query="#dir#" endrow="10" {
			n=mid(dir.name,1,len(dir.name)-4);
			cfcName='tickets.'&n;
			cfc=createObject('component',cfcName);
			testSuite.addAll(cfcName,cfc);
		}
	}
	//testSuite.setMaxThreads(10);
	
	results = testSuite.run();
    echo(results.getResultsOutput('html'));
    qry=results.getResultsOutput('query');
	
}
/*
TODO

overwrite TestResult.getHTMLResults();
testSuite.maxParallelThread(); // default 1
testSuite.addTestCase('...',1000); // timeout setting for the testcase, it should be possible to define this also on suite level 
*/

</cfscript>

