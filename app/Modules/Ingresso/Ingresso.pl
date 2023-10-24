:- consult('../Database/Database.pl').

createIngresso(Username, NomeFilme, IdFilme, Valor) :-
    createIngressoDatabase(Username, NomeFilme, IdFilme, Valor).

deleteIngresso(Username, Name) :-
    deleteIngressoDatabase(Username, Name).