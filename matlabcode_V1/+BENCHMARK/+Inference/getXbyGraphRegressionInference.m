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
function [ Xgr, Atrain, b,  B, Ygr] = getXbyGraphRegressionInference( Xtrain, Xval, G, bias )
    if nargin < 4
        bias = true;
    end
   
    Ytrain = PREPAREDATA.getDataY(Xtrain);
    Yval   = PREPAREDATA.getDataY(Xval);
  
    [ Atrain, b, ~ ] = GLASSO_REFACTORED.REGRESSION.computeOLR( Ytrain, G, bias );
              
    if bias
        n_val = size(Xval,1);
        B = repmat(b, n_val,1);
    else
        B = 0;
    end
      
    Ygr = Yval*Atrain + B;
    Xgr = GLASSO_REFACTORED.TRANS.getXfromY(Ygr);
    
end

