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
            write('Login realizado com sucesso!'), nl,
            getDados(Login, Dados),
            nth0(3, Dados, IsAdm),
            (
                isAdm == false -> 
                telaLogin(Login)
                ;
                telaLoginAdm(Login)
            )
        ;
            write('Senha incorreta!'), nl,
            login
    ).


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
            telaListas(Login)
        ;
        Opcao = 3 ->
            menuInicial
        ;
            write('Opcao Invalida!'), nl
    ).

telaLoginAdm(Login) :-
write('________________________'), nl,
write('Menu>Login'), nl,
write('________________________'), nl,
write('1 - Perfil'), nl,
write('2 - Cadastrar Filmes'), nl,
write('3 - Logout'), nl,
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