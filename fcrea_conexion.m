% fcrea_conexion                 ACM                      Mayo  2 2020
% Función para generar la matriz de conexion rectilinea del esquema de
% cuadrados, pues digitarla es muy largo y proclive a error.
% En esta malla, dos puntos están conectados si y sólo si tienen igual
% abscisa u ordenada.
% Es llamada por las alternativas 3 y 4 del guion crea_conteos.
% y los resultados se usan en las opciones 3 y 4 de contador_general.
function fcrea_conexion(L)
% L:    Ancho de la malla en lados de cuadrados (4 o 5)
% Hay que asignar las coordenadas a los vértices:
% Los primeros (L+1)^2 son sencillos:
NP = L+1;
iv = 0;
for iy = 1:NP
    for ix = 1:NP
        iv = iv+1;
        x(iv) = ix-1; y(iv) = iy-1;
    end
end
if L ~= 8
    % Vértices de cuadrado añadido superior izquierdo, cuadrado(s) añadido(s)
    % central(es) y cuadrado añadido inferior derecho:
    for six = 0.5:1:L-1.5
        siy = L - six;
        if six == 0.5
            iv = iv+1; x(iv)=six; y(iv)=siy;
        end
        iv = iv+1; x(iv)=six+0.5; y(iv)=siy;
        iv = iv+1; x(iv)=six+1; y(iv)=siy;
        iv = iv+1; x(iv)=six; y(iv)=siy-0.5;
        iv = iv+1; x(iv)=six+1; y(iv)=siy-0.5;
        iv = iv+1; x(iv)=six; y(iv)=siy-1;
        iv = iv+1; x(iv)=six+0.5; y(iv)=siy-1;
        iv = iv+1; x(iv)=six+1; y(iv)=siy-1;
    end
end

% Matriz de conexiones:
% Para cada punto P se buscan los puntos con igual abscisa que P y se los guarda en
% X. Se hace lo mismo para cada ordenada, y sus resultados se guardan en Y.
% Finalmente se pone la unión de X y Y como fila correspondiente de C.
C = zeros(iv);
for k = 1:iv
    X = x == x(k);
    Y = y == y(k);
    C(k,:) = or(X,Y);
end
for k = 1:iv
    C(k,k) = 0;
end
% Pasa el triángulo superior por filas al vector link:
link = zeros(iv*(iv+1)/2,1);
il = 0;
for i = 1:iv
    for j = i:iv
        il = il+1;
        link(il) = C(i,j);
    end
end
P = {link x y};

% Algoritmo para hallar las conexiones:
% Para cada punto P se buscan los puntos con igual abscisa que P y se los guarda en
% X. Se hace lo mismo para cada ordenada, y sus resultados se guardan en Y.
% Finalmente se pone la unión de X y Y como fila correspondiente de C.

C = zeros(iv);
for k = 1:iv
    X = x == x(k);
    Y = y == y(k);
    C(k,:) = or(X,Y);
end
for k = 1:iv
    C(k,k) = 0;
end
% Pasa el triángulo superior por filas al vector link, de dimensión nl:
nl = iv*(iv+1)/2;
link = zeros(nl,1);
il = 0;
for i = 1:iv
    for j = i:iv
        il = il+1;
        link(il) = C(i,j);
    end
end
P = {link x y};
switch L
    case 4
        save connectC P
        whos('-file','connectC')
    case 5
        save connectC5 P
        whos('-file','connectC5')
    case 8
        save connectC8 P
        whos('-file','connectC8')
    otherwise
        fprintf('No está previsto procesar un mosaico de cuadrados %d x %d\n',L,L)
        fprintf('No se guarda ningún resultado.\n')
end

