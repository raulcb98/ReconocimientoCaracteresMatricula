function [output] = reconoce(caracteres)

    load('../Imagenes/00_Plantillas/Plantillas.mat')

    caracteresPosibles = '0123456789ABCDFGHKLNRSTXYZ';
    angulosPosibles = -9:3:9;

    matrixCorr = zeros(length(caracteres), length(caracteresPosibles));
    for i = 1:length(caracteres)
        for numCaracter=1:length(caracteresPosibles)
           for numAngulo = 1:length(angulosPosibles)
               templateName = ['Objeto', num2str(numCaracter, '%02d'), 'Angulo', num2str(numAngulo, '%02d')];

               plantilla = eval(templateName);

               caracterRedim = imresize(caracteres{i}, size(plantilla));

               valorCorr = Funcion_CorrelacionEntreMatrices(caracterRedim, plantilla);

               if matrixCorr(i, numCaracter) < valorCorr
                    matrixCorr(i, numCaracter) = valorCorr;
               end
           end
        end
    end

    output = [];
    for i = 1:length(caracteres)
        [~,indexCaracter] = find(matrixCorr(i,:) == max(matrixCorr(i,:),[],2));
        output= [output, caracteresPosibles(indexCaracter)];
    end

end

