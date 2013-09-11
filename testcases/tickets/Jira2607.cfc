<cfscript>
component extends="org.railo.cfml.test.RailoTestCase"	{

	public function setUp(){
	}

	public void function testLocal(){
		local.x = "bob";
		local.fn = function() {
			local.test=local.x;
			local.test=x;
		};
        local.fn();
	}

	public void function testArguments(){
		local.fn = function(arg1) {
			local.test=arg1;
			local.test=arg1;
		};
        local.fn();
	}

	public void function testVariables(){
		variables._test2607="test";
		local.fn = function() {
			local.test=variables._test2607;
			local.test=_test2607;
		};
        local.fn();
	}
} 
</cfscript>