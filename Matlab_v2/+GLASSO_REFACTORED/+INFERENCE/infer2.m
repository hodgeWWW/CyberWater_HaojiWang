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
function [ Xpred_train, Xpred_val, Xpred_test,  Ypred_train, Ypred_val, Ypred_test ] = infer2( Ytrain, Yval, Ytest, Atrain, b )
    
    Ypred_train = Ytrain* Atrain + repmat(b, size(Ytrain,1),1);
    Ypred_val   = Yval  * Atrain + repmat(b, size(Yval,1),1);
    Ypred_test  = Ytest * Atrain + repmat(b, size(Ytest,1),1);

    Xpred_train = GLASSO_REFACTORED.TRANS.getXfromY( Ypred_train );
    Xpred_val   = GLASSO_REFACTORED.TRANS.getXfromY( Ypred_val );
    Xpred_test  = GLASSO_REFACTORED.TRANS.getXfromY( Ypred_test );
    
end

