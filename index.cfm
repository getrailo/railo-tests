<cfparam name="url.print_js_resources" type="boolean" default="true" />
<cfparam name="url.toggledebug" type="boolean" default="true" />
<cfparam name="url.action" type="string" default="none" />
<cfset currentDirectory= getDirectoryFromPath(getCurrentTemplatePath())>
<cfsetting requesttimeout="3600"><!-- 1 hour -->



<cfdirectory action="list" recurse="true"  sort="dateLastModified desc"  directory="./" name="dir" filter="*.cfc">

<cfoutput>
<h1>Jira Tickets</h1>
<ul>
	<li><a href="index.cfm?action=all">Run all tickets</a></li>
	<li><a href="index.cfm?action=latest">Run latest 10 tickets</a></li>
	<ul>
		
	<cfloop query="#dir#" endrow="10">
		<cfset package=replace(replace(replace(dir.directory,currentDirectory,''),'\','.','all'),'/','.','all')>
		<cfset n=mid(dir.name,1,len(dir.name)-4)>
		<cfif package == "testcase-templates">
			<cfcontinue>
		</cfif>
		<!--- 
		TODO get information about the ticket directly from jira
		<cfset cfcName='tickets.'&n>
		<cfset cfc=createObject('component',cfcName)>
		<cfset meta=getMetadata(cfc)>--->
		<li>
			<a href="index.cfm?action=single&testcase=#package#.#n#">Run #package#.#n#</a>
			<!---<cfif !isnull(meta.hint) && len(meta.hint)><br>#meta.hint#</cfif>--->
		</li>
	</cfloop>
	</ul>
	<li>
		<form action="index.cfm">Run
		<input type="hidden" name="action" value="single">
		<input type="text" name="ticket" value="<cfif isNull(url.ticket)>tickets.Jira<cfelse>#url.ticket#</cfif>">
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
		testSuite.addPackage('custom');
	}
	else if(url.action == "single") {
		cfcName=url.testcase;
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

