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
function [ best, nse_test, bestK, NUM, numSubPlots, Xtest_pred, G, powerNorm ] = calcFigure6( Gk, Xtrain, Xval, Xtest, blacklist, donorGroup, targetGroup )
    powerNorm = 2;
    
    %% Infer Streamflow (Algorithm defined in Conf):
    [ ~, ~, Xtest_pred ]   = PAPER_ALGORITHMS.HELPER.inferStreamflow( Xtrain, Xval, Xtest, Gk );  
   
    [ rmse_vec_Xtest, nse_vec_Xtest ]  = GLASSO_REFACTORED.INFERENCE.calcStatsForEachGauge(Xtest, Xtest_pred );
    
    [bestK, NUM, G, rem_rank, results_test, numSubPlots] = PAPER_ALGORITHMS.MAIN.RemovalOfGauges( Xtest, Xtest_pred, rmse_vec_Xtest, nse_vec_Xtest, Gk, blacklist, donorGroup, targetGroup  );

    nse_test_raw = nse_vec_Xtest;
    nse_test = round(nse_test_raw,2);
    markNeighbors = true;
    best = GLASSO_REFACTORED.INFERENCE.computeRemovalOrder( nse_test, Gk, markNeighbors, blacklist, donorGroup, targetGroup );
end

