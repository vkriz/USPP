function [y, res, I ] = powerRank( A, c, tol )
[n, m] = size(A);
uniform = ones(n, 1)/n;
v = uniform;
s = uniform;
I = 0; res = 1;
alpha = c;
y=v;
while res > tol
    [y, res] = iteratePageRank(A, alpha, uniform, y, res);
    I = I + 1;
end

end

