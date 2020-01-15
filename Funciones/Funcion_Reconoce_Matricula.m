function Funcion_Reconoce_Matricula(nombre, numero_Objetos)

    I = imread(nombre);
    I = recorta(I);
    R = I(:,:,1);
    
    [caracteres, centroides] = segmenta(R,numero_Objetos);
    [matricula, matrixCorr] = reconoce(caracteres);
    
    figure;
    imshow(I); hold on;
    for i = 1:size(centroides,1)
        f = centroides(i,1);
        c = centroides(i,2);
        
        plot(f,c,'*r')
        plotSquare(c, f, caracteres{i});   
    end
    
    title(matricula);
    
    analizaResultados(matrixCorr, matricula);
    
end

