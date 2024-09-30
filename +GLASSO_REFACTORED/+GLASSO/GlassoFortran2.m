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

% L1-norm penalty coefficient 
% This code learn the structure of a Markov Network using GLASSO method
function [ Theta, W, iter ] = GlassoFortran2( lambda, Z, lassoFunction, invFunction,maxIter, tol, G )
    
    approximate=0;
    warmInit=0;
    verbose=0;    
    
    penalDiag=1; %(default)
  
    p = size(Z,2);
    
    W = zeros(p);
    Theta = zeros(p);
   
   [W, Theta, iter, avgTol, hasError] = EXTERNAL.Graphical_Lasso.GraphicalLasso(Z, lambda, G, approximate, warmInit, verbose, penalDiag, tol, maxIter, W, Theta);
    
end




