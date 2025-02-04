function [ImagenColorReducida] = recorta(Io)

    % Apartado 1.2
    Igrayo = rgb2gray(Io);
    % imshow(Igrayo);

    [numRows, numColumns, ~] = size(Igrayo);

    newColumns = 120;
    Igray = imresize(double(Igrayo), [NaN, newColumns]);
    newRows = size(Igray,1);
    % imshow(Igray);

    % Apartado 1.3
    Ilog = 100+ 20*log(double(Igray)+1);
    % imshow(uint8(Ilog));

    %% SEGUNDA FASE Detección de contornos horizontales de la placa
    %

    % Apartado 2.1 

    Hx = [-1, 0, 1;
          -1, 0, 1;
          -1, 0, 1];
    Hx = 1/6*Hx;

    Gx = imfilter(Ilog, Hx, 'symmetric');
    Gx = abs(Gx);

    minGx = min(Gx(:));
    maxGx = max(Gx(:));
    GxMod = mat2gray(Gx, [minGx, maxGx]);

    % Apartado 2.2 
    numRowsWindow = 3;
    numColumnsWindow = 24;
    indexPercentil80 = round(0.8*numRowsWindow*numColumnsWindow);
    GxFil = ordfilt2(Gx, indexPercentil80, ones(numRowsWindow, numColumnsWindow));

    minGxFil = min(GxFil(:));
    maxGxFil = max(GxFil(:));
    GxFilMod = mat2gray(GxFil, [minGxFil, maxGxFil]);

    % figure;
    % subplot(1,2,1);
    %     imshow(GxMod);
    % subplot(1,2,2);
    %     imshow(GxFilMod);

    % Apartado 2.3
    medias = mean(GxFilMod,2);
    % plot(medias(newRows:-1:1, 1), -newRows:1:-1);

    % Apartado 2.4
    sizeWindow = round(0.1*length(medias));
    vector_PSuav = imfilter(medias, ones(sizeWindow,1)/sizeWindow, 'symmetric');
    % plot(vector_PSuav(newRows:-1:1, 1), -newRows:1:-1);

    % Apartado 2.5
    [indexMaximo1,~] = find(vector_PSuav == max(vector_PSuav(:)));

    f = 1:newRows;
    mediasPonderado = (f' - indexMaximo1).^2 .* vector_PSuav;
    [indexMaximo2,~] = find(mediasPonderado == max(mediasPonderado(:)));

    if indexMaximo1 < indexMaximo2
        minValue = min(vector_PSuav(indexMaximo1:indexMaximo2));
        [indexMinValue,~] = find(vector_PSuav == minValue);
        indexMinValue(indexMinValue < indexMaximo1 | indexMinValue > indexMaximo2) = [];
    else
        minValue = min(vector_PSuav(indexMaximo2:indexMaximo1));
        [indexMinValue,~] = find(vector_PSuav == minValue);
        indexMinValue(indexMinValue < indexMaximo2 | indexMinValue > indexMaximo1) = [];
    end

    % Apartado 2.6
    maximos = [indexMaximo1, indexMaximo2];

    indexMin = round(0.1*newRows);
    indexMax = round(0.9*newRows);

    % Primer filtro
    maximos(maximos < indexMin | maximos > indexMax) = [];

    % Segundo filtro
    if length(maximos) == 1
        outputMax = maximos;

    else
        if vector_PSuav(indexMaximo2) <= 0.6 * vector_PSuav(indexMaximo1)
            outputMax = indexMaximo1;

        else
            cociente1 = cocientePerfilHorizontal(GxFilMod,indexMaximo1);
            cociente2 = cocientePerfilHorizontal(GxFilMod,indexMaximo2);

            if cociente1 > cociente2
                outputMax = indexMaximo1;
            else
                outputMax = indexMaximo2;
            end

        end
    end

    % Apartado 2.7
    if outputMax == indexMaximo1
        maxDiscard = indexMaximo2;
    else
        maxDiscard = indexMaximo1;
    end

    if indexMinValue > maxDiscard
        vector_PSuav(1:indexMinValue) = min(vector_PSuav(:));
    else
        vector_PSuav(indexMinValue:length(vector_PSuav)) = min(vector_PSuav(:));
    end

    % plot(vector_PSuav(newRows:-1:1, 1), -newRows:1:-1);

    % Aparatado 2.8
    umbral = 0.6 * vector_PSuav(outputMax); % hemos considerado 0.4 para presentacion

    vector_PSuav_Mod = vector_PSuav;
    vector_PSuav_Mod(vector_PSuav_Mod >= umbral) = 0;
    % plot(vector_PSuav_Mod(newRows:-1:1, 1), -newRows:1:-1);

    [fila_min_placa,~] = find(vector_PSuav_Mod == max(vector_PSuav_Mod(1:outputMax)));
    [fila_max_placa,~] = find(vector_PSuav_Mod == max(vector_PSuav_Mod(outputMax:length(vector_PSuav_Mod))));

    % Holgura
    fila_min_placa = fila_min_placa-2;
    fila_max_placa = fila_max_placa+2;

    % Apartado 2.9
    Ired = Igray(fila_min_placa:fila_max_placa, :);
    % imshow(uint8(Ired));

    %% TERCERA FASE Detección de contornos verticales de la placa
    %

    % Apartado 3.1
    Hx = [-1, 0, 1;
          -1, 0, 1;
          -1, 0, 1];
    Hx = 1/6 * Hx;

    Gx = imfilter(double(Ired), Hx, 'symmetric');
    Gx = abs(Gx);

    minGx = min(Gx(:));
    maxGx = max(Gx(:));
    GxMod = mat2gray(Gx, [minGx, maxGx]);
    % imshow(GxMod);

    % Apartado 3.2
    numFilas = size(GxMod,1);
    H = ones(round(numFilas/2),1);

    GxOpen = imopen(GxMod,H);
    % imshow(GxOpen);

    % Apartado 3.3
    numColumnas = size(GxOpen,2);
    medias = mean(GxOpen);
    % plot(1:numColumnas, medias);

    % Apartado 3.4
    sizeWindow = 3;
    vector_PSuav = imfilter(medias, ones(1,sizeWindow)/sizeWindow, 'symmetric');

    minVector_PSuav = min(vector_PSuav(:));
    maxVector_PSuav = max(vector_PSuav(:));
    vector_PSuav = mat2gray(vector_PSuav,[minVector_PSuav , maxVector_PSuav]);

    % plot( 1:numColumnas , vector_PSuav);

    % Aparatado 3.5
    vector_PSuavOrd = sort(vector_PSuav,'Descend');
    umbral = 0.25 * vector_PSuavOrd(3);

    [~,indexColumns] = find(vector_PSuav > umbral);

    % Apartado 3.6
    B = Io(:,:,3);
    B = imresize(double(B), [newRows, newColumns]);
    Bred = B(fila_min_placa:fila_max_placa,:);

    numColumnas = size(Bred,2);
    mediasBred = mean(Bred);
    mediasBredOrd = sort(mediasBred,'Ascend');
    percentil20 = mediasBredOrd(1,round(0.2 * numColumnas)); % hemos considerado 0.1 para presentacion

    indexValuesColumns = mediasBred(indexColumns);
    [~,indexIndexColumns] = find(indexValuesColumns > percentil20);

    indexColumns = indexColumns(indexIndexColumns);

    % Apartado 3.7
    columna_min_placa = min(indexColumns(:));
    columna_max_placa = max(indexColumns(:));

    %% CUARTA FASE Segmentación de la placa de la matrícula
    %

    % Apartado 4.1
    [numRows, numColumns, ~] = size(Io);

    factorAumento = numRows/newRows;

    columna_min_placa_o = round(factorAumento * columna_min_placa);
    columna_max_placa_o = round(factorAumento * columna_max_placa);
    fila_min_placa_o = round(factorAumento * fila_min_placa);
    fila_max_placa_o = round(factorAumento * fila_max_placa);

    IoRed = Io(fila_min_placa_o:fila_max_placa_o, columna_min_placa_o:columna_max_placa_o,:);
    % imshow(IoRed);

    % Apartado 4.2
    [~,numColumnsRed,~] = size(IoRed);

    factor = 50;

    indexColumnIni = round(numColumnsRed/factor)+1;
    indexColumnFin = numColumnsRed-round(numColumnsRed/factor);

    % Apartado 4.3
    ImagenColorReducida = IoRed(:, indexColumnIni:indexColumnFin,:);
    % imshow(ImagenColorReducida);

end

