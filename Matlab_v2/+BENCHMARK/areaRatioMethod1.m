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
function [x,y,h] = areaRatioMethod1(X,A,idx,idy, useBeta, isLog  )

    x = X(:,idx);
    y = X(:,idy);
    ax = A(idx);
    ay = A(idy);

    if nargin==4
        useBeta = false;
        isLog = false;
    end
    
    if useBeta
        beta_vec = GLASSO_REFACTORED2.BENCHMARK.scalingCoefficient( x, y, ax, ay );
        beta = mean(beta_vec);
    else
        beta = 1;
    end
    
    if isLog
        alpha = beta*log(ay/ax);
        h = alpha + x;
    else    
        alpha = (ay/ax)^beta;
        h = alpha*x;
    end
    
end

