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
function [ Xtrain_pred, Xval_pred, Xtest_pred ] = getXbyRegressionY( Xtrain, Xval, Xtest, G )
    bias = true;
    
    Ytrain = PREPAREDATA.getDataY(Xtrain);
    Yval   = PREPAREDATA.getDataY(Xval);
    Ytest  = PREPAREDATA.getDataY(Xtest);
    
    Ytrain_pred = BENCHMARK.Inference.getXbyMultipleRegressionInferenceZ( Ytrain, Ytrain, G, bias );
    Yval_pred   = BENCHMARK.Inference.getXbyMultipleRegressionInferenceZ( Ytrain, Yval,   G, bias );
    Ytest_pred  = BENCHMARK.Inference.getXbyMultipleRegressionInferenceZ( Ytrain, Ytest,  G, bias );
    
    Xtrain_pred = GLASSO_REFACTORED.TRANS.getXfromY(Ytrain_pred); 
    Xval_pred   = GLASSO_REFACTORED.TRANS.getXfromY(Yval_pred);
    Xtest_pred  = GLASSO_REFACTORED.TRANS.getXfromY(Ytest_pred);
end

