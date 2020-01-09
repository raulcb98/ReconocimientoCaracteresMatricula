function [caracteres, centroides] = segmenta(R, numero_Objetos)

    % Umbralización local
    W = 70;
    umbralesLocales = imfilter(R, ones(W,W)/(W*W));
    umbralesLocales = umbralesLocales - 4;
    Ib = R < umbralesLocales;

    % Filtrado de línea central
    Ietiq = bwlabel(Ib);
    
    filaCentral = round(size(R,1)/2);
    etiquetasValidas = unique(Ietiq(filaCentral,:));
    etiquetasValidas(etiquetasValidas == 0) = [];
    
    Ib = false(size(Ietiq));
    for i=1:length(etiquetasValidas)
        Ib = Ib | Ietiq == etiquetasValidas(i);
    end
    
    % Filtrado de mayores agrupaciones
    Ietiq = bwlabel(Ib);
    stats = regionprops(Ietiq,'Area');
    areas = cat(1,stats.Area);

    [~,ind] = sort(areas,'descend');

    etiquetasMayores = ind(1:numero_Objetos+1);

    Ib = false(size(Ietiq));
    for i=1:length(etiquetasMayores)
        Ib = Ib | Ietiq == etiquetasMayores(i);
    end
    
    % Cierre morfológico
    W = 4;
    Ib = imclose(Ib, ones(W,W));
    
    % Eliminamos parte izquierda de la matricula
    Ietiq = bwlabel(Ib);
    Ietiq(Ietiq == 1) = 0;
   
    % Recortamos el bounding box
    stats = regionprops(Ietiq,'BoundingBox');
    bb = cat(1,stats.BoundingBox);

    bb(1,:) = [];
    bb = round(bb);

    caracteres = {};
    centroides = zeros(size(bb,1),2);
    for i=1:size(bb,1)
        Ie = Ietiq(bb(i,2):bb(i,2)+bb(i,4), bb(i,1):bb(i,1) + bb(i,3));
        caracteres{i} = Ie > 0;
        
        centroides(i,1) = bb(i,1) + round(bb(i,3)/2);
        centroides(i,2) = bb(i,2) + round(bb(i,4)/2);
    end

end

