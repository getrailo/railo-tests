<cfscript>
component extends="org.railo.cfml.test.RailoTestCase"	{

	public function setUp(){
		variables.qry=queryNew("str,nbr,dat","varchar,integer,date");
		queryAddrow(variables.qry);
	}

	public void function testImplicidQueryAccess(){
		if(hasFullNullSupport()) throw "test need full null support disabled";
		
		assertEquals(false,isNull(qry.str));
		assertEquals(false,isNull(qry.nbr));
		assertEquals(false,isNull(qry.dat));
		
		// call without the query name
		loop query="#qry#" {
			assertEquals(false,isNull(qry.str));
			assertEquals(false,isNull(qry.nbr));
			assertEquals(false,isNull(qry.dat));
			
			assertEquals(false,isNull(str));
			assertEquals(false,isNull(nbr));
			assertEquals(false,isNull(dat));
		}
		
		s=qry.str;
		assertEquals('java.lang.String',s.getClass().getName());
		s=qry.nbr;
		assertEquals('java.lang.String',s.getClass().getName());
		s=qry.dat;
		assertEquals('java.lang.String',s.getClass().getName());
		
		// same with evaluate
		assertEquals(false,isNull(evaluate('qry.str')));
		assertEquals(false,isNull(evaluate('qry.nbr')));
		assertEquals(false,isNull(evaluate('qry.dat')));
		
		// call without the query name
		loop query="#qry#" {
			assertEquals(false,isNull(evaluate('str')));
			assertEquals(false,isNull(evaluate('nbr')));
			assertEquals(false,isNull(evaluate('dat')));
			
			assertEquals(false,isNull(evaluate('qry.str')));
			assertEquals(false,isNull(evaluate('qry.nbr')));
			assertEquals(false,isNull(evaluate('qry.dat')));
		}
		
		s=evaluate('qry.str');
		assertEquals('java.lang.String',s.getClass().getName());
		s=evaluate('qry.nbr');
		assertEquals('java.lang.String',s.getClass().getName());
		s=evaluate('qry.dat');
		assertEquals('java.lang.String',s.getClass().getName());
	
	}
	
	function testForEach() {

		var q = queryNew( "id,value", "integer,varchar" );

		queryAddRow( q, { id: 1, value: "Abc" } );
		queryAddRow( q, { id: 2, value: "Def" } );
		queryAddRow( q, { id: 3, value: nullValue() } );
		queryAddRow( q, { id: 4, value: "Ghi" } );

		for( var row in q )
			local.x = row.value;
	}
	
	
	private void function hasFullNullSupport(){
		return server.ColdFusion.ProductName EQ "Railo" && getPageContext().getConfig().getFullNullSupport();
	}
} 

</cfscript>