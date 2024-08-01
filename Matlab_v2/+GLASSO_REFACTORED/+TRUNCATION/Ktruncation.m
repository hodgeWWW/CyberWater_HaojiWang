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
function [ Sk, Gk] = Ktruncation( S, k, blackList )

    if nargin==2
        blackList = [];
    end
    
    S = (S + S')/2; %force it to be symmetric (not guaranteed with Glasso, OK with Glassofast)
    S(blackList,:) = 0;
    S(:,blackList) = 0;
    I = eye(size(S));
    S = S + I;
    
    S0 = S;
    
    
    nonZeros  = GLASSO_REFACTORED.GRAPH.countEdges( abs(S0) > 0 );  
   
    S( logical(I) ) = 0;
    

    if k<1
        Sk = S;
        Gk = abs(Sk) > 0;
        return;
    end    
    p = size(S,2);
    n = ( p*p - p) / 2;
    elements = zeros(n,1);

    index = 1;
    for i=1:p
        for j=i+1:p
            elements(index) = abs( S(i,j) );
            index = index + 1;
        end
    end
    
elements = sort(elements,'descend');
nl = size(elements,1);
if (k < nl)
    k1 = elements(k+1);
else
    k1 = 0;
end
Sindex = (abs(S) > k1);

ns  = GLASSO_REFACTORED.GRAPH.countEdges( Sindex );
if (nonZeros >= k)
else
    %assert(ns ==nonZeros);
end    

Sindex = Sindex + I;
Sk = S0.*Sindex;

%{
Sk0 = S0.*Sindex;
p = size(S,2);
for i=1:p
    Si  = Sk0(i,:)';
    Sit = Sk0(:,i);
    Ss = [Si Sit];
    delta = Si-Sit;
    sd = sum(abs(delta));
end    
%}

Gk = abs(Sk) > 0;
[ numEdges ] = GLASSO_REFACTORED.GRAPH.countEdges( Gk );

if (nonZeros >= k)
    assert(numEdges == k);
else
    assert(numEdges == nonZeros);
end  

end

