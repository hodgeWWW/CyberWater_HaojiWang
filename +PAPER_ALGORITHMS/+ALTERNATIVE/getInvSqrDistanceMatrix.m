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
function [ DistMat2 ] = getInvSqrDistanceMatrix()
    
    XY = PREPAREDATA.getXYcoordinates(); 
    p = size(XY,1);
    DistMat2 = zeros(p);
    for i = 1:p
        for j = 1: p
            xi = XY(i,1);
            yi = XY(i,2);

            xj = XY(j,1);
            yj = XY(j,2);

            if i ~= j
                DistMat2(i,j) = 1/ ((xi-xj)^2 + (yi-yj)^2);
            else
                DistMat2(i,j) = 0;
            end
        end
    end


end

