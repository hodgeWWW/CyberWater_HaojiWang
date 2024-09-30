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
function [ error_val, ind_error, count_R2val ] = calcError( Actual, Expected, list, discardFrac, useNse )

    if nargin == 4
        useNse = false;
    end
    
    if useNse
        R2val_vec = STAT.matrixNSE( Actual, Expected);
    else
        R2val_vec = STAT.matrixR2(Actual, Expected);
    end

    R2val_vec_noNull = R2val_vec(list);
    
    %% Compute validation error based on Score
     [ score ] = PAPER_ALGORITHMS.CALC.calcNseScore( R2val_vec_noNull );
     q = size(R2val_vec_noNull,1);
     error_val = (q - score) / q;
    
    p = size(Actual,2);
    count = floor( p * (1 - discardFrac) );
    sorted_R2val = sort(R2val_vec_noNull, 'desc');
    count_R2val = sorted_R2val(1:count);
    mean_count_R2val = mean(count_R2val);

    ind_error = (1 - R2val_vec)';
end

