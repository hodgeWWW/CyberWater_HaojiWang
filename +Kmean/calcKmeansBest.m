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
function [ centroids, groups, Jmin ] = calcKmeansBest( data, K, maxiter, tol, Q )

    if nargin==2
        maxiter = 100;
        tol = 1e-6;
        Q = 100;
    end    

    Jmin = 1e12;
    for i=1:Q
        [ centroidsi, groupsi, Ji ] = Kmean.calcKmeans( data, K, maxiter, tol );
        
        if Ji < Jmin
            centroids = centroidsi;
            groups = groupsi; 
            Jmin = Ji;
            display(Jmin);
        end    
    end    
  
end

