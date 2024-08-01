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
function [ gauge_id, Elevation, Latitude, Longitude, Area ] = getFeatures2(data_folder)
    if nargin == 0
        data_folder = PREPAREDATA.getDataFolder();
    end
    % gauge_id, Altitude(ft), Latitude, Longitude, Drainage_Area(mile^2)
    features  = PREPAREDATA.getFeatures(data_folder);
    gauge_id    = features(:,1);
    Elevation   = features(:,2);  
    Latitude    = features(:,3);
    Longitude   = features(:,4);
    Area        = features(:,5);

end

