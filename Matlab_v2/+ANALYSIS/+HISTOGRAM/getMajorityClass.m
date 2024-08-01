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
function [ majority_class, groups ] = getMajorityClass( class_histogram, classes )
    p = size(class_histogram,1);
    gid = class_histogram(:,1);
    class_histogram = class_histogram(:,2:end);
    nc = size(class_histogram,2);
    majority_class = zeros(p,3);
    class_id = 1:nc;
    for i=1:p
        row = class_histogram(i,:);
        maxval = max(row);
        majority_class(i,3) = maxval;
        idx = row(1,:)== maxval;
        idx = class_id(idx);
        majority_class(i,1) = idx;
        majority_class(i,2) = classes(idx);
    end  

    %[gid, class_id, class_code, %]
    majority_class = [gid majority_class];
    
    class_idx = majority_class(:,2);
    groups = ANALYSIS.HISTOGRAM.getGroups(class_idx);
    majority_class = [majority_class groups];
end

