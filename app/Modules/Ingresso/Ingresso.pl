:- consult('../Database/Database.pl').

createIngresso(Username, NomeFilme, IdFilme, Valor) :-
    createIngressoDatabase(Username, NomeLista, IdFilme, Valor).

deleteIngresso(Username, Name) :-
    deleteIngressoDatabase(Username, Name).