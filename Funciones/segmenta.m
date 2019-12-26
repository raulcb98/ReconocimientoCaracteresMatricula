function [Ietiq] = segmenta(R, numero_Objetos)

    % Umbralización Global
    T = graythresh(R) * 255;
    Ib = R < T;

    % Filtro de medias
    W = 12;
    Ib = imfilter(Ib, ones(W,W)/(W*W));

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
    
    % Eliminamos parte izquierda de la matricula
    Ietiq = bwlabel(Ib);
    Ietiq(Ietiq == 1) = 0;

end

