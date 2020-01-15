function analizaResultados(matrixCorr, matricula)

    caracteresPosibles = '0123456789ABCDFGHKLNRSTXYZ';

    [numRows,~] = size(matrixCorr);
    
    datos = {};
    
    for i=1:numRows
    
        [valuesOrd , ind] = sort(matrixCorr(i,:), 'descend');
        
        %("Caracter reconocido : ");
        datos{i,1} = matricula(i);
        datos{i,2} = caracteresPosibles(ind(1:5));
        datos{i,3} = valuesOrd(1,1); 
        datos{i,4} = valuesOrd(1,2); 
        datos{i,5} = valuesOrd(1,3); 
        datos{i,6} = valuesOrd(1,4); 
        datos{i,7} = valuesOrd(1,5); 

    end
    
    clc
    
    disp("Analisis de resultados");
    disp(datos);
    
end

