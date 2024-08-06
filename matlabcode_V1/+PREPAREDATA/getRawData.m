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
function [X, X_date] = getRawData(inputFile)
    data_folder = PREPAREDATA.getDataFolder();
    if nargin == 0
        inputFile = [data_folder '01_DATA_30_YEARS_DAILY.txt']; % default
    end   
    
    % read the daily data
    opts = detectImportOptions(inputFile, 'Delimiter', '\t');%原来分隔符是\t
    T = readtable(inputFile, opts);

    % convert table to array for further processing
    X_date = table2array(T);

    % remove dates
    X = X_date(:,4:end); %原来是4:37
    disp('get raw data successfully.');
end
