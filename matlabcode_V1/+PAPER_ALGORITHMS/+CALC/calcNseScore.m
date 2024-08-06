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
function [ nseScore ] = calcNseScore( nse_vec, threshold )
    if nargin == 1
        threshold = 0.7;  %改， threshould = 0.7
    end
    numRows = size(nse_vec,1);
    nseScore = 0;
    for i = 1:numRows
        nse = nse_vec(i);
        if nse > threshold
            nseScore = nseScore + nse;
        end
    end
end

