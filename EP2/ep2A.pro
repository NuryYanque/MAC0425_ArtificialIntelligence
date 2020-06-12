% Nome: Nury Yuleny Arosquipa Yanque
% NUSP: 9871836
%%%%% Insira aqui os seus predicados.
%%%%% Use quantos predicados auxiliares julgar necessario

% Exercicio 1
reverse([], CsRe, CsRe).
reverse([X|Cs], Acc, CsRe) :-
    reverse(Cs, [X|Acc], CsRe).

lista_para_conjunto(Xs, CsRe) :-
    lista_para_conjunto(Xs, [], Cs),
	reverse(Cs, [], CsRe).
lista_para_conjunto([], Set, Set).
lista_para_conjunto([X|Xs], Set, Cs) :-
    \+ member(X, Set),
    lista_para_conjunto(Xs, [X|Set], Cs).
lista_para_conjunto([X|Xs], Set, Cs) :-
    member(X, Set),
    lista_para_conjunto(Xs, Set, Cs).

% Exercicio 2
delete_item(A, [A|L1], L1).
delete_item(A, [B|L], [B|L1]) :-
    delete_item(A, L, L1).

mesmo_conjunto([], []).
mesmo_conjunto(Cs, [A|Ds]) :-
    delete_item(A, Cs, L1),
	mesmo_conjunto(L1, Ds).

% Exercicio 3 
uniao_conjunto([], Z, Z).
uniao_conjunto([X|Cs], Ds, Es) :-
    member(X, Ds),
    uniao_conjunto(Cs, Ds, Es).
uniao_conjunto([X|Cs], Ds, Es) :-
    \+ member(X, Ds),
    uniao_conjunto(Cs, [X|Ds],  Es).

% Exercicio 4
inter_conjunto([], _, []).
inter_conjunto([X|Cs], Ds, [X|Es]) :-
    member(X, Ds),
    inter_conjunto(Cs, Ds, Es).
inter_conjunto([X|Cs], Ds, Es) :-
    \+ member(X, Ds),
    inter_conjunto(Cs, Ds, Es).

% Exercicio 5
diferenca_conjunto([], _ , []).
diferenca_conjunto([X|Cs], Ds, [X|Es]) :-
    \+ member(X, Ds),
    diferenca_conjunto(Cs, Ds, Es).
diferenca_conjunto([X|Cs], Ds, Es) :-
    member(X, Ds),
    diferenca_conjunto(Cs, Ds, Es).

%%%%%%%% Fim dos predicados adicionados
%%%%%%%% Os testes come�am aqui.
%%%%%%%% Para executar os testes, use a consulta:   ?- run_tests.

%%%%%%%% Mais informacoes sobre testes podem ser encontradas em:
%%%%%%%%    https://www.swi-prolog.org/pldoc/package/plunit.html

:- begin_tests(conjuntos).
test(lista_para_conjunto, all(Xs=[[1,a,3,4]]) ) :-
    lista_para_conjunto([1,a,3,3,a,1,4], Xs).
test(lista_para_conjunto2,fail) :-
    lista_para_conjunto([1,a,3,3,a,1,4], [a,1,3,4]).

test(mesmo_conjunto, set(Xs=[[1,a,3],[1,3,a],[a,1,3],[a,3,1],[3,a,1],[3,1,a]])) :-
    mesmo_conjunto([1,a,3], Xs).
test(uniao_conjunto2,fail) :-
    mesmo_conjunto([1,a,3,4], [1,3,4]).

test(uniao_conjunto, set(Ys==[[1,a,3],[1,3,a],[a,1,3],[a,3,1],[3,a,1],[3,1,a]])) :-
    uniao_conjunto([1,a], [a,3], Xs),
    mesmo_conjunto(Xs,Ys).
test(uniao_conjunto2,fail) :-
    uniao_conjunto([1,a,3,4], [1,2,3,4], [1,1,a,2,3,3,4,4]).

test(inter_conjunto, all(Xs==[[1,3,4]])) :-
    inter_conjunto([1,a,3,4], [1,2,3,4], Xs).
test(inter_conjunto2,fail) :-
    inter_conjunto([1,a,3,4], [1,2,3,4], [1,1,3,3,4,4]).

test(diferenca_conjunto, all(Xs==[[2]])) :-
    diferenca_conjunto([1,2,3], [3,a,1], Xs).
test(diferenca_conjunto2,fail) :-
    diferenca_conjunto([1,3,4], [1,2,3,4], [_|_]).

:- end_tests(conjuntos).
