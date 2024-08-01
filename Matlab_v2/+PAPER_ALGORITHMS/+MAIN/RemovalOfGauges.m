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
function [ bestK, NUM, G, rem_rank, results_test, k ] = RemovalOfGauges( Xtest, Xpred_test, rmse_vec_Xtest, nse_vec_Xtest, Gk, blackList, donorGroup, targetGroup )
    markNeighbors = true;
    
    p = size(Gk,2);
    gid = (1:p)';

    NULL_COL = 9999*ones(p,1);
    results_test = [NULL_COL nse_vec_Xtest rmse_vec_Xtest gid];

    nse_test = nse_vec_Xtest;
    best = GLASSO_REFACTORED.INFERENCE.computeRemovalOrder( nse_test, Gk, markNeighbors, blackList, donorGroup, targetGroup );

    seq_rem = (1:size(best,2))';
    rem_rank = [results_test(best,4) seq_rem ];
    results_test(best,1) = seq_rem;

    G = Gk - eye(p); 
    
    NUM = 8;
    k = min(size(best,2),NUM); 
    bestK = best(1,1:k);
end

