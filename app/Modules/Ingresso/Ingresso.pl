:- consult('../Database/Database.pl').

createIngresso(Username, NomeFilme, IdFilme, Valor, Assento) :-
    createIngressoDatabase(Username, NomeFilme, IdFilme, Valor, Assento).

deleteIngresso(Username, Name) :-
    deleteIngressoDatabase(Username, Name).