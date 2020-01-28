function newMatrix = refinementAlgorithm(matrix, f, tol)
%REFINEMENTALGORITHM

    t = 0 ;
    while true
        newKMMatrix = kMeans(matrix, tol);
        KMQuality = sum(calcQualities(newKMMatrix));
        newKLFVMatrix = nextKLFV(newKMMatrix, f, tol);
        KLFVQuality = sum(calcQualities(newKLFVMatrix));
        
        if KLFVQuality - KMQuality < tol
            newMatrix = newKLFVMatrix;
            break;
        end
        matrix = newKLFVMatrix;
        t = t + 1;
    end
end

