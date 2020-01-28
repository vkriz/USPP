function q = calcQualities(matrix)
%CALCQUALITY racuna kvalitetu svih clustera
    q0 = 0;
    q1 = 0;
    q2 = 0;
    
    c = calcConcepts(matrix);

    [m, n] = size(matrix);

    
    for i = 1 : m
        if matrix(i, 4305) == 0
            q0 = q0 + matrix(i, 1:4303) * c(1, :)';
        elseif matrix(i, 4305) == 1
            q1 = q1 + matrix(i, 1:4303) * c(2, :)';
        else
            q2 = q2 + matrix(i, 1:4303) * c(3, :)';
        end
    end
    
    q = [q0, q1, q2];
end

