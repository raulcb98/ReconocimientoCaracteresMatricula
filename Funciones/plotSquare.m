function plotSquare(f,c, window)

    [NT, MT] = size(window);

    NToffset = round(NT/2)-1;
    MToffset = round(MT/2)-1;

    squareCoords = [c-MToffset, f-NToffset;
                    c+MToffset, f-NToffset;
                    c+MToffset, f+NToffset;
                    c-MToffset, f+NToffset];

    line([squareCoords(1,1), squareCoords(2,1)], [squareCoords(1,2), squareCoords(2,2)], 'Color','red');
    line([squareCoords(2,1), squareCoords(3,1)], [squareCoords(2,2), squareCoords(3,2)], 'Color','red');
    line([squareCoords(3,1), squareCoords(4,1)], [squareCoords(3,2), squareCoords(4,2)], 'Color','red');
    line([squareCoords(4,1), squareCoords(1,1)], [squareCoords(4,2), squareCoords(1,2)], 'Color','red');

end