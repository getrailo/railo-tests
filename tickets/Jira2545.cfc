

component extends="org.railo.cfml.test.RailoTestCase"	{

	public function setUp(){
		variables.arr=['Text 1'];
		variables.arr[3]="Text 3";
	}
	
	

	
	public void function testIndexAccess(){
		assertEquals(isNull(variables.arr[1]),false);
		assertEquals(isNull(variables.arr[2]),true);
		assertEquals(isNull(variables.arr[3]),false);
		
		var one=1;
		var two=2;
		var three=3;
		
		assertEquals(isNull(variables.arr[one]),false);
		assertEquals(isNull(variables.arr[two]),true);
		assertEquals(isNull(variables.arr[three]),false);
	}
	
} 