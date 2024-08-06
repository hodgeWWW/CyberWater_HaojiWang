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
function [ Zval_pred, Zval_top, Zval_pred_top ] = getXbyMultipleRegressionInferenceZ( Ztrain, Zval, G, bias )
     
    if nargin == 3
        bias = false;
    end
    [rows, cols] = size(Zval);
    Zval_pred = zeros(rows, cols);
    
    [~,p] =  size(Ztrain);
    indexes = (1:p)';
    G = G - eye(p);
    for i=1:p
        gindex = G(:,i);
        idx = indexes(gindex==1);

        Zn = Ztrain(:,idx);
        Zi = Ztrain(:,i);
        
        if bias            
            [ theta, ~ ] = ML.normalEqn_Bias( Zn, Zi );
            b = theta(1,1);
            theta = theta(2:end, 1);
        else
            b = 0;
            theta = ML.normalEqn(Zn, Zi);
        end
        
        Zval_i = Zval(:,idx);     
        h = Zval_i * theta + b;

        Zval_pred(:,i) = h;
    end
   
end

