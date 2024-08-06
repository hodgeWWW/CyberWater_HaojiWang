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
function [Gdist, Gcorr, Gsgm, nums_vec, kg, subplotInitIndex, mean_error_summary] = genComparison(num_neigbors, K, Ztrain, Xtrain, Xval, Xtest, subplotInitIndex, count, nonDomSolutions)
    %% Selection of Graph Model (SGM) Settings:
    p = size(Ztrain,2);
    [ ~, ~, list, ~ ] = PAPER_ALGORITHMS.CONF.getDefaultDonorTargetGroupsAndScreening(p);
    
    %% Calc Distance Graph:
    Gdist = PAPER_ALGORITHMS.ALTERNATIVE.getGraphDistance(num_neigbors);
    numEdgesDist  = GLASSO_REFACTORED.GRAPH.countEdges( Gdist );

    %% Calc Correlation Graph:
    Gcorr = PAPER_ALGORITHMS.ALTERNATIVE.getGraphCorrelation( Ztrain, num_neigbors );
    numEdgesCorr  = GLASSO_REFACTORED.GRAPH.countEdges( Gcorr );

    %% Calc Glasso Graph:
    [ Gsgm, ~, kg, ~, ~ ] = PAPER_ALGORITHMS.GLASSO.getGlassoGraph( Ztrain, K, nonDomSolutions ); 
    
    %% Infer Streamflow (Algorithm defined in Conf):
    [ ~, ~, Xtest_pred_dist ]   = PAPER_ALGORITHMS.HELPER.inferStreamflow( Xtrain, Xval, Xtest, Gdist );
    [ ~, ~, Xtest_pred_corr ]   = PAPER_ALGORITHMS.HELPER.inferStreamflow( Xtrain, Xval, Xtest, Gcorr );
    [ ~, ~, Xtest_pred_glasso ] = PAPER_ALGORITHMS.HELPER.inferStreamflow( Xtrain, Xval, Xtest, Gsgm );

    %% Stats Summary:
    [ mean_error_summary] = PAPER_ALGORITHMS.UTIL.getErrorSummary( p, count, Xtest_pred_dist, Xtest_pred_corr, Xtest_pred_glasso, Xtest, list );

    nums_vec = [num_neigbors, numEdgesDist, numEdgesCorr];
end

