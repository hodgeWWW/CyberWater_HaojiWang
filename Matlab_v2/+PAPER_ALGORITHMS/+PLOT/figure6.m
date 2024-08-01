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
function [] = figure6( best_rem, remColor, Gp, nse_test, desc, nseScore )
   
    nse_test_best = nse_test(best_rem);
    if nargin == 4
        desc = 'SGM'; 
        nseScore = 0;
    end

    %% Plot figure:
    LineWidth = 1;
    MarkerSize = 4;
    GLASSO_REFACTORED.MAP.plotGraphMapResults(Gp, best_rem, remColor, LineWidth, MarkerSize, nse_test_best );
    numEdges    = GLASSO_REFACTORED.GRAPH.countEdges( Gp );
    title1 = ['RG: ' desc '(' num2str(numEdges) ')'];
    title(title1);
    axis equal tight;

end

