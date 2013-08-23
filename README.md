Railo-Tests
===========

Unit Tests for Railo Server.

This Test Suite need mxunit to be installed (copy of the folder mxunit in webroot) and they need at least Railo 4.1.1.000.


Mapped Folders
--------------

To run the tests from a mapped folder, create the following two mappings in the server or web admin:

    virtual:    /railo-tests
    resource:   {path-of-folder}/railo-tests
    primary:    Resource
    inspect:    Always
    
    virtual:    /tickets
    resource:   {path-of-folder}/railo-tests/tickets
    primary:    Resource
    inspect:    Always
    
Then you can run the tests by calling Railo at /railo-tests/index.cfm, for example

    http://localhost:8888/railo-tests/index.cfm
    
    
