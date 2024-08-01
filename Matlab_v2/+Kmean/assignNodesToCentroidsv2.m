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
function [ groups ] = assignNodesToCentroidsv2( centroids, X )
    n = size(X,1);
    K = size(centroids,1);
    groups = zeros(n,1);
    
    for i=1:n
        xi = X(i,:);
        
        dmin = Inf;
        gn = -1; 
        for k=1:K
            xk = centroids(k,:);
            dnk = sum((xi-xk).^2 );
            if dnk<dmin
                dmin = dnk;
                gn = k;
            end
        end    
        groups(i,1) = gn;
    end    


end

