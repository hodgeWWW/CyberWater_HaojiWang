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
function [ ] = plotR2ColorSummaryBar( mean_r2_summary, limy )
    b = bar(mean_r2_summary);
    
    if nargin > 1
        ylim(limy);
    end
    set (gca, 'XTickLabel',{'1 Donor Gauge','2 Donor Gauges','3 Donor Gauges'})
    xlabel('');
    ylabel('error_t_e_s_t');
    legend({'Dist','Corr', 'SGM'}, 'Location','northwest');

    EXTERNAL.BARVALUES.barvalues([],'%0.3f');

    [ colorDist, colorCorr, colorGlasso ] = PAPER_ALGORITHMS.ALTERNATIVE.PLOT.getComparisonColors();
    
    b(1).FaceColor = colorDist;
    b(2).FaceColor = colorCorr;
    b(3).FaceColor = colorGlasso;
end

