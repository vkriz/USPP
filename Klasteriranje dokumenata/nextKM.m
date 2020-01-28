function newMatrix = nextKM(matrix)
%NEXTKM racuna sljedecu iteraciju kMeans algoritma sa spherical udaljenosti
    c = calcConcepts(matrix);
    [m, n] = size(matrix);
    newMatrix = matrix;
    
    for i = 1 : m
        dist0 = matrix(i, 1:4303) * c(1, :)';
        dist1 = matrix(i, 1:4303) * c(2, :)';
        dist2 = matrix(i, 1:4303) * c(3, :)';
        
        maxdist = max([dist0, dist1, dist2]); 

        if maxdist == dist0
            newMatrix(i, 4305) = 0;
        end
        if maxdist == dist1
            newMatrix(i, 4305) = 1;
        end
        if maxdist == dist2
            newMatrix(i, 4305) = 2;
        end
    end
end

