
%% *************************** ENTREGA **************************
%

%% INICIALIZACIÓN
%

clear all
clc

addpath('../Funciones');

%% PRUEBA DE TRAINING
%

% numero_Objetos = [7,7,6,7];
% for i = 1:length(numero_Objetos)
%     path = ['../Imagenes/01_Training/Training_', num2str(i, '%02d'), '.jpg'];
%     Funcion_Reconoce_Matricula(path, numero_Objetos(i));
%     pause;
% end
% 
% close all
% 
% %% PRUEBA DE TEST
% %
% 
% numero_Objetos = [7,6,7,7,7,7,7,6,6,6,7,7,7,7,7,7,7,7,7,6];
% for i = 1:length(numero_Objetos)
%     path = ['../Imagenes/02_Test/Test_', num2str(i, '%02d'), '.jpg'];
%     Funcion_Reconoce_Matricula(path, numero_Objetos(i));
%     pause;
% end
% 
% close all

%% PRUEBA DE AMPLIACIÓN
%

numero_Objetos = [7,7,7,7,7,6,6,7,7,7,7,6,7,7,7,7,7,7];
for i = 1:length(numero_Objetos)
    path = ['../Imagenes/03_Imagenes_completas/', num2str(i, '%02d'), '.JPG'];
    Funcion_Reconoce_Matricula(path, numero_Objetos(i));
    pause;
end

close all
