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
function [ Xsm ] = getXbyStandarizingMeanInference(Xtrain, Xval, isLog, isStd, useCorr)

    if nargin < 5
        useCorr = false;
    end

    if useCorr
        nn_vec = BENCHMARK.getHighestCorrelationVector(Xtrain);
    else
        nn_vec = BENCHMARK.getNearestNeighborVector();
    end
    
    Xsm = zeros(size(Xval));
    p =  size(Xtrain,2);
    for i=1:p
        nn_id = nn_vec(i);

        if isStd
            [x,y,h] = BENCHMARK.Inference.standarizingMeanStdInference(Xtrain, Xval, nn_id, i, isLog);
        else
            [x,y,h] = BENCHMARK.Inference.standarizingMeanInference(Xtrain, Xval, nn_id, i, isLog);
        end
        Xsm(:,i) = h;
    end

end

