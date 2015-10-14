When first starting project, make sure your NuGet package manager is working, mine wasn't and required a clean install.

other errors upon a clean run, just telling VS to run in chrome:

An exception of type 'System.Data.SqlClient.SqlException' occurred in System.Data.dll but was not handled in user code
-(This is probably because of the database hasn't been given information because we haven't recieved apppropriate credentials)
an error that seems to be related to (maybe just my local visual studio) not recognizing packages newtonsoft when trying to load web page

I have loaded an example of a dynamic Graph, we can switch to aspx, just did an html because it was quick, I'm using a Library called Highgraph, there's a lot of js if you were to fork the repo into here, just manually added it, since I'm unfamiliar with the NuGet manager.

If people like this graph, it handles everything as JSON objects, but it also has a way for it to be handled with PHP to our SQL server when that is set up (assuming it isn't already)