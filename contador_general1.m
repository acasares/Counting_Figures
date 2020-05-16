%contador_general1                   ACM                   Mayo 14 de 2020
% Resuelve Puzzles de contar figuras en mosaicos geom�tricos.
% Generalizaci�n de cuenta_tri�ngulos1.
% Control que permite buscar figuras regulares o irregulares.
% Esta versi�n ordena los puntos perimetrales en el sentido lev�giro y
% colorea en diagonales los escaques del tablero.

pointsAreCollinear = @(xy) rank(bsxfun(@minus,xy(2:end,:),xy(1,:))) == 1;
distanceConnected = @(x,y,pares) sqrt(diff(x(pares(:)))^2 + diff(y(pares(:)))^2);

clc
% diary 'general.txt'
imp = 0;% 0: S�lo figuras, 1: a�ada puntos colineales y no-figuras.
res = 3;% 0: No conexiones ni plot, 1: Conexiones, 2: Plot, 3: Ambos
clear link x y
spc(1:18)=' ';
nopc=10;
caso = 0;
while caso<1 | caso>nopc | isempty(caso)
    %Modo de ingreso:
    R=['S' 's' 'N' 'n'];
    clc
    fprintf('\n  %sCreaci�n de esquemas de conteo\n',spc)
    fprintf('  %s==============================\n\n',spc)
    fprintf('  %s1.-Contador de tri�ngulos con cruz a�adida\n',spc)
    fprintf('  %s2.-Contador de tri�ngulos sin cruz a�adida\n',spc)
    fprintf('  %s3.-Contador de cuadrados 4 x 4\n',spc)
    fprintf('  %s4.-Contador de cuadrados 5 x 5\n',spc)
    fprintf('  %s5.-Cuadrados en esquema con cruz a�adida\n',spc)
    fprintf('  %s6.-Cuadrados en esquema sin cruz a�adida\n',spc)
    fprintf('  %s7.-Cuadrados en tablero de ajedrez\n',spc)
    fprintf('  %s8.-Tri�ngulo de tri�ngulos 8 x 8\n',spc)
    fprintf('  %s9.-Tri�ngulo de rombos 8 x 8\n',spc)
    fprintf(' %s10.-Salir del programa\n\n',spc)
    while ~isfloat(caso) | (caso < 1 | caso > nopc)
        try
            caso=input('                    Escoja su opci�n:');
        catch iexc
            error('Opci�n inv�lida')
        end
    end
end
if caso==nopc, st=fclose('all'); return, end
if isempty(caso), st=fclose('all'); return, end
% Carga conexiones y coordenadas de los v�rtices de cada caso.
switch caso
    case 1
        load connectT1 P; NL = 3; reg = 0; fig = 'Tri�ngulo';
        name = 'Contador de tri�ngulos con cruz a�adida';
    case 2
        load connectT0 P; NL = 3; reg = 0;  fig = 'Tri�ngulo';
        name = 'Contador de tri�ngulos sin cruz en sus paneles';
    case 3
        load connectC P; NL = 4; reg = 1;  fig = 'Cuadrado';
        name = 'Contador de cuadrados 4 x 4';
    case 4
        load connectC5 P; NL = 4; reg = 1; fig = 'Cuadrado';
        name = 'Contador de cuadrados 5 x 5';
    case 5
        load connectT1 P; NL = 4; reg = 1; fig = 'Cuadrado';
        name = 'Cuadrados en esquema con cruz a�adida';
    case 6
        load connectT0 P; NL = 4; reg = 1; fig = 'Cuadrado';
        name = 'Cuadrados en esquema sin cruz a�adida';
    case 7
        load connectC8 P; NL = 4; reg = 1; fig = 'Cuadrado';
        name = 'Cuadrados en tablero de ajedrez';
    case 8
        load connectT8 P; NL = 3; reg = 0;  fig = 'Tri�ngulo';
        name = 'Tri�ngulo de tri�ngulos 8 x 8';
    case 9
        load connectT8 P; NL = 4; reg = 1; fig = 'Rombos';
        name = 'Tri�ngulo de rombos 8 x 8';
    otherwise
        link = []; x = []; y = [];
        return
end

link = P{1}; x = P{2}; y = P{3};
iv = numel(x);
C = fix(zeros(iv));
il = 0;
for j = 1:iv
    for i = j:iv
        il = il+1;
        C(i,j)=link(il); C(j,i)=link(il);
    end
end
% Imprime C:
if res == 1 || res == 3
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

%Gr�fico del sistema con numeraci�n de v�rtices:
if res == 2 || res == 3
    close all
    figure
    pares = combnk(1:iv,2); np = size(pares,1);
    % Plot del mosaico.
    gray = [1/2 1/2 1/2];
    lgray = [211,211,211]/255; % #d3d3d3 6/05/2020
    if ~any(caso == [8 9]) 
        % Tablero cuadriculado:
        for m = 0:2
            line([m m],[0 2],'color',gray)
            line([0 2],[m m],'color',gray)
        end
    end
    % Plot de las rectas del puzzle:
    for ip = 1:np
        G = pares(ip,:);
        ix1 = x(G(1)); iy1 = y(G(1));
        ix2 = x(G(2)); iy2 = y(G(2));
        if C(G(1),G(2))
            line([ix1 ix2],[iy1 iy2],'color',gray)
        end
    end
    for j = 1:iv
        text(x(j),y(j),num2str(j),'FontSize',8,'Color','red')
    end
    title(name)
    axis square
    hold on
    drawnow
end

% Recorre los grupos de NL v�rtices viendo si c/u forma una figura buscada o no.
fprintf('\nN�mero de v�rtices: %d\n\n',iv)
% N�mero de combinaciones de NL v�rtices:
V = combnk(1:iv,NL); nV = size(V,1);
% Deber�a examinar cada combinaci�n de NL v�rtices, y determinar si forman
% una figura buscada o no.
nfigs = 0;
for i = 1:nV
    G = V(i,:); % Un grupo de NL v�rtices.
    % Chequea colinealidad:
    colin = pointsAreCollinear([x(G(1:NL));y(G(1:NL))]');
    if colin
        if imp == 1
            fprintf('      Los v�rtices ')
            for k = 1:NL
                fprintf('%2d ',G(k))
            end
            fprintf('son colineales.\n')
        end
    else % No son colineales
        % Chequeo de continuidad
        % Ordena el per�metro counterclockwise:
        xCenter = mean(x(G)); yCenter = mean(y(G));
        angles = atan2((y(G)-yCenter),(x(G)-xCenter));
        [sortedAngles, sortedIndexes] = sort(angles);
        equis = x(G); ye = y(G);
        equis = equis(sortedIndexes);
        ye = ye(sortedIndexes); G = G(sortedIndexes);
        icon = 1;
        for l = 1:NL-1
            if ~C(G(l),G(l+1))
                icon = 0;
                break
            end
        end
        if icon && ~C(G(1),G(NL)), icon = 0; end
        if icon
            if polyarea(equis,ye) > 0
                R = [];R(1:NL,1) = G';R(1:NL-1,2)=G(2:NL)';R(NL,2)=G(1);                
                for id = 1:NL
                    ds(id) = distanceConnected(x,y,R(id,:));
                end
                % Si es necesario, controla lados de igual longitud:
                if ~reg || sum(ds(1) == ds(2:NL)) == NL-1
                    nfigs = nfigs +1;
                    fprintf('%2d .- %s ',nfigs,fig)
                    for k = 1:NL
                        fprintf('%2d ',G(k))
                    end
                    fprintf('\n')
                    if caso == 7 && ds(1) == 1
                        maxx = max(x(G(:)));maxy = max(y(G(:)));
                        if mod(fix(maxx),2) == mod(fix(maxy),2)
                            fill(x(G(:)),y(G(:)),lgray)
                            drawnow
                        end
                    end
                end
            elseif imp == 1
                fprintf('%s',spc(1:6))
                for k = 1:NL
                    fprintf('%2d ',G(k))
                end
                fprintf(' no es %s continuo.\n',fig)
            end
        end
    end
end
% Aclara la numeraci�n de v�rtices, da�ada al colorear.
if caso == 7
    for j = 1:iv
        text(x(j),y(j),num2str(j),'FontSize',8,'Color','red')
    end
end

% Resultados:
fprintf('Encontr� %d %ss\n',nfigs,fig)
diary off