load('A.mat');
B = A';
[row, col, val] = find(B);
[n, m] = size(B);
for i = 1:n
    num = sum(B(:,i));
    if(num ~= 0 && num ~=1)
        B(:,i) = B(:,i)/num;
    end
end

B = B';