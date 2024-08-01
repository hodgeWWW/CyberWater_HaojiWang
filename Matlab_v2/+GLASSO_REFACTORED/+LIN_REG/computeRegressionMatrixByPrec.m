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
function [ AlphaMatrix ] = computeRegressionMatrixByPrec( T )
    p = size(T,2);
    AlphaMatrix = zeros(p,p);
    for j=1:p    
        t22 = T(j,j);
        t12  = ANALYSIS.getSubvector( T, j);
        alpha_j  = -t12/t22; 
        AlphaMatrix = GLASSO_REFACTORED.UTIL.updateMatrixRows2(AlphaMatrix, alpha_j, j);
    end
end

