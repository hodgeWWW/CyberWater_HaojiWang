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
function [ Amatrix, b, Xhat ] = computeOLR( X, Gp, bias )
    Xhat = zeros( size(X) );
    [n, p] = size(Xhat);
    b = zeros(1,p);
    Amatrix  = zeros(p,p);
    
    if nargin==2
        bias = true;
    end
    
    for i=1:p
        Xi  = X(:,i);
        idx = GLASSO_REFACTORED.INDEX.getNeighbors( Gp, i );        
        Xni = X(:, idx);
        
        if bias
            [ theta, Yi ] = ML.normalEqn_Bias( Xni, Xi );
            b(i) = theta(1,1);
            alpha = theta(2:end, 1);
        else
            [theta] = ML.normalEqn( Xni, Xi );
            b(i) = 0;
            alpha = theta;   
            Yi = Xni*alpha;
        end
        
        q = size(alpha,1);
        for j=1:q
            Amatrix(idx(1,j),i) = alpha(j,1);
        end
        Xhat(:, i) = Yi;
    end    
    
    B = repmat(b,n,1);
    
    Xhat_check = X*Amatrix + B;
    check = sum(sum(abs(Xhat_check-Xhat)));
    assert( check < 1e-10 );    %改： assert( check < 1e-6 );   
end

