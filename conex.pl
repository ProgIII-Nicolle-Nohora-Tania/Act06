arista(ciudad(vancouver), ciudad(edmonton), costo(16)).
arista(ciudad(vancouver), ciudad(calgary), costo(13)).

arista(ciudad(calgary), ciudad(regina), costo(14)).
arista(ciudad(calgary), ciudad(edmonton), costo(4)).

arista(ciudad(edmonton), ciudad(saskatoon), costo(12)).

arista(ciudad(regina), ciudad(saskatoon), costo(7)).
arista(ciudad(regina), ciudad(winnipeg), costo(4)).

arista(ciudad(saskatoon), ciudad(calgary), costo(9)).
arista(ciudad(saskatoon), ciudad(winnipeg), costo(20)).

%Existe conexion entre X y Y?
tiene_conexion(X, Y) :- arista(ciudad(X), ciudad(Y), _C).

%Con qué nodos está conectado y cuál es el costo de cada conexion?
conectado_a(X, Y, C) :- arista(ciudad(X), ciudad(Y), costo(C)).

%Determinar si un nodo tiene aristas 
tiene_aristas(X) :- arista(ciudad(X), _Y, _C).

%Desterminar costo para ir de X a Z pasando por Y
costo(X, Y, Z, S) :- arista(ciudad(X), ciudad(Y), costo(C1)), arista(ciudad(Y), ciudad(Z), costo(C2)), S is C1 + C2.
% Caso base: hay una arista directa entre X e Y
camino_a(X, Y, [X, Y], C) :- arista(ciudad(X), ciudad(Y), costo(C)).

camino_a(X, Y, [X | Camino], Costo) :-
    arista(ciudad(X), ciudad(Z), costo(C1)),                 
    Z \= Y,                            
    camino_a(Z, Y, Camino, C2, [X]),   
    Costo is C1 + C2.

camino_a(X, Y, [X, Y], C, _) :- arista(ciudad(X), ciudad(Y), costo(C)).
camino_a(X, Y, [X | Camino], Costo, Visitados) :-
    arista(ciudad(X), ciudad(Z), costo(C1)), 
    \+ member(Z, Visitados),          
    camino_a(Z, Y, Camino, C2, [Z | Visitados]),  
    Costo is C1 + C2.