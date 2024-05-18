:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_parameters)).

% Definição da base de dados de tecnologias
:- dynamic tech/3.

% tech(Name, Category, Popularity).
tech(python, programming_language, high).
tech(java, programming_language, high).
tech(elixir, programming_language, medium).
tech(django, framework, high).
tech(flask, framework, medium).
tech(react, frontend, high).
tech(angular, frontend, medium).

% Regras de recomendação
recommend_tech(Category, Popularity, TechList) :-
    findall(Name, (tech(Name, Category, Popularity)), TechList).

% Definindo os handlers
:- http_handler(root(hello), say_hello, []).
:- http_handler(root(recommend), recommend_handler, []).

% Handler para a rota /hello
say_hello(_Request) :-
    reply_json_dict(_{message: "Hello, Godot!"}).

% Handler para a rota /recommend
recommend_handler(Request) :-
    http_parameters(Request, [
        category(Category, [atom]),
        popularity(Popularity, [atom])
    ]),
    recommend_tech(Category, Popularity, TechList),
    reply_json_dict(_{recommendations: TechList}).

% Inicializando o servidor na porta 8080
server(Port) :-
    http_server(http_dispatch, [port(Port)]).

:- initialization
    server(8080).
