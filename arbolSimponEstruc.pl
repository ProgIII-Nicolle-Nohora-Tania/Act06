padre(hombre(homero), [hombre(bart), mujer(lisa), mujer(maggie)]).

padre(hombre(abraham), [hombre(homero), hombre(herbert)]).

padre(hombre(clancy), [mujer(marge), mujer(patty), mujer(selma)]).

padre_de(X, Y) :- padre(hombre(X), L), (member(hombre(Y), L);member(mujer(Y), L)).

madre(mujer(marge), [hombre(bart), mujer(lisa), mujer(maggie)]).

madre(mujer(jacqueline), [mujer(marge), mujer(patty), mujer(selma)]).

madre(mujer(selma), [mujer(ling)]).

madre(mujer(mona), [hombre(homero)]).

madre_de(X, Y) :- madre(mujer(X), L), (member(hombre(Y), L);member(mujer(Y), L)).

hijo_de(X, Y) :- ((madre(mujer(Y), L), (member(hombre(X), L)));
                 (padre(hombre(Y), L), (member(hombre(X), L)))).
  
hija_de(X, Y) :- ((madre(mujer(Y), L), (member(mujer(X), L)));
                 (padre(hombre(Y), L), (member(mujer(X), L)))).
    
abuelo_de(X, Y) :-
    padre_de(X, Z),         
    (padre_de(Z, Y); madre_de(Z, Y)).

abuela_de(X, Y) :-
    madre_de(X, Z),         
    (padre_de(Z, Y); madre_de(Z, Y)).

hermano_de(X, Y) :- 
    (((padre_de(Z, X), padre_de(Z, Y)), \+ (madre_de(W, X), madre_de(W, Y)));
    ((madre_de(W, X), madre_de(W, Y)), \+ (padre_de(Z, X), padre_de(Z, Y)));
    ((padre_de(Z, X), padre_de(Z, Y)), (madre_de(W, X), madre_de(W, Y)))), 
    X \= Y.

hermana_de(X, Y) :- 
    (((padre_de(Z, X), padre_de(Z, Y)), \+ (madre_de(W, X), madre_de(W, Y)));
    ((madre_de(W, X), madre_de(W, Y)), \+ (padre_de(Z, X), padre_de(Z, Y)));
    ((padre_de(Z, X), padre_de(Z, Y)), (madre_de(W, X), madre_de(W, Y)))), 
    X \= Y.

tio_de(X,Y) :- 
    hermano_de(X,Z), 
    ((padre_de(Z,Y) ; madre_de(Z,Y))).

tia_de(X,Y) :- 
    hermana_de(X,Z), 
    ((padre_de(Z,Y) ; madre_de(Z,Y))).

primo_de(X,Y) :- 
    ((tio_de(Z,Y), padre_de(Z,X)) ; (madre_de(W,X), tia_de(W,Y))).

prima_de(X,Y) :- 
    ((tio_de(Z,Y), padre_de(Z,X)) ; (madre_de(W,X), tia_de(W,Y))).
