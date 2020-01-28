function drawClusters3d(matrix, labels)
    %DRAWCLUSTERS crta clustere u 3d
    figure
    scatter3(matrix(:,1), matrix(:,2), matrix(:,3), 15, labels, 'filled');
end

