function c = calcConcepts(matrix)
%CALCCONCEPTS racuna koncept vektore za trenutne clustere
    [m, n] = size(matrix);
    sum0 = zeros(1, 4303);
    sum1 = zeros(1, 4303);
    sum2 = zeros(1, 4303);
    
    for i = 1 : m
        if matrix(i, 4305) == 0
            sum0 = sum0 + matrix(i, 1:4303);
        elseif matrix(i, 4305) == 1
            sum1 = sum1 + matrix(i, 1:4303);
        else
            sum2 = sum2 + matrix(i, 1:4303);
        end
    end
    
    c0 = sum0 / norm(sum0);
    c1 = sum1 / norm(sum1);
    c2 = sum2 / norm(sum2);
    c = [c0; c1; c2];
end

