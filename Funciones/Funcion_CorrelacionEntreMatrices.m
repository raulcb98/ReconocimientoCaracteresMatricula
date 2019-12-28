function [ValorCorrelacion] = Funcion_CorrelacionEntreMatrices(P, Vecindad)
       
    mediaP = mean(P(:));
    mediaVecindad = mean(Vecindad(:));
    
    matriz1 = P - mediaP;
    matriz2 = Vecindad - mediaVecindad;
    
    numerador1 = matriz1 .* matriz2;
    numerador = sum(numerador1(:));
        
    denominador1 = (matriz1.^2);
    den1 = sum(denominador1(:));
    
    denominador2 = (matriz2.^2);
    den2 = sum(denominador2(:));
    
    denominador = sqrt(den1 * den2);
    
    ValorCorrelacion = numerador/denominador;
    
end

