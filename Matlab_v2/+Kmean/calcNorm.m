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
function [ norm ] = calcNorm( centroids )

    [n,p] = size(centroids);
    norm =  zeros(n,1);
    for i=1:n
        ni = 0;
        for j=1:p
            nj = centroids(i,j).^2;
            ni = ni + nj;
        end    
        ni = sqrt(ni);
        norm(i,1) = ni;
    end
   
end

