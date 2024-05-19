:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_json)).

% Definição das tecnologias
:- dynamic tech/3.

% tech(Name, Category, Popularity).
tech(python, programming_language, high).
tech(java, programming_language, high).
tech(elixir, programming_language, medium).
tech(django, framework, high).
tech(flask, framework, medium).
tech(react, frontend, high).
tech(angular, frontend, medium).
tech(basic, programming_language, low).
tech(c, programming_language, high).
tech(go, programming_language, medium).
tech(haskell, programming_language, medium).
tech(itk, toolkit, low).
tech(kawa, programming_language, low).
tech(lua, programming_language, medium).
tech(matlab, programming_language, medium).
tech(nasm, programming_language, low).
tech(opencl, framework, medium).
tech(prolog, programming_language, low).
tech(qbasic, programming_language, low).
tech(scratch, programming_language, medium).
tech(typescript, programming_language, high).
tech(unicon, programming_language, low).
tech(visual_basic, programming_language, medium).
tech(webgl, framework, medium).
tech(xojo, programming_language, low).
tech(yorick, programming_language, low).
tech(zig, programming_language, low).


% Regras de recomendação
recommend_tech(Category, Popularity, TechList) :-
    findall(Name, (tech(Name, Category, Popularity)), TechList).

% Define o handler para a rota de recomendação
:- http_handler(root(recommend), recommend_handler, []).
% Handler para obter informações de tecnologia
:- http_handler(root(tech_info), tech_info_handler, []).

% Handler de recomendação
recommend_handler(Request) :-
    http_parameters(Request, [
        category(Category, [atom]),
        popularity(Popularity, [atom])
    ]),
    recommend_tech(Category, Popularity, TechList),
    reply_json_dict(_{recommendations: TechList}).

% Handler para informações de tecnologia
tech_info_handler(Request) :-
    http_parameters(Request, [
        name(Names, [list(atom)])
    ]),
    get_tech_info(Names, TechInfoList),
    reply_json_dict(_{tech_info: TechInfoList}).

% Obtém informações sobre as tecnologias
get_tech_info([], []).
get_tech_info([Name|Rest], [Info|TechInfoList]) :-
    tech(Name, Category, Popularity),
    Info = _{name: Name, category: Category, popularity: Popularity},
    get_tech_info(Rest, TechInfoList).

% Inicialização do servidor
server(Port) :-
    http_server(http_dispatch, [port(Port)]).

% Iniciar o servidor na porta 8080
:- initialization
    server(8080).
