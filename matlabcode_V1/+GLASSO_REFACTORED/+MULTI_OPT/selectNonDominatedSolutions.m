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
function [ idx, idx_tmp ] = selectNonDominatedSolutions(x, y)
% x:int 0 <= x <= max(x)

    
    %% Compute the minimum for each x
    [ sol_vec, maxval ] = GLASSO_REFACTORED.MULTI_OPT.selectMinSolutionsForEach(x, y);
    m = size(sol_vec, 1);
    
    idx_tmp = sol_vec(:,2);
    idx_tmp(idx_tmp(:,1)==maxval,:) = [];
      
    %% remove the local minimum that are higher that the previous min for x
    ymin = maxval;
    for j=1:m
        yj = sol_vec(j,1);
        if yj <= ymin
            ymin = yj;
        else
            sol_vec(j,1) = maxval;
        end

    end
    
    
    sol_vec(sol_vec(:,1)==maxval,:) = [];
    idx = sol_vec(:,2);

end

