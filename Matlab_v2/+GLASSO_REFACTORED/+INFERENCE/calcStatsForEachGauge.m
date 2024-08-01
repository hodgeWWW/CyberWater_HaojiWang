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
function [ rmse_vec, ce_vec ] = calcStatsForEachGauge(X, Xhat, powerNorm)
    p = size(X,2);
    rmse_vec = zeros(p,1);
    ce_vec   = zeros(p,1);
    
    if nargin==2
        powerNorm = 2;
    end
        
    for i=1:p
        Xi     = X(:,i);
        Xhat_i = Xhat(:,i);
        
        rmse = STAT.rmse(Xi,Xhat_i);
        nsce = STAT.ceNashSutcliffe(Xi,Xhat_i, powerNorm);
        
        rmse_vec(i,1) = rmse;
        ce_vec(i,1)   = nsce;
        
    end    

end

