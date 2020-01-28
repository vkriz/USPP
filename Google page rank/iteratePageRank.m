function [ y, res ] = iteratePageRank( P, alpha, v, x, res )
y = P * x;
y = alpha * y;
d = 1 - norm(y, 1);
y = y + d*v;
res = norm(y-x, 1);
disp(res);
end

