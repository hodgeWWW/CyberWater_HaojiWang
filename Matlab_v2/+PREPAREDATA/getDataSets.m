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
function [ Ztrain, Zval, Ztest, Xtrain, Xval, Xtest, Ytrain, Yval, Ytest ] = getDataSets(filenameRawData)
%% Preprocessing Data
    if nargin == 0
        X = PREPAREDATA.PrepareDataX(false); % default
    else
        X = PREPAREDATA.PrepareDataX(false, filenameRawData); % default
    end

 %%
    strategy_id = 7;
    [ Xtrain, Xval, Xtest ] = GLASSO_REFACTORED.REGRESSION.getDataSets( X, 1, strategy_id, 1 );
    
    Ytrain = PREPAREDATA.getDataY(Xtrain);
    Yval   = PREPAREDATA.getDataY(Xval);
    Ytest  = PREPAREDATA.getDataY(Xtest);
    
    [Ztrain, ~, ~] = PREPAREDATA.getDataZ(Xtrain);
    [Zval, ~, ~]   = PREPAREDATA.getDataZ(Xval);
    [Ztest, ~, ~]  = PREPAREDATA.getDataZ(Xtest);
   
end

