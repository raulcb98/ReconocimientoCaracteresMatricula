
%% ******************* 01_SEGMENTACIÓN ***************************
%

clear all
clc

addpath('Funciones');

%% LECTURA DE PLANTILLAS
%

load('../Imagenes/00_Plantillas/Plantillas.mat')

var = eval('Objeto01Angulo01');

%% LECTURA DE IMÁGENES DE TRAINING
%

I = imread('../Imagenes/01_Training/Training_03.jpg');
% imshow(I);

R = I(:,:,1);
figure;
subplot(2,1,1);
    imshow(R);
    title('Canal R');
subplot(2,1,2);
    imhist(R);
    title('Histograma canal R');
    
umbralesLocales = imfilter(R, ones(7,7)/(7*7));
umbralesLocales = umbralesLocales - 10;
imshow(R < umbralesLocales)
    
    
