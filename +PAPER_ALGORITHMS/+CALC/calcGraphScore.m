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
function [ nseScore ] = calcGraphScore( best_rem, nse_test, m_rem, nseThreshold )
    best_nse = nse_test(best_rem,1);
    rems = min(m_rem, size(best_nse,1));
    best_nse_rem = best_nse(1:rems);
    best_nse_rem = best_nse_rem(best_nse_rem >= nseThreshold);
    nseScore = sum(best_nse_rem);
    nseScore = nseScore / m_rem;
end

