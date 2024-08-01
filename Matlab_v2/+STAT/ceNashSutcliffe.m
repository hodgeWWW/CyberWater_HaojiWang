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
function [ nse ] = ceNashSutcliffe( x_obs, x_model, powerNorm )

    
    if nargin == 2
        powerNorm = 2;
    end
    
    %j = 2; %default: More sensitive to peak values
    %j = 1; % Better overral performance
    
    if powerNorm==0
        x_obs = log10(x_obs);
        x_model = log10(x_model);
        j = 1;
    else
        j = powerNorm;
    end
    
    n = size(x_obs,1);
    mx_obs = mean(x_obs);
    A = 0;
    B = 0;
    
    for i=1:n         
        a = abs( x_obs(i) - x_model(i) )^j;
        b = abs( x_obs(i) - mx_obs )^j;
        A = A + a;
        B = B + b;
    end    
    
    nse = 1 - (A/B);
    
end

