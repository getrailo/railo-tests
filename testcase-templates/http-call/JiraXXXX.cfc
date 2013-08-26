<cfscript>
component extends="org.railo.cfml.test.RailoTestCase"	{

	public function setUp(){
	}

	public void function test(){
		/*var result=httpCall("JiraXXXX/index.cfm");
		
		assertEquals("","");
		
		try{
			// error
			fail("");
		}
		catch(local.exp){}*/
	}
	
	
	private struct function httpCall(string calledName, string method='get',boolean addtoken=false, body){
		var baseURL="http://#cgi.HTTP_HOST##getDirectoryFromPath(contractPath(getCurrenttemplatepath()))#";
		http method="#arguments.method#" result="local.result" url="#baseURL##arguments.calledName#" addtoken="#arguments.addtoken#" {
			if(!isNull(arguments.body))httpparam type="body" name="test" value="#arguments.body#";
		}
		return result;
	}
	
} 
</cfscript>