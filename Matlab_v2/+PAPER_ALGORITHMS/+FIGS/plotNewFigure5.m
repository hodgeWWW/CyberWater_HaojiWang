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
function [] = plotNewFigure5(nseScoresMat,meanNseScore, nse8sMat, meanNse8, mydir, plotFigures)
    figure;
    minVal = 0.65;
    maxVal = 0.85;
    
    subplot(2,3,1:2);
    PAPER_ALGORITHMS.ALTERNATIVE.PLOT.plotColorSummaryBar(nseScoresMat, [minVal maxVal], 'graph score_t_e_s_t');
    
    subplot(2,3,3);
    PAPER_ALGORITHMS.ALTERNATIVE.PLOT.plotColorSummaryBarInd(meanNseScore, [minVal maxVal], 'graph score_t_e_s_t'); %Matlab 2018+

    subplot(2,3,4:5);
    PAPER_ALGORITHMS.ALTERNATIVE.PLOT.plotColorSummaryBar(nse8sMat, [minVal maxVal], 'mean nse_t_e_s_t');
    
    subplot(2,3,6);
    PAPER_ALGORITHMS.ALTERNATIVE.PLOT.plotColorSummaryBarInd(meanNse8', [minVal maxVal], 'mean nse_t_e_s_t'); %Matlab 2018+
    
    h = 10;
    w = 12;
    if plotFigures
        PLOT.savePngFile([mydir '05_Figure5'],[w h]);
    end
end

