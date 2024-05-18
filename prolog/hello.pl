:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).

% Define the route handler
:- http_handler(root(hello), say_hello, []).

% Handler implementation
say_hello(_Request) :-
    reply_json_dict(_{message: "Hello, Godot!"}).

% Start the server (adjusted for security)
server(Port) :-
    http_server(http_dispatch, [port(Port), access_log([file('/var/log/your_server.log')])]).

% Initialize the server at port 8080 (adjusted for security)
:- initialization
    server(8080).