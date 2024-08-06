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
function [ G ] = prec2graph( Theta, tau, opt )

    if nargin==2
        opt = 4;
    end
    
    if opt==1
        G = GLASSO_REFACTORED.NON_ZEROS.Theta2Network(Theta, tau);
    elseif opt==2
        G = GLASSO_REFACTORED.NON_ZEROS.nonZeros(Theta, tau);
    elseif opt==3
        G = GLASSO_REFACTORED.NON_ZEROS.nonZerosMaxOffDiag(Theta, tau);
    else
        sobj = GLASSO_REFACTORED.SINGLETON.SingleInstance.getInstance;
        blackList = sobj.blackList;
        
        k = tau;
        [~, G]  = GLASSO_REFACTORED.TRUNCATION.Ktruncation( Theta, k, blackList );
    end
end

