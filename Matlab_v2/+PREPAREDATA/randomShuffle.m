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
function [ shuffledData, random_indexes ] = randomShuffle( data )
    num = size(data, 1);
    idx = (1:num)';
    
    random_vec = rand(num, 1);
    data_ext = [random_vec idx data];
    data_ext = sortrows(data_ext);
    
    shuffledData = data_ext(:, 3:end);
    random_indexes = data_ext(:, 2);
end

