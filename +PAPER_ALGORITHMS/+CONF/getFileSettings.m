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
function [ fnameAll, fnameopt, mydir, fname, fnameLocal ] = getFileSettings(Kmin, Kmax, lambda_min, lambda_max)
    % Simulation Settings:
    ext = '.csv';
    fname = ['K' num2str(Kmin) 'to' num2str(Kmax) '_L' num2str(lambda_min) 'to' num2str(lambda_max) ];

    mydir = './OUTPUT/';
    fnameAll =   [mydir '01_All_MultiObjectivePoints_' fname ext];
    fnameopt =   [mydir '02_Optimized_NonDominatedSolutions_' fname ext];
    fnameLocal = [mydir '03_Local_MinimumSolutions_' fname ext];

    mkdir(mydir);
end

