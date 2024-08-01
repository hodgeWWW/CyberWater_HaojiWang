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
function [ Ztrain, Zval, Ztest, Xtrain, Xval, Xtest, Ytrain, Yval, Ytest ] = getDataSetsRandomJoinTrainVal(filenameRawData)
    if nargin == 0
        [ ~, ~, ~, Xtrain, Xval, Xtest, ~, ~, ~ ] = PREPAREDATA.getDataSets();
    else
        [ ~, ~, ~, Xtrain, Xval, Xtest, ~, ~, ~ ] = PREPAREDATA.getDataSets(filenameRawData);
    end
    
    XtrainVal = [Xtrain; Xval];
    
    seed = 1;
    rng(seed);
    trainLength = size(Xtrain, 1);
    valLength   = size(Xval, 1);
    trainValLen = trainLength + valLength;
    
    trainLength = round(0.5 * trainValLen);
    
    [ ~, ~, random_indexes ] = PREPAREDATA.randomShuffleSubset( XtrainVal, trainLength ); 
    
    train_index = random_indexes(1:trainLength);
    val_index = random_indexes(trainLength + 1: end);
   
    
    Xtrain = XtrainVal(train_index, :);
    Xval   = XtrainVal(val_index, :);
    
    Ytrain = PREPAREDATA.getDataY(Xtrain);
    Yval   = PREPAREDATA.getDataY(Xval);
    Ytest  = PREPAREDATA.getDataY(Xtest);
    
    [Ztrain, ~, ~] = PREPAREDATA.getDataZ(Xtrain);
    [Zval, ~, ~]   = PREPAREDATA.getDataZ(Xval);
    [Ztest, ~, ~]  = PREPAREDATA.getDataZ(Xtest);
    
end

