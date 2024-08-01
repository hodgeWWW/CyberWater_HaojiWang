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
function [ Ztrain_i, Zval_i, Ztest_i, Xtrain_i, Xval_i, Xtest_i, Ytrain_i, Yval_i, Ytest_i ] = getDataSubSetByIndex( ZtrainSs, ZvalSs, ZtestSs, XtrainSs, XvalSs, XtestSs, YtrainSs, YvalSs, YtestSs, index )
    Ztrain_i    = ZtrainSs(:,:, index);
    Zval_i      = ZvalSs(:,:, index);
    Ztest_i     = ZtestSs(:,:, index);
    
    Xtrain_i    = XtrainSs(:,:, index);
    Xval_i      = XvalSs(:,:, index);
    Xtest_i     = XtestSs(:,:, index);
    
    Ytrain_i    = YtrainSs(:,:, index);
    Yval_i      = YvalSs(:,:, index);
    Ytest_i     = YtestSs(:,:, index);
end

