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
function [ Xreg ] = getXbyMultipleRegressionInferenceSets( Xtrain, Xval, Xtest, bias, applyLog, G )
    
    if nargin==2
        applyLog = false;
        bias = true;
    end

    if applyLog
         Xtrain = log(Xtrain);
         Xval   = log(Xval);
         Xtest  = log(Xtest);
    end    
    
    Xreg = zeros(size(Xval));
    [~,p] =  size(Xtrain);
    indexes = (1:p)';
    G = G - eye(p);
    for i=1:p
        gindex = G(:,i);
        idx = indexes(gindex==1);

        Xn = Xtrain(:,idx);
        y  = Xtrain(:,i);

        xval = Xval(:,idx);
        if bias 
            [ theta, ~ ] = ML.normalEqn_Bias(Xn, y);
            h = ML.predictEqn( xval, theta );
        else
            theta = ML.normalEqn(Xn, y);
            h = xval*theta;
        end
        
        if isLog
            h = exp(h);
        end    
        Xreg(:,i) = h;
    end

end

