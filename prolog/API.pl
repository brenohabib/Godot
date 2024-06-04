:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_json)).

% Definição das tecnologias
% tech(Name, Category, Popularity, Difficulty).
tech(python, programming_language, alta, baixa).
tech(java, programming_language, alta, alta).
tech(elixir, programming_language, media, media).
tech(django, framework, alta, baixa).
tech(flask, framework, media, baixa).
tech(react, frontend, alta, media).
tech(angular, frontend, media, alta).
tech(basic, programming_language, baixa, baixa).
tech(c, programming_language, alta, alta).
tech(go, programming_language, media, media).
tech(haskell, programming_language, media, alta).
tech(itk, toolkit, baixa, media).
tech(kawa, programming_language, baixa, media).
tech(lua, programming_language, media, media).
tech(matlab, programming_language, media, media).
tech(nasm, programming_language, baixa, alta).
tech(opencl, framework, media, alta).
tech(prolog, programming_language, baixa, alta).
tech(qbasic, programming_language, baixa, baixa).
tech(scratch, programming_language, media, baixa).
tech(typescript, programming_language, alta, baixa).
tech(unicon, programming_language, baixa, media).
tech(visual_basic, programming_language, media, media).
tech(webgl, framework, media, media).
tech(xojo, programming_language, baixa, media).
tech(yorick, programming_language, baixa, media).
tech(zig, programming_language, baixa, media).

% Regras de recomendação
recommend_tech(Name, Category, Popularity, Difficulty) :-
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
