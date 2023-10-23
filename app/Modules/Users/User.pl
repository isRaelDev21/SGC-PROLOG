:- consult('../Database/Database.pl').

createUser(Username, Name, Password, IsAdm) :-
    createUserDatabase(Username, Name, Password, IsAdm).

deleteUser(Username) :-
    deleteUserDatabase(Username).

loginUser(Username, Password) :-
    loginUserDatabase(Username, Password).

getDados(Username, Dados) :-
    getDadosDatabase(Username, Dados).