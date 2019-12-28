function [] = visualiza_Resultado(I,P,f,c)

    [NF NC] = size(P);
    if(mod(NF,2) == 0)
         P(NF,:) = [];
    end
        
    if(mod(NC,2) == 0)
        P(:,NC) = [];
    end

    [NF NC] = size(P);

    xc = floor(NF/2);
    yc = floor(NC/2);
    
    fila = f - xc : f + xc;
    columna = c - yc : c + yc;
    
    imshow(I)
    hold on
    plot(c,f,'*r')
    line((c - yc)*ones(1,length(fila)), fila);
    line((c + yc)*ones(1,length(fila)), fila);
    line(columna, (f - xc)*ones(1,length(columna)));
    line(columna, (f + xc)*ones(1,length(columna)));

    
end

