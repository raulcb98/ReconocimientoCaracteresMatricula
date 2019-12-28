%% *************************** PARTE 3 *****************************
%

%% INICIALIZACIÓN
%

clear all
clc

addpath('../Funciones');

%% PRIMERA FASE Obtención de imagen de trabajo
%

% Apartado 1.1

I = imread('../Imagenes/03_Imagenes_completas/08.JPG');
% imshow(I);

[numRows, numColumns, ~] = size(I);

newColumns = 120;
newRows = newColumns/numColumns * numRows;

I = imresize(I, [newRows, newColumns]);
% imshow(I);

% Apartado 1.2
Igray = rgb2gray(I);
% imshow(Igray);

% Apartado 1.3
Ilog = uint8(100+ 20*log(double(Igray)+1));
imshow(Ilog);

%% SEGUNDA FASE Detección de contornos horizontales de la placa
%

% Apartado 2.1 

Hx = [-1, 0, 1;
      -1, 0, 1;
      -1, 0, 1];

Gx = imfilter(double(Ilog), Hx, 'symmetric');
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

figure;
subplot(1,2,1);
    imshow(GxMod);
subplot(1,2,2);
    imshow(GxFilMod);

% Apartado 2.3
medias = mean(GxFilMod,2);
medias = medias(newRows:-1:1, 1);
plot(medias, -newRows:1:-1);

% Apartado 2.4
sizeWindow = round(0.1*length(medias));
medias = imfilter(medias, ones(sizeWindow,1)/sizeWindow, 'symmetric');
plot(medias, -newRows:1:-1);

% Apartado 2.5
[indexMaximo1,~] = find(medias == max(medias(:)));

f = 1:newRows;
mediasPonderado = (f' - indexMaximo1).^2 .* medias;
[indexMaximo2,~] = find(mediasPonderado == max(mediasPonderado(:)));






