function [output] = cocientePerfilHorizontal(GxFilMod, indexMaximo)

    numColumnas = size(GxFilMod,2);
    indexMin = round(0.25 * numColumnas);
    indexMax = round(0.75 * numColumnas);
    
    perfilHorizontal = GxFilMod(indexMaximo,indexMin:indexMax);
    
    perfilHorizontalOrd = sort(perfilHorizontal, 'Ascend');
    
    numColumnas = size(perfilHorizontalOrd,2);
    index = round(0.25 * numColumnas);

    minValue = mean(perfilHorizontalOrd(1:index));
    maxValue = mean(perfilHorizontalOrd(index:numColumnas));
    
    output = maxValue/minValue;
    
end

