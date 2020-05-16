% crea_conteos                ACM                     27 de Abril de 2020
% Guion para crear y archivar esquemas de conteo de un tipo de figura en
% un mosaico geométrico.
% Recibe como datos, o crea, en cada nuevo esquema, el arreglo lineal link,
% que contiene por filas el triángulo superior de la matriz de conexiones y
% los vectores de abscisas x y de ordenadas y de los vértices.
% Como resultado guarda con save, en un archivo específico, P = {link, x, y}
clear link x y
spc(1:18)=' ';
nopc=7;
caso = 0;
while caso<1 | caso>nopc | isempty(caso)
    %Modo de ingreso:
    R=['S' 's' 'N' 'n'];
    clc
    fprintf('\n %sCreación de esquemas de conteo\n',spc)
    fprintf(' %s=============================\n\n',spc)
    fprintf(' %s1.-Contador de triángulos con cruz añadida\n',spc)
    fprintf(' %s2.-Contador de triángulos sin cruz añadida\n',spc)
    fprintf(' %s3.-Contador de cuadrados 4 x 4\n',spc)
    fprintf(' %s4.-Contador de cuadrados 5 x 5\n',spc)
    fprintf(' %s5.-Cuadrados en un tablero de ajedrez\n',spc)
    fprintf(' %s6.-Triángulo de triángulos 8 x 8\n',spc)
    fprintf(' %s7.-Salir del programa\n\n',spc)
    while ~isfloat(caso) | (caso < 1 | caso > nopc)
        try
            caso=input('                    Escoja su opción:');
        catch iexc
            error('Opción inválida')
        end
    end
end
if caso==nopc, st=fclose('all'); return, end
if isempty(caso), st=fclose('all'); return, end
switch caso
    case 1
        name = 'Contador de triángulos con cruz añadida';
        title('Cuenta triángulos')
        % Asignación de coordenadas a los vértices:
        iv = 0;
        for iy = 1:5
            for ix = 1:5
                iv = iv+1;
                x(iv) = (ix-1)*0.5; y(iv) = (iy-1)*0.5;
            end
        end
        % Matriz de conexiones:
        link = [0 1 1 1 1 1 1 0 0 0 1 0 1 0 0 1 0 0 1 0 1 0 0 0 1 0 1 1 1 0 1 0 0 0 0 ...
            1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 1 0 1 1 1 0 1 0 1 0 1 0 0 1 0 0 0 0 1 0 0 ...
            0 1 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 1 1 0 0 1 0 1 0 1 0 0 ...
            1 1 0 0 0 1 0 1 1 1 1 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 1 1 1 0 1 1 0 0 0 1 ...
            0 1 0 0 1 0 0 1 0 1 1 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 1 0 0 1 1 1 0 1 0 1 ...
            0 1 0 0 1 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 1 1 1 1 1 1 0 0 0 1 0 1 0 0 ...
            0 1 1 1 0 1 0 0 0 0 1 0 0 0 0 1 1 0 1 1 1 0 0 0 1 0 1 0 1 0 0 0 1 0 0 0 0 ...
            1 0 0 0 0 0 1 1 0 0 1 0 1 0 1 1 1 1 1 0 0 0 0 0 1 1 1 1 1 1 0 0 0 1 1 0 0 ...
            1 0 0 0 1 0 0 1 1 1 0 0 0 0 0 1 0 1 1 1 1 0 1 1 1 0 1 1 0 1 0];
        P = {link x y};
        save connectT1 P
    case 2
        name = 'Contador de triángulos sin cruz en sus paneles';
        % Asignación de coordenadas a los vértices:
        % Los primeros 9 son sencillos:
        iv = 0;
        for iy = 1:3
            for ix = 1:3
                iv = iv+1;
                x(iv) = ix-1; y(iv) = iy-1;
            end
        end
        % Vértices correspondientes a cruces de diagonales de paneles pequeños:
        iv = iv +1; x(iv) = 0.5; y(iv) = 0.5;
        iv = iv +1; x(iv) = 1.5; y(iv) = 0.5;
        iv = iv +1; x(iv) = 0.5; y(iv) = 1.5;
        iv = iv +1; x(iv) = 1.5; y(iv) = 1.5;
        
        % Matriz de conexiones:
        link = [0 1 1 1 1 0 1 0 1 1 0 0 1 0 1 1 1 1 0 1 0 1 1 0 0 0 0 1 1 1 0 1 0 1 ...
            1 0 0 1 1 1 1 0 1 0 1 0 0 1 1 1 1 1 1 1 1 0 0 1 1 0 1 0 1 0 1 1 0 1 1 0 ...
            0 1 0 0 1 1 0 1 0 0 1 0 0 0 1 0 1 0 0 0 0];
        P = {link x y};
        save connectT0 P
    case 3
        fcrea_conexion(4)
    case 4
        fcrea_conexion(5)
    case 5
        fcrea_conexion(8)
    case 6
        fpanel_triangular(8);
    otherwise
        return
end
