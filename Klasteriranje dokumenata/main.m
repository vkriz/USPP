%ucitavamo podatke
load('A.mat');
load('labels.mat');
A = full(A);

%radimo matricu B, koja sadrži A i 2 dodatna stupca, 1 predstavlja stvarne
%klastere, a drugi početnu particiju.
% [m, n] = size(A);
% 
% for i = 1 : m
%     A(i, :) = A(i, :) / norm(A(i, :));
% end
% A = [A labels];
% 
%  clusterSize = 100;

% r1 = randperm(1033, clusterSize);
% r1 = r1(1:clusterSize);
% r2 = randperm(1033, clusterSize);
% vec1033 = 1033 * ones(1, clusterSize);
% r2 = r2(1:clusterSize) + vec1033;
% r3 = randperm(1033, clusterSize);
% vec2493 = 2493 * ones(1, clusterSize);
% r3 = r3(1:clusterSize) + vec2493;
% 
% % odabrane dokumente random permutiramo
% r = [r1, r2, r3];
% r = r(randperm(3*clusterSize));
% 
% for i = 1 : 3*clusterSize
%     if i == 1
%         B = [A(r(i), :)];
%     else
%         B = [B; A(r(i), :)];
%     end
% end
% 
% clusterArray = [0];
% 
% for i = 1 : 3*clusterSize
%     clusterArray(i) = 0;
%     if i > clusterSize
%         clusterArray(i) = 1;
%     end
%     
%     if i > 2*clusterSize
%         clusterArray(i) = 2;
%     end
% end
% 
% B = [B clusterArray'];

%Testni B-ovi
load('B-(30d,0.0001tol,50f).mat', 'B');
 %load('B-(300d,0.001tol,3f).mat', 'B');

% "fiksiramo polozaj vektora", kasnije mijenjamo samo labele
% projekcija svih vektora na 2d
Y2d = tsne(B(:, 1:4303), 'Algorithm', 'barneshut', 'NumPCAComponents', 50);
% projekcija svih vektora na 3d
Y3d = tsne(B(:, 1:4303), 'Algorithm', 'barneshut', 'NumPCAComponents', 50, 'NumDimensions', 3);

drawClusters2d(Y2d, B(:, 4304));
drawClusters2d(Y2d, B(:, 4305));

c = calcConcepts(B);

q = calcQualities(B);
q1 = sum(q);

kMatrix = kMeans(B, 0.001);
q2 = sum(calcQualities(kMatrix));
drawClusters2d(Y2d, kMatrix(:, 4305));

refMatrix = refinementAlgorithm(B, 50, 0.001);
q3 = sum(calcQualities(refMatrix));
drawClusters2d(Y2d, refMatrix(:, 4305));