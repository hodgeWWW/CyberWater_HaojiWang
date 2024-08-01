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
function [ ] = plotColorSummaryBarInd( mean_r2_summary, limy, label )
    b = bar(mean_r2_summary);
    
    if nargin > 1
        ylim(limy);
    end
    set (gca, 'XTickLabel',{'Dist','Corr', 'SGM'})
    xlabel('');
    ylabel(label);

    EXTERNAL.BARVALUES.barvalues([],'%0.3f');

    [ colorDist, colorCorr, colorGlasso ] = PAPER_ALGORITHMS.ALTERNATIVE.PLOT.getComparisonColors();
    
    b.FaceColor = 'flat';
    b.CData(1,:) = colorDist;
    b.CData(2,:) = colorCorr;
    b.CData(3,:) = colorGlasso;

end

