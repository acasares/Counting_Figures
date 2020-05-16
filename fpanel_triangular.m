% fpanel_triangular              ACM                  6 de mayo 2020
% Función para dibujar un panel triangular de triángulos y obtener las
% coordenadas de los vértices.
function fpanel_triangular(L)
close all
name = 'Cuenta triángulos en triángulo';
% Dibuja todas las rectas de la malla triangular
for ix = 0:L-1
    line([0.5*ix L-0.5*ix],[ix ix],'color','k');
    line([ix 0.5*(L+ix)],[0 L-ix],'color','k');
    line([L-ix 0.5*(L-ix)],[0 L-ix],'color','k');
end
% Abscisas y Ordenadas
iv = 0;
for iy = 0:L
    for ix = iy:L
        iv = iv+1;
        x(iv)= ix-0.5*iy;
        y(iv)= iy;
    end
end
for j = 1:iv
    text(x(j),y(j),num2str(j),'FontSize',8,'Color','red')
end
title(name)
axis square
axis off
drawnow
% Matriz de conexiones:
% Se conectan los puntos con igual ordenada o que estén sobre cualquiera de
% las rectas oblicuas del gráfico: es decir, las que se unan con un segmento
% de pendiente 2 o -2:
C = zeros(iv);
for p1 = 1:iv
    for p2 = p1+1:iv
        if y(p1) == y(p2), C(p1,p2) = 1; end
        t = (y(p2)-y(p1))/(x(p2)-x(p1));
        if abs(t) == 2, C(p1,p2) = 1;end
    end
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
save connectT8 P
whos('-file','connectT8')
