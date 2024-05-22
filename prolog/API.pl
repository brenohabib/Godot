:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_json)).

% Definição das tecnologias
% tech(Name, Category, Popularity, Difficulty).
tech(python, programming_language, high, low).
tech(java, programming_language, high, high).
tech(elixir, programming_language, medium, medium).
tech(django, framework, high, low).
tech(flask, framework, medium, low).
tech(react, frontend, high, medium).
tech(angular, frontend, medium, high).
tech(basic, programming_language, low, low).
tech(c, programming_language, high, high).
tech(go, programming_language, medium, medium).
tech(haskell, programming_language, medium, high).
tech(itk, toolkit, low, medium).
tech(kawa, programming_language, low, medium).
tech(lua, programming_language, medium, medium).
tech(matlab, programming_language, medium, medium).
tech(nasm, programming_language, low, high).
tech(opencl, framework, medium, high).
tech(prolog, programming_language, low, high).
tech(qbasic, programming_language, low, low).
tech(scratch, programming_language, medium, low).
tech(typescript, programming_language, high, low).
tech(unicon, programming_language, low, medium).
tech(visual_basic, programming_language, medium, medium).
tech(webgl, framework, medium, medium).
tech(xojo, programming_language, low, medium).
tech(yorick, programming_language, low, medium).
tech(zig, programming_language, low, medium).

% Regras de recomendação
recommend_tech(Category, Popularity, Difficulty, Name) :-
    (var(Category) ; tech(Name, Category, _, _)),
    (var(Popularity) ; tech(Name, _, Popularity, _)),
    (var(Difficulty) ; tech(Name, _, _, Difficulty)).

% Define o handler para a rota de recomendação
:- http_handler(root(recommend), recommend_handler, []).
% Handler para obter informações de tecnologia
:- http_handler(root(tech_info), tech_info_handler, []).

% Handler de recomendação
recommend_handler(Request) :-
    http_parameters(Request, [
        category(Category, [optional(true), atom]),
        popularity(Popularity, [optional(true), atom]),
        difficulty(Difficulty, [optional(true), atom])
    ]),
    findall(Name, recommend_tech(Category, Popularity, Difficulty, Name), TechList),
    sort(TechList, UniqueTechList),
    reply_json_dict(_{recommendations: UniqueTechList}).

% Handler para informações de tecnologia
tech_info_handler(Request) :-
    http_parameters(Request, [
        name(Names, [list(atom)])
    ]),
    get_tech_info(Names, TechInfoList),
    reply_json_dict(_{tech_info: TechInfoList}).

% Obtém informações sobre tecnologias
get_tech_info([], []).
get_tech_info([Name|NameList], [Info|TechInfoList]) :-
    tech(Name, Category, Popularity, Difficulty),
    Info = _{name: Name, category: Category, popularity: Popularity, difficulty: Difficulty},
    get_tech_info(NameList, TechInfoList).

% Inicialização servidor
server(Port) :-
    http_server(http_dispatch, [port(Port)]).

% Iniciar o servidor na porta 8080
:- initialization
    server(8080).
