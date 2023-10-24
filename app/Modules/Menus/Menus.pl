:- consult('../Users/User.pl').
:- consult('../Util/Util.pl').
%:- consult('../ToDoList/ToDoList.pl').
:- consult('../Database/Database.pl').

menuInicial :-
    write('____________________________'), nl,
    write('SGC-GERENCIAMENTO DE CINEMAS'), nl,
    write('1 - Login'), nl,
    write('2 - Cadastro'), nl,
    write('3 - Cadastro ADM'), nl,
    write('4 - Sair'), nl,
    read(Opcao),
    (
        Opcao = 1 ->
            login
        ;
        Opcao = 2 ->
            telaCadastroUser
        ;
        Opcao = 3 ->
            telaCadastroAdm
        ;
        Opcao = 4 ->
            write('Saindo...'), nl
        ;
            write('Opcao Invalida!'), nl
    ).

login :-
    write('Username: '), nl,
    read(Login),
    write('Senha: '), nl,
    read(Senha),
    (
        loginUser(Login, Senha) ->
            getDados(Login, Dados),
            nth0(3, Dados, IsAdm),
            write('Login realizado com sucesso!'), nl,
            (
                callable(IsAdm) -> 
                telaLoginAdm(Login)
                ;
                telaLogin(Login)
            )
        ;
            write('Senha incorreta!'), nl,
            login
    ).

checkUserType(false, 1).
checkUserType(true, 0).


telaCadastroUser :-
    write('Nome: '), nl,
    read(Name),
    write('Username: '), nl,
    read(Username),
    write('Senha: '), nl,
    read(Senha),
    createUser(Username, Name, Senha, false),
    write('Usuário cadastrado com sucesso!'), nl,
    menuInicial.

telaCadastroAdm :-
    write('Nome: '), nl,
    read(Name),
    write('Username: '), nl,
    read(Username),
    write('Senha: '), nl,
    read(Senha),
    createUser(Username, Name, Senha, true),
    write('Administrador cadastrado com sucesso!'), nl,
    menuInicial.

telaLogin(Login) :-
    write('________________________'), nl,
    write('Menu>Login'), nl,
    write('________________________'), nl,
    write('1 - Perfil'), nl,
    write('2 - Ingressos'), nl,
    write('3 - Logout'), nl,
    read(Opcao),
    (
        Opcao = 1 ->
            telaPerfil(Login)
        ;
        Opcao = 2 ->
            telaUserIngressos(Login)
        ;
        Opcao = 3 ->
            menuInicial
        ;
        write('Opcao Invalida!'), nl
    ).

telaUserIngressos(Login) :-
    write('________________________'), nl,
    write('Menu>Login>Ingressos'), nl,
    write('________________________'), nl,
    write('1 - Ver meus ingressos'), nl,
    write('2 - Comprar Ingressos'), nl,
    write('3 - Ver Filmes em Cartaz'), nl,
    write('4 - Voltar'), nl,
    read(Opcao),
    (
        Opcao = 1 ->
            telaListaIngressos(Login)
        ;
        Opcao = 2 ->
            telaCompraIngressos(Login)
        ;
        Opcao = 3 ->
            %telaListaFilmes
        ;
        Opcao = 4 ->
            telaLogin(Login)
        ;
        write('Opcao Invalida!'), nl
    ).

telaListaIngressos(Login) :-
    directoryDatabase(Directory),
    concatenar_strings(Directory, Login, DirectoryLogin),
    concatenar_strings(DirectoryLogin, '/', DirectoryLoginBarra),
    concatenar_strings(DirectoryLoginBarra, 'ingressos', DirectoryIngressos),
    write('Menu>Login>Ingressos>Meus Ingressos'), nl,
    write(''), nl,
    write('Meus Ingressos:'), nl,
    list_folders(DirectoryIngressos, Login, Login).

telaCompraIngressos(Login) :-
    write('Nome do Filme: '), nl,
    read(Name),
    write('Id do Filme: '), nl,
    read(IdFilme),
    Valor is 10 + 10,
    createIngresso(Login, Name, IdFilme, Valor),
    write('Ingresso comprado com sucesso!'), nl,
    telaUserIngressos(Login).

telaLoginAdm(Login) :-
    write('________________________'), nl,
    write('Menu>Login'), nl,
    write('________________________'), nl,
    write('1 - Perfil'), nl,
    write('2 - Cadastrar Filmes'), nl,
    write('3 - Dashboard'), nl,
    write('4 - Logout'), nl,
    read(Opcao),
    (
        Opcao = 1 ->
            telaPerfil(Login)
        ;
        Opcao = 2 ->
            telaListas(Login)
        ;
        Opcao = 3 ->
            menuInicial
        ;
        Opcao = 4 ->
            menuInicial
        ;
        write('Opcao Invalida!'), nl
    ).

telaPerfil(Login) :-
    write('________________________'),nl,
    write('Menu>Login>Opcoes>Perfil'), nl,
    write('________________________'), nl,
    write('1 - Exibir Perfil'), nl,
    %write('2 - Deletar Perfil'), nl,
    write('2 - Sair'), nl,
    read(Opcao),
    (
        Opcao = 1 ->
            telaExibirPerfil(Login)
        ;
        Opcao = 2 ->
            telaLogin(Login)
        ;
            write('Opcao Invalida!'), nl
    ).

telaExibirPerfil(Login) :-
    write('___________________________________'),nl,
    write('Menu>Login>Opcoes>Perfil>MenuPerfil'), nl,
    write('___________________________________'),nl,
    write('Nome: '), nl,
    getDados(Login, Dados),
    nth0(0, Dados, Nome),
    write(Nome), nl,
    write('Adm: '), nl,
    nth0(3, Dados, IsAdm),
    write(IsAdm), nl,
    write('0 - Voltar'), nl,
    read(Opcao),
    (
        Opcao = 0 ->
            telaPerfil(Login)
        ;
            write('Opcao Invalida!'), nl
    ).


%Funções auxiliares pra listar listas
%==================================================
list_folders(Directory, Username, Username) :-
    directory_files(Directory, Files),
    exclude(hidden_file, Files, Folders),
    print_folder_names(Folders, 1),
    choose_folder(Folders, Username, Username).

print_folder_names([], _).
print_folder_names([Folder|Rest], N) :-
    \+ special_folder(Folder), % Verifica se a pasta é "." ou ".."
    format('~d - ~w~n', [N, Folder]),
    NextN is N + 1,
    print_folder_names(Rest, NextN).

print_folder_names([_|Rest], N) :-
    NextN is N + 1,
    print_folder_names(Rest, NextN).

choose_folder(Folders, Username, Username) :-
    write('Escolha o número da pasta (ou 0 para sair): '),
    read(Number),
    process_choice(Number, Folders, Username, Username).

process_choice(0, _, _, _) :- telaListas(Username).
process_choice(Number, Folders, Username, Username) :-
    number(Number),
    nth1(Number, Folders, Folder),
    format('Você escolheu a pasta: ~w~n', [Folder]),
    telaAcessoLista(Username, Username, Folder).

hidden_file(File) :-
    sub_atom(File, 0, 1, _, '.').
    
special_folder('.').
special_folder('..').
%===========================================================================