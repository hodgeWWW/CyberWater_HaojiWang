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
function [  ] = plotGaugeResults( X, Xhat, G, idx, prefix, powerNorm )
    p = size(G,2);
    G = G - eye(p);
    x    = X(:,idx);
    xhat = Xhat(:,idx);
    
    m3s_to_cfs = 35.314666212661;
    x = x / m3s_to_cfs; % cfs to m^3/s
    xhat = xhat / m3s_to_cfs; % cfs to m^3/s
    
    hold on;
    plot(x,xhat,'.','color',[0 0 1]);
    plot(x,x,'color',[1 0 0],'LineWidth',1.5);
    hold off;
    
    if powerNorm == 2
        sufix = '';
    else
       sufix = num2str(powerNorm);
    end
    
    rmse = STAT.rmse(x, xhat);
    nse   = STAT.ceNashSutcliffe(x, xhat, powerNorm);
    
    myIndexes = G(idx,:);
    neighbors = GLASSO_REFACTORED.INDEX.logic2list( myIndexes );
    
    neis = size(neighbors,2);
    myNeighborGauges = '';
    sep = '';
    for i=1:neis
        nindex = neighbors(i);
        neighbor = GLASSO_REFACTORED.DATA.getGaugeName( nindex );
        myNeighborGauges = [myNeighborGauges sep neighbor];
        sep = ', ';
    end    
    
    responseGauge = GLASSO_REFACTORED.DATA.getGaugeName( idx );
    
    units = 'm^3/s'; %cfs
    t1 = [prefix responseGauge ' | ' myNeighborGauges ];
    t2 = ['RMSE=' sprintf('%.1f',rmse) units ' , NSE' sufix '=' sprintf('%.2f',nse) ];
    title([{t1}, {t2}]);
 
    xlabel(['Observed Streamflow (' units ')']);
    ylabel(['Inferred Streamflow (' units ')']);
    
end

