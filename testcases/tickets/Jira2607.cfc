<cfscript>
component extends="org.railo.cfml.test.RailoTestCase"	{

	public function setUp(){
	}

	public void function test(){
		local.x = "bob";
		local.fn = function() {writeDump(x);};
        local.fn();
	}
} 
</cfscript>