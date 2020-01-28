function [newMatrix, bestVector] = nextFVAv(matrix, availableVectors)
%NEXTFVAV
    [m, n] = size(matrix);

    newMatrix = matrix;
    oldQuality = sum(calcQualities(matrix));
    
    maxQuality = oldQuality;
    bestVector = 1;
    bestCluster = matrix(1, 4305);
    for i = 1 : m
        if availableVectors(i) == 0 
            continue;
        end
        
        if matrix(i, 4305) == 0
            newMatrix(i, 4305) = 1;
            
            newQuality1 = sum(calcQualities(newMatrix));
            
            newMatrix(i, 4305) = 2;
            newQuality2 = sum(calcQualities(newMatrix));
            
            maxQ = max([newQuality1, newQuality2, maxQuality]);

            
            if maxQ == newQuality1
                bestVector = i;
                bestCluster = 1;
            end
            if maxQ == newQuality2
                bestVector = i;
                bestCluster = 2;
            end
            newMatrix(i, 4305) = 0;
        end
        
        if matrix(i, 4305) == 1
            newMatrix(i, 4305) = 0;
            newQuality1 = sum(calcQualities(newMatrix));
            newMatrix(i, 4305) = 2;
            newQuality2 = sum(calcQualities(newMatrix));
            
            maxQ = max([newQuality1, newQuality2, maxQuality]);
            
            if maxQ == newQuality1
                bestVector = i;
                bestCluster = 0;
            end
            if maxQ == newQuality2
                bestVector = i;
                bestCluster = 2;
            end
            newMatrix(i, 4305) = 1;
        end
        
        if matrix(i, 4305) == 2
            newMatrix(i, 4305) = 0;
            newQuality1 = sum(calcQualities(newMatrix));
            newMatrix(i, 4305) = 1;
            newQuality2 = sum(calcQualities(newMatrix));
            
            maxQ = max([newQuality1, newQuality2, maxQuality]);
            
            if maxQ == newQuality1
                bestVector = i;
                bestCluster = 0;
            end
            if maxQ == newQuality2
                bestVector = i;
                bestCluster = 1;
            end
            newMatrix(i, 4305) = 2;
        end
    end
    newMatrix(bestVector, 4305) = bestCluster;
end

