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
function [ Xtrain_pred, Xval_pred, Xtest_pred ] = getXbyRegressionZ( Xtrain, Xval, Xtest, G )
    bias = false;
    
    [Ztrain, muy, sigmay] = PREPAREDATA.getDataZ(Xtrain);
    [Zval, ~, ~]          = PREPAREDATA.getDataZ(Xval);
    [Ztest, ~, ~]         = PREPAREDATA.getDataZ(Xtest);
    
    Ztrain_pred = BENCHMARK.Inference.getXbyMultipleRegressionInferenceZ( Ztrain, Ztrain, G, bias );
    Zval_pred   = BENCHMARK.Inference.getXbyMultipleRegressionInferenceZ( Ztrain, Zval,   G, bias );
    Ztest_pred  = BENCHMARK.Inference.getXbyMultipleRegressionInferenceZ( Ztrain, Ztest,  G, bias );
    
    Ytrain_pred = GLASSO_REFACTORED.TRANS.getYfromZ( Ztrain_pred, muy, sigmay );
    Yval_pred   = GLASSO_REFACTORED.TRANS.getYfromZ( Zval_pred, muy, sigmay );
    Ytest_pred  = GLASSO_REFACTORED.TRANS.getYfromZ( Ztest_pred, muy, sigmay );
    
    Xtrain_pred = GLASSO_REFACTORED.TRANS.getXfromY(Ytrain_pred);
    Xval_pred   = GLASSO_REFACTORED.TRANS.getXfromY(Yval_pred);
    Xtest_pred  = GLASSO_REFACTORED.TRANS.getXfromY(Ytest_pred);
end

