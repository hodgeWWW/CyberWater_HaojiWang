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
function [stats] = statsResults( X, Xest, list )
    
    if nargin==2
        p = size(X,2);
        list = 1:p;
    end    

    q = size(list,2);
    stats = zeros(q,6);
      
    qi = 0;
    for idy = list
        qi = qi + 1;

        y = X(:, idy);
        h = Xest(:, idy);
                
        nse  = STAT.NSE(y, h);
        rmse = STAT.rmse(y, h);
        r2   = STAT.R2(y, h);
        nse1 = STAT.ceNashSutcliffe(y, h, 1);
        nse0 = STAT.ceNashSutcliffe(y, h, 0);
            
        stats(qi,:) = [nse rmse r2 nse1 nse0 idy]; 

    end
   
end

