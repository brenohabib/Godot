# Technology Recommendation System Using Godot and Prolog
With the rapid emergence of numerous technologies, it becomes challenging to keep up with all advancements. To address this, we developed a technology recommendation system with a user-friendly interface that provides recommendations based on the user's knowledge level and interests, considering the popularity of each technology.

## Technologies Used

### Prolog
Prolog (Programming in Logic) is a logic programming language primarily used in artificial intelligence and natural language processing. It was created in the 1970s and focuses on describing relationships and logical rules.

### Godot
Godot is an open-source game engine used for developing 2D and 3D games. It is known for its flexibility and ease of use, offering an intuitive visual interface and a scripting language called GDScript, which is similar to Python.

## Implementation
We used Godot for the graphical interface and Prolog for the system's logic.

### Prolog
We utilized SWI-Prolog to create a communication mechanism via API with the HTTP modules. Key Prolog components included:

- Defining facts about technologies with properties such as Name, Category, Popularity, and Difficulty.
- Developing rules to recommend technologies and handle HTTP requests.
- Implementing handlers for recommendation and technology information retrieval.

### Godot
In Godot, we created a scene using Control Node and various GUI elements like CheckBox, Button, and HTTP Request to interact with the Prolog API. Scripts in GDScript managed the communication between the interface and Prolog, including sending requests and displaying results.

## Run

You need to install [SWI-Prolog](https://www.swi-prolog.org/Download.html). Open the CMD inside prolog folder and run "swipl API.pl", it'll run a local API. With that set up, just open the Tech Recommender.
