function newMatrix = kMeans(matrix, tol)
%KMEANS racuna kmeans koristeci nextKM
    t = 0;
    
    while true
        newMatrix = nextKM(matrix);
        newQuality = sum(calcQualities(newMatrix));
        oldQuality = sum(calcQualities(matrix));
        if newQuality - oldQuality < tol
            break;
        end
        matrix = newMatrix;
        t = t + 1;
    end
end

