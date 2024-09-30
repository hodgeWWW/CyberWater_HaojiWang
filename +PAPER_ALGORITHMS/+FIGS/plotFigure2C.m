% ----------------------------------------------------------------------------------------------
% 
% Copyright (c) 2021, German A. Villalba, Xu Liang, and Yao Liang
% All rights reserved.
% 
% This is our research open source codes for (1) selecting donor gauges and 
% (2) removing gauges with minimum loss of information based on Graphical Model 
% under the Open Source License GPL. 
%
% If you use our codes, please cite our work below. Thanks.
%  
% Villalba, G. A., Liang, X., & Liang, Y. (2021).
% Selection of multiple donor gauges via graphical lasso for estimation of daily streamflow time series. 
% Water Resources Research, 57, e2020WR028936. 
% https://doi.org/10.1029/2020WR028936
% 
% ----------------------------------------------------------------------------------------------
function [  ] = plotFigure2C()
    folder = './PRELOAD/';
    filename = [folder 'Results_Figure2C.csv'];

    data = dlmread(filename);
    nrows = size(data, 1);
    avgData = zeros(nrows,3);
    distIdx   = [1 4 7];
    corrIdx   = [2 5 8];
    glassoIdx = [3 6 9];
    for row = 1:nrows
        dist_r   = mean(data(row, distIdx));
        corr_r   = mean(data(row, corrIdx));
        glasso_r = mean(data(row, glassoIdx));
        avgData(row, 1) = dist_r;
        avgData(row, 2) = corr_r;
        avgData(row, 3) = glasso_r;
    end

    days = [
        45
        90
        180
        365
        730
        1095
        1460
        1825
        2190
        2555
        2920
        3285
        3650
    ];

     [ colorDist, colorCorr, colorGlasso ] = PAPER_ALGORITHMS.ALTERNATIVE.PLOT.getComparisonColors();

    hold on;
    plot(days,avgData(:,1),'-o','LineWidth',2,'MarkerSize',5, 'MarkerEdgeColor',colorDist,'MarkerFaceColor',colorDist, 'Color', colorDist);
    plot(days,avgData(:,2),'-o','LineWidth',2,'MarkerSize',5, 'MarkerEdgeColor',colorCorr,'MarkerFaceColor',colorCorr, 'Color', colorCorr);
    plot(days,avgData(:,3),'-o','LineWidth',2,'MarkerSize',5, 'MarkerEdgeColor',colorGlasso,'MarkerFaceColor',colorGlasso, 'Color', colorGlasso);
    hold off;

    xlabel('Number of Training Days');
    ylabel('error_t_e_s_t');
    ylim([0.52 0.72]);

end

