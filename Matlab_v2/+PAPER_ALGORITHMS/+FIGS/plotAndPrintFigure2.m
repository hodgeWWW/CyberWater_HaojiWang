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
function [ ] = plotAndPrintFigure2( Ztrain, multi_objective_points, nonDomSolutions, k_sel, k, list, donorGroup, targetGroup, mean_r2_summary, mydir, fname, printFig )
    figure;
    w = 9;
    h = 12;
    subplot(3,1,1);
    PAPER_ALGORITHMS.FIGS.plotFigure2A( Ztrain, multi_objective_points, nonDomSolutions, k_sel );
    subplot(3,1,2);
    PAPER_ALGORITHMS.FIGS.plotFigure2B( mean_r2_summary, k, k_sel, w, h, mydir, fname, false );
    subplot(3,1,3);
    PAPER_ALGORITHMS.FIGS.plotFigure2C();

    EXTERNAL.tightfig.tightfig;

    if printFig
        PLOT.savePngFile([mydir '02_Figure2'],[w h]);
    end 

end

