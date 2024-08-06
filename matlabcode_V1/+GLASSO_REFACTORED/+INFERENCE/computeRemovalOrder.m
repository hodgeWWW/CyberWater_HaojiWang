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
function [ order ] = computeRemovalOrder( ce, G, markNeighbors, blackList, donorGroup, targetGroup )

    if nargin == 2 
        markNeighbors = true;
        blackList = [];
    end
    p = size(G,2);
    seq = (1:p)';
    order = zeros(p,1);
    
    %Artifitially set NSE to 1 to force the removal
    ce(targetGroup) = 1;
    
    data = [seq 1-ce];
    data = sortrows(data,2);
    data(:,2) = 1-data(:,2);
    
  
    order(blackList, 1) = -1; 
    order(donorGroup, 1) = -1; 
   
    
    rank = size(targetGroup,2);

    for i=1:p
       idx = data(i,1);
       if order(idx,1)>=0
           rank = rank + 1; 
           neighbors  = GLASSO_REFACTORED.INDEX.getNeighbors( G, idx );
           nn = size(neighbors,2);
           if nn > 0
              order(idx,1) = rank;
              if markNeighbors
                order(neighbors, 1) = -1;
              end
           end
       end
    end
    
    order = [seq order];
    order(order(:,2)<=0,:) = [];
    order = sortrows(order,2);

    order (:,2) = [];
    order  = order';
end

