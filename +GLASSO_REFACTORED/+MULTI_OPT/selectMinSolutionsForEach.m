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
function [ sol_vec, maxval ] = selectMinSolutionsForEach(x, y)
% x:int 0 <= x <= max(x)

    m = max(x) + 1;
    maxval = max(y) + 100;
    sol_vec = ones(m,2) * maxval;
        
    n = size(x,1);
    
    %% Compute the minimum for each x
    for i=1:n
        yi = y(i);
        idx = x(i) + 1;
        ym = sol_vec(idx,1);
        if yi < ym
            sol_vec(idx,1) = yi;
            sol_vec(idx,2) = i;
        end
    end

end

