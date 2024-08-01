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
function [G] = plotGraphYinv( Theta, tau, color, LineWidth,  MarkerSize, xy)

    %% Plot Graph
    if tau==0
        G = (abs(Theta) > 0) + 0;
    else
        G = GLASSO_REFACTORED.NON_ZEROS.prec2graph(Theta,tau);
    end

    if nargin==5
        % Load Coordinates
        xy = PREPAREDATA.getXYcoordinates();    
    end

    if nargin ==2
        color = [1 0 0];
    end

    x = xy(:,1);
    y = xy(:,2);
    y = -y;

    xy = [x y];

    EXTERNAL.GPLOTD.gplotd(G,xy,'Color',color,'LineWidth',LineWidth,'MarkerSize',MarkerSize);
end

