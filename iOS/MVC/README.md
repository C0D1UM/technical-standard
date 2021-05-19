# MVC

## Model ViewController

### What is MVC?

MVC is a software development pattern made up of three main objects:
#### model
The Model is where your data resides. Things like persistence, model objects, parsers, managers, and networking code live there.
#### View
The View layer is the face of your app. Its classes are often reusable as they don’t contain any domain-specific logic. For example, a UILabel is a view that presents text on the screen, and it’s reusable and extensible.
#### Controller
The Controller mediates between the view and the model via the delegation pattern. In an ideal scenario, the controller entity won’t know the concrete view it’s dealing with. Instead, it will communicate with an abstraction via a protocol. A classic example is the way a UITableView communicates with its data source via the UITableViewDataSource protocol.

### Implementing the MVC
So First of all you have to know that if the MVC Design pattern implements correctly it can help you code and debug faster . In MVC model shouldn't know about the Views and also the Views shouldn't know about the model this means for example : View expects a model to show (that's it!) and also for the Model it doesn't matter that the View design or how it's gonna show and etc. here are some things that you should consider and follow to have a maintainable code: 
1- the controller should not manage every things :
If your controller does every things such as managing the UI and fetching the model and objects of the model , your controller will become `Massive View Controller!`.  Massive View Controllers usually are huge classes with hundreds lines of codes and it will be very hard to refactor them or even adding new features to them. If your app has to play a music you should have a player class which just expect a music to play and handling music settings such as speed , play , pause and other settings should be in that player class and your controller just calling that class to play that music . or for example if your app has to showing the data in a view , you shouldn't implement all of the View elements such as `UIButton`,`UITableView`and other UI elements in the view controller. every things that user can see in the one page doesn't mean that you have to implement them in the one view controller as well!. for this case first you have to consider the UI elements of your page , if they are not few elements you can divide the page by 2 or more parts and implementing each parts separately in Xib or another View Controller. so you have two ways using another view controller with container to connect to the main view controller or using a xib file to handle every UI elements and showing them. using these ways have a lot of advantages : 
#### First
you don't need to set constraints to all of the elements in your whole page and as you divided your UI elements of your page to some parts you have less constraints to set so for making your app responsive you have less problems.
#### Second 
you can reuse these parts in any other parts of your app , so you don't need to implement the similar parts again and again. you just need to create an object of the UI that you implemented and using that.
#### Third
your story boards will be much lighter and faster and as you implemented the UI elements in the XIb files you have less conflicts with your teammates when working on the same project .

2- you should not using one story board for your whole project . when you are using one story board for your whole project you will have these problems below :
*you will have conflicts with your teammates when you want to work on the story board because you have one story board and even if you work in another part of that this one still is one file.
*your story board will be very heavy to load and some times it's very hard to see the relation between the view controllers in the story board.
