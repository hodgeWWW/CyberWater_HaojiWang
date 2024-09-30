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
function [ centroids, groups, J ] = calcKmeans( data, K, maxiter, tol )

    if nargin==2
        maxiter = 100;
        tol = 1e-6;
    end    

    itera = 0;
   
    centroids = Kmean.genRandomCentroids( data, K );
    
    while (true)
        groups = Kmean.assignNodesToCentroidsv2( centroids, data );
        old_centroids = centroids;
        centroids  = Kmean.calcCentroidsFromGroup( groups, data, K );
        J  = Kmean.calcErrorFunction( data, centroids, groups );
        
        itera = itera +1;
        delta = old_centroids-centroids;
        error = abs(sum(sum(delta)));
        if error<tol || itera>maxiter
            break;
        end
    end

   norm  = Kmean.calcNorm( centroids );
   
   norm2 = [norm centroids];
   norm2 = sortrows(norm2,1);
   centroids = norm2(:,2:end);
   
   groups2 = groups;
   norm2 = [norm (1:K)'];
   norm2 = sortrows(norm2,1);
   
   old_ids = norm2(:, 2);
   for i=1:K
        oid = old_ids(i,1);
        idx = (groups2==oid);
        groups(idx,:) = i;
   end    
  
end

