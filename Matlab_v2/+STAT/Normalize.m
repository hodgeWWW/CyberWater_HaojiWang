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
function [Z, alpha0, alpha1] = Normalize(X, opt)

    p = size(X,2);
    if opt == 1
        alpha0 = mean(X);
        alpha1 = std(X);
    elseif opt==2
        alpha0 = min(X);
        alpha1 = max(X)-alpha0; 
    elseif opt == 3
        alpha0 = mean(X);
        alpha1 = ones(1,p);
    else
        
        alpha0 = zeros(1,p);
        alpha1 = ones(1,p);        
    end
    
    [n,p] = size(X);
    Z = zeros(n,p);
    for i=1:p
        Z(:,i) = ( X(:,i)-alpha0(1,i) )./alpha1(1,i);
    end    
end

