function bestMatrix = nextKLFV(matrix, f, tol)
%NEXTKLFV
    [m, n] = size(matrix);

        availableVectors = ones(1, m);
        objChange = [0];
        oldMatrix = matrix;
        matrices(:, :, 1) = matrix;
        for i = 1 : f
            [newMatrix, bestVector] = nextFVAv(matrix, availableVectors);
            availableVectors(bestVector) = 0;
            objChange(i) = sum(calcQualities(newMatrix)) - sum(calcQualities(matrix));
            matrices(:, :, i) = newMatrix;
            matrix = newMatrix;
        end
        
        maxChange = 0;
        maxIndex = 0; 
        for i = 1 : f
            newMax = maxChange + objChange(i);
            if newMax > maxChange
                maxIndex = maxIndex + 1;
                maxChange = newMax;
            end
        end

        if maxIndex == 0
            bestMatrix = oldMatrix;
        else
            bestMatrix = matrices(:, :, maxIndex);
        end
        
end

