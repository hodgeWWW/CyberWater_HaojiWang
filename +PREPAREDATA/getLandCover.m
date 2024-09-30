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
function [ land_cover, classes ] = getLandCover(data_folder)
    % gauge_id, % land_cover by class 
    % gauge_id, 11,	21,	22,	23,	24,	31,	41,	42,	43,	52,	71,	81,	82,	90,	95

    filename = [data_folder 'LAND_COVER.txt'];    
    land_cover = dlmread(filename,'\t');
    classes = [11,	21,	22,	23,	24,	31,	41,	42,	43,	52,	71,	81,	82,	90,	95];

end

