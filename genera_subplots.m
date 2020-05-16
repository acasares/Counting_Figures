%genera_subplots                   ACM                   Mayo 8 de 2020
% Grafica sucesivamente todos los Puzzles de contar figuras en mosaicos
% en una sola figura.

clc, close all
clear link x y
% spc(1:18)=' ';
nopc=9;
orden = [2 1 3 4 7 8];

for ica = 1:6
    caso = orden(ica);
    % Carga conexiones y coordenadas de los vértices de cada caso.
    switch caso
        case 1
            load connectT1 P; NL = 3; fig = 'Triángulo';
            name = 'Contador de triángulos con cruz añadida';
        case 2
            load connectT0 P; NL = 3; fig = 'Triángulo';
            name = 'Contador de triángulos sin cruz en sus paneles';
        case 3
            load connectC P; NL = 4; fig = 'Cuadrado';
            name = 'Contador de cuadrados 4 x 4';
        case 4
            load connectC5 P; NL = 4; fig = 'Cuadrado';
            name = 'Contador de cuadrados 5 x 5';
        case 5
            load connectT1 P; NL = 4; fig = 'Cuadrado';
            name = 'Cuadrados en esquema con cruz añadida';
        case 6
            load connectT0 P; NL = 4; fig = 'Cuadrado';
            name = 'Cuadrados en esquema sin cruz añadida';
        case 7
            load connectC8 P; NL = 4; fig = 'Cuadrado';
            name = 'Cuadrados en tablero de ajedrez';
        case 8
            load connectT8 P; NL = 3; fig = 'Triángulo';
            name = 'Triángulo de triángulos 8 x 8';
            %         load connectT8 P; NL = 4; fig = 'Rombos';
            %         name = 'Triángulo de rombos 8 x 8';
        otherwise
            link = []; x = []; y = [];
            fprintf('Proceso terminado\n')
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
    
    %Gráfico del sistema
    %close all
    %figure
    subplot(3,2,ica);
    pares = combnk(1:iv,2); np = size(pares,1);
    % Plot del mosaico.
    gray = [1/2 1/2 1/2];
    lgray = [211,211,211]/255; % #d3d3d3 6/05/2020
    if caso ~= 8
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
    title(['Ejemplo ' num2str(ica)],'FontSize',6,'Color','k')
    axis square
    axis off
    hold on
    drawnow
    
    %if ica == 6, suptitle({'Ejemplos propuestos'}), end
    if ica == 6, mtit('Ejemplos propuestos','fontsize',12,'color','k',...
'xoff',0,'yoff',.025); end

end
