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
function [  ] = plotFigure6(bestK, NUM, k, Xtest, Xpred_test, G, powerNorm )
    figure;
    rank = 0;  
    for i= bestK
        rank = rank + 1;
        idx = mod(rank,NUM);
        if(idx==0)
            idx = NUM;
        end
        subplot(4,2,idx);
        GLASSO_REFACTORED.INFERENCE.plotGaugeResults( Xtest, Xpred_test, G, i, 'Xtest: ', powerNorm );
        if( (mod(rank,NUM)==0 || rank==k) && idx<k )
            figure;
        end    
    end
end

