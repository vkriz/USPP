function drawClusters2d(matrix, labels)
    %DRAWCLUSTERS crta clustere u 2d
    figure
    gscatter(matrix(:,1), matrix(:,2), labels);
end

