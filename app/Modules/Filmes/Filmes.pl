:- consult('../Database/Database.pl').

% Estrutura de um filme.
filme(Titulo, Genero, Duracao, Caixa).

% Função para cadastrar um novo filme.
cadastraFilme(Titulo, Genero, Duracao, Filmes, NovosFilmes) :-
  NovoFilme = filme(Titulo, Genero, Duracao, 0),
  NovosFilmes = [NovoFilme | Filmes].

% Função para listar filmes em exibição.
listaFilmesEmExibicao(Filmes, FilmesEmExibicao) :-
  findall(Filme, (member(Filme, Filmes), arg(4, Filme, Caixa), Caixa > 0), FilmesEmExibicao).

% Função para pesquisar filmes por gênero.
pesquisaFilmesPorGenero(Genero, Filmes, FilmesDoGenero) :-
  findall(Filme, (member(Filme, Filmes), arg(2, Filme, Genero)), FilmesDoGenero).

% Função para registrar a bilheteria de um filme.
registraCaixaFilme(Valor, Filme, NovoFilme) :-
  arg(4, Filme, Caixa),
  NovoCaixa is Caixa + Valor,
  functor(Filme, Titulo, Genero, Duracao, NovoCaixa),
  NovoFilme = Filme.

% Função para estabelecer a meta de arrecadação de um filme.
defineMetaArrecadacaoFilme(Meta, Filme, NovoFilme) :-
  functor(Filme, Titulo, Genero, Duracao, Meta),
  NovoFilme = Filme.

% Exemplo de uso (Apagar essa parte!!!!!!!!!!!)
:- dynamic(filme/4).
:- dynamic(filmes/1).

% main :-
%   assert(filmes([])),
%   cadastraFilme("Vingadores: Ultimato", "Ficção científica", 180, [], Filmes1),
%   assert(filmes(Filmes1)),
%   registraCaixaFilme(1000, Filmes1, Filme1),
%   defineMetaArrecadacaoFilme(2000, Filme1, Filme2),
%   writeln(Filmes1),
%   writeln(Filme2),
%   retract(filmes(_)),
%   retract(filme(_, _, _, _)).
