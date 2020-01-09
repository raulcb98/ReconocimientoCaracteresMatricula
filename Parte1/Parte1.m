
%% ******************* 01_SEGMENTACIÓN ***************************
%

clear all
clc

addpath('../Funciones');

%% LECTURA DE PLANTILLAS
%

load('../Imagenes/00_Plantillas/Plantillas.mat')

%% LECTURA DE IMÁGENES DE TRAINING
%
I = imread('../Imagenes/01_Training/Training_04.jpg');
numero_Objetos = 7;
% imshow(I);

R = I(:,:,1);

%% SEGMENTACIÓN DE IMÁGENES
%
caracteres = segmenta(R,numero_Objetos);
save('./Variables_Generadas/caracteres.mat', 'caracteres');
