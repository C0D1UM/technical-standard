
## Model ViewController

### What is MVC?

MVC is a software development pattern made up of three main objects:
#### Model
The Model is where your data resides. Things like persistence, model objects, parsers, managers, and networking code live there.
#### View
The View layer is the face of your app. Its classes are often reusable as they don’t contain any domain-specific logic. For example, a UILabel is a view that presents text on the screen, and it’s reusable and extensible.
#### Controller
The Controller mediates between the view and the model via the delegation pattern. In an ideal scenario, the controller entity won’t know the concrete view it’s dealing with. Instead, it will communicate with an abstraction via a protocol. A classic example is the way a UITableView communicates with its data source via the UITableViewDataSource protocol.

### Implementing the MVC
So First of all you have to know that if the MVC Design pattern implements correctly it can help you code and debug faster . In MVC model shouldn't know about the Views and also the Views shouldn't know about the model this means for example : View expects a model to show (that's it!) and also for the Model it doesn't matter that the View design or how it's gonna show and etc. here are some things that you should consider and follow to have a maintainable code: 
#### 1- The controller should be only a controller not more
##### 1.1- Your view controller shouldn't manage every things
If your controller does everything such as managing the UI and fetching the model and objects of the model , your controller will become a `Massive View Controller!`.  Massive View Controllers usually are huge classes with hundreds lines of codes and it will be very hard to refactor them or even add new features to them. If your app has to play music you should have a player class which just expects a music to play and handling music settings such as speed , play , pause and other settings should be in that player class and your controller just calls that class to play that music .
##### 1.2- Everything that the user can see in each page doesn't mean that you have to implement all of them in the one view controller.
If your app has to show the data in a view , you shouldn't implement all of the View elements such as `UIButton`,`UITableView`and other UI elements in the view controller. everything that a user can see in one page doesn't mean that you have to implement them in the one view controller as well!. For this case first you have to consider the UI elements of your page , if they are not a few elements, you can divide the page by 2 or more parts and implement each part separately in Xib or another View Controller. so you have two ways: using another view controller with a container to connect to the main view controller or using a xib file to handle every UI element and showing them. using these ways have a lot of advantages : 
#### First
you don't need to set constraints to all of the elements in your whole page and as you divide your UI elements of your page to some parts you have less constraints to set so for making your app responsive you have less problems.
#### Second 
you can reuse these parts in any other parts of your app , so you don't need to implement the similar parts again and again. you just need to create an object of the UI that you implemented and use that.
#### Third
Your story boards will be much lighter and faster and as you implement the UI elements in the XIb files you have less conflicts with your teammates when working on the same project .

#### 2- You should not use one storyboard for your whole project
when you are using one storyboard for your whole project you will have these problems below :
*you will have conflicts with your teammates when you want to work on the storyboard because you have one story board and even if you work in another part of that this one still is one file.
*your story board will be very heavy to load and sometimes it's very hard to see the relation between the view controllers in the storyboard.

### Network
Getting the data from the server needs to be implemented in the models or separate class for calling the api's. network should not be called in the view controller directly. 

### Class sizes
Your classes codes should not be more than 500 lines of codes it can be less or more, but if you follow the rules which mentioned above your classes codes will be much less than this (although it's not 0 or 1 and it depends on your logic but as soon as your classes sizes are small you are good to go)

### Extensions and xib files 
you can use extensions and xib files to avoid repeating yourself.
Extensions add new functionality to an existing class, structure, enumeration, or protocol type. This includes the ability to extend types for which you don’t have access to the original source code (known as retroactive modeling). making each extension in separate file to implement and find the functions for the each extension easily 
you can divide your complicated views to the smaller reusable views by using xib files, then you won't need to set a lot of constraints in the complicated views and each xib file is responsive so you can use them easily and anywhere. also for the `UICollectionViewCell` and `UITableViewCell` you can create classes with xib files instead of making them in the story boards.

### Setting Constraints 
the easiest and fastest way to setting the constraints is using the AutoLayout part in the storyboard and xib files without need to set any constraints in the codes (some times you need to change the constraints run time and the size will set in the runtime as well so in that case you need to set the constraints in the storyboard or xib files and then drag that constraint to your code to change it run time)

### Passing the data 
to pass the data do not use `Notification Center` or `User Defaults`, you can use call back functions and delegate protocols instead . if you are using delegate protocols remember to make your delegates `weak`to avoid memory leaks. in some callback functions you need to use `weak` for avoiding the memory leaks problem. make sure every view controller which dismissed the `deinit` function executes in that class after dismissing. you can make some protocol functions optional to avoid using those functions in the other classes that you may use.

