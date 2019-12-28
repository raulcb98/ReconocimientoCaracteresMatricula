
%% ******************* 01_SEGMENTACIÓN ***************************
%

clear all
clc

addpath('../Funciones');

%% LECTURA DE PLANTILLAS
%

load('../Imagenes/00_Plantillas/Plantillas.mat')

var = eval('Objeto01Angulo01');

%% LECTURA DE IMÁGENES DE TRAINING E HISTOGRAMAS
%
I = imread('../Imagenes/01_Training/Training_04.jpg');
numero_Objetos = 7;
% imshow(I);

R = I(:,:,1);

figure;
subplot(2,1,1);
    imshow(R);
    title('Canal R');
subplot(2,1,2);
    imhist(R);
    title('Histograma canal R');

%% SEGMENTACIÓN DE IMÁGENES
%
Ietiq = segmenta(R,numero_Objetos);
imtool(Ietiq)

stats = regionprops(Ietiq,'BoundingBox');
bb = cat(1,stats.BoundingBox)

bb(1,:) = [];

bb = round(bb)

caracteres = {}

for i=1:size(bb,1)

    Ie = Ietiq(bb(i,2):bb(i,2)+bb(i,4), bb(i,1):bb(i,1) + bb(i,3));

    caracteres{i} = Ie > 0;
    
end

save('./Variables_Generadas/caracteres.mat', 'caracteres');

%% OTROS MÉTODOS DE SEGMENTACIÓN
%

% Umbralización Local
W = 7;
    
umbralesLocales = imfilter(R, ones(W,W)/(W*W));
umbralesLocales = umbralesLocales - 10;
imshow(R > umbralesLocales)
 
% Umbralización con stdfilt
W = 7;
desv = stdfilt(R,ones(W,W));
maximo = max(desv(:));
minimo = min(desv(:));
desv = mat2gray(desv,[minimo,maximo]);
imhist(desv)
imshow(desv < 0.3 )
