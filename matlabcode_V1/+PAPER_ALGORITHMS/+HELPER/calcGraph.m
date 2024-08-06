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
function [ Gk, Theta_train1, Theta_train2 ] = calcGraph( Ztrain, k, lambda, list, donorGroup, targetGroup)
    p = size(Ztrain, 2);
    if nargin ==3
        list = (1:p)';
        donorGroup = [];
        targetGroup = [];
    end
    
    kmax = PAPER_ALGORITHMS.CONF.getKmax(p);

    %Glasso Settings
    if k == kmax
        Gfull = ones(p);
    else
        Gfull = PAPER_ALGORITHMS.UTIL.getFullGraph(p,list, donorGroup, targetGroup);
    end

    [ tol, maxIter ] = PAPER_ALGORITHMS.CONF.getGlassoParams();
    
     % Equation (20):
    Theta_train1 = GLASSO_REFACTORED.GLASSO.GlassoFortran2( lambda, Ztrain, 0, 0, maxIter, tol, Gfull );       

    % Convert Precision matrix to Graph - Equation (22):
    Gk = GLASSO_REFACTORED.NON_ZEROS.prec2graph(Theta_train1, k);                                       
    
    % Equation (23):
    Theta_train2 = GLASSO_REFACTORED.GLASSO.GlassoFortran2( 0, Ztrain, 0, 0, maxIter, tol, Gk );                                        % Equation (26).
 
end

