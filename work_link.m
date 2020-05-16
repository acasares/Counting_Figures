%work_link                     ACM                        26-Abril-2020
% Función para leer, cambiar un elemento y volver a grabar el arreglo link,
% vector lineal que guarda por filas el triángulo superior de la matriz C
% de conexiones rectilíneas, utilizado en los guiones de conteo.
% function [link,x,y] = work_link(caso,i,j,imp)
% caso: 1 Triángulos con paneles con cruz añadida.
% caso: 2 Triángulos sin cruz añadida en los paneles.
% caso: 3 Cuadrados.

% i,j:  Abscisa y ordenada del elemento que se va a cambiar en la matriz C.
%       Para sólo ver C y el esquema, debe darse sólo el argumento caso.
% imp:  Indicador de impresión de la C cambiada.
function [link,x,y] = work_link(caso,i,j,imp)
if nargin < 4, imp = 0; end
if nargin == 1, imp = 3; i=0; j=0; end % 29 04 2020
% Carga conexiones y coordenadas de los vértices de cada caso.
switch caso
    case 1
        load connectT1 P
        name = 'Contador de triángulos con cruz añadida';
    case 2
        load connectT0 P
        name = 'Contador de triángulos sin cruz en sus paneles';
    case 3
        load connectC P
        name = 'Contador de cuadrados';
    otherwise
        link = []; x = []; y = [];
        return
end
link = P{1}; x = P{2}; y = P{3};
iv = numel(x); %Número de vértices y orden de C = (-1+sqrt(1+8*numel(link)))/2;
if (i > 0 & i <= iv & j > 0 & j <= iv) || (i == 0 & j == 0)
    % Halla el índice lineal del elemento (i,j) en el arreglo link
    if i > j, t = i; i = j; j = t; end
    ij = (2*iv-i+2)*(i-1)/2+(j-i+1); % Fórmula fundamental
    if i>0 && j>0
        t0 = link(ij);link(ij)=1-t0;
        fprintf('El elemento C(%d,%d) era %d. Se cambió a %d\n',i,j,t0,link(ij))
        % Reemplaza en el archivo el arreglo ya cambiado.
        P = {link x y};
        switch caso
            case 1
                save connectT1 P
            case 2
                save connectT0 P
            otherwise
                return
        end
    end
    if imp
        C = zeros(iv);
        % A partir de link arma C:
        il = 0;
        for i0 = 1:iv
            for j0 = i0:iv
                il = il+1;
                C(i0,j0)=link(il);
                C(j0,i0)=link(il);
            end
        end
        if imp==1 || imp ==3
            % Imprime C:
            fprintf('%s\n',name)
            fprintf('MATRIZ DE CONEXIONES RECTILINEAS:\n')
            fprintf('   ')
            for i = 1:fix(iv/10)
                fprintf('%20d',i)
            end
            fprintf('\n   ')
            for i = 1:iv
                fprintf('%2d',mod(i,10))
            end
            fprintf('\n---')
            for i = 1:iv
                fprintf('--')
            end
            fprintf('\n')
            for i = 1:iv
                fprintf('%2d.-',i)
                for j = 1:iv
                    fprintf('%1d ',C(i,j))
                end
                fprintf('\n')
            end
        end
        if imp==2 || imp == 3
            close all
            figure
            pares = combnk(1:iv,2); np = size(pares,1);
            % Plot del mosaico.
            % Tablero cuadriculado:
            grey = [1/2 1/2 1/2];
            for m = 0:2
                line([m m],[0 2],'color',grey)
                line([0 2],[m m],'color',grey)
            end
            % Plot de las rectas del puzzle:
            for ip = 1:np
                G = pares(ip,:);
                ix1 = x(G(1)); iy1 = y(G(1));
                ix2 = x(G(2)); iy2 = y(G(2));
                if C(G(1),G(2))
                    line([ix1 ix2],[iy1 iy2],'color',grey)
                end
            end
        end
        title(name)
        axis square
        axis off
    end
end



