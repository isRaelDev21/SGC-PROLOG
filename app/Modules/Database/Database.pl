:- consult('../Util/Util.pl').
:- use_module(library(system)).
:- use_module(library(file_systems)).


directoryDatabase(Directory) :-
    Directory = 'Modules/Database/LocalUsers/'.

%Funções relacionadas a Users
createUserDatabase(Username, Name, Password, Description) :-
    directoryDatabase(Directory),
    concatenar_strings(Directory, Username, DirectoryUser),
    concatenar_strings(Username, '.txt', Usernametxt),
    criar_pasta(Directory, Username),
    criar_pasta(DirectoryUser, 'ingressos'),
    criar_pasta(DirectoryUser, 'sharedWithMe'),
    criar_arquivo(DirectoryUser, Usernametxt),
    escrever_em_arquivo(DirectoryUser, Usernametxt, Username, Name, Password, Description).

deleteUserDatabase(Username) :-
    directoryDatabase(Directory),
    concatenar_strings(Directory, Username, DirectoryUser),
    delete_directory(DirectoryUser).

getDadosDatabase(Username, Dados) :-
    directoryDatabase(Directory),
    concatenar_strings(Directory, Username, DirectoryUser),
    concatenar_strings(Username, '.txt', Usernametxt),
    concatenar_strings(DirectoryUser, '/', DirectoryUser2),
    concatenar_strings(DirectoryUser2, Usernametxt, DirectoryUserFinal),
    ler_user(DirectoryUserFinal, Dados).

%Funções relacionadas a login
loginUserDatabase(Username, Password) :-
    directoryDatabase(Directory),
    concatenar_strings(Directory, Username, DirectoryUser),
    concatenar_strings(Username, '.txt', Usernametxt),
    concatenar_strings(DirectoryUser, '/', DirectoryUser2),
    concatenar_strings(DirectoryUser2, Usernametxt, DirectoryUserFinal),
    ler_user(DirectoryUserFinal, Dados),
    verificar_senha(Dados, Password).
