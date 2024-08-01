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
function [ best_nse, nseScore, nse8] = genTable2( best_rem, nse_test, mydir, desc, num )
    %[rank, index, nse]
    b = size(best_rem,2);
    best_nse = nse_test(best_rem,1);
    table2 = zeros(b,3);
    table2(:,1) = (1:b)';
    table2(:,2) = best_rem';
    table2(:,3) = best_nse;
    dlmwrite([mydir 'table_RemovalOfGauges_GaugeIndex_NSE_' desc '.txt'],table2,'\t');
    
    s = min(b, num);
    nseScore = 0;
    nse8 = sum( best_nse(1:s) );
    nse8 = nse8 / num;

end

