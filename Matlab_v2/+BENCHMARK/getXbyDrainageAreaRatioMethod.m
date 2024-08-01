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
function [ Xdrm ] = getXbyDrainageAreaRatioMethod( X, areas, isLog, useBeta, useCorr, Xtrain )

    if nargin==2
        isLog = false;
        useBeta = false;
    end
    
    if nargin < 5
        useCorr = false;
    end
    
    if useCorr
        nn_vec = BENCHMARK.getHighestCorrelationVector(Xtrain);
    else
        nn_vec = BENCHMARK.getNearestNeighborVector();
    end
    
    Xdrm = zeros(size(X));
    p =  size(X,2);
    for i=1:p
        nn_id = nn_vec(i);
        [x,y,h] = BENCHMARK.areaRatioMethod1(X,areas,nn_id,i, useBeta, isLog);
        Xdrm(:,i) = h;
    end

end

