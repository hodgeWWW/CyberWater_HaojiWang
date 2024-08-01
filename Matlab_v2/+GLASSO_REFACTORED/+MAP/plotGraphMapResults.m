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
function [  ] = plotGraphMapResults( G, best_rem, color, LineWidth, MarkerSize, nse_test_best)
    
    folder = './IMG/GIS/';
    fname = 'Ohio_GIS.png';
   
    filename = [folder fname];
    img = imread(filename);
     
    if nargin == 3
        LineWidth = 1;
        MarkerSize = 5;
    end   
      
    xy = PREPAREDATA.getXYcoordinates();    
    xy_best_rem = xy(best_rem,:);
    x = xy_best_rem(:,1);
    y = xy_best_rem(:,2);

    image([-89 -77],[-43 -35],img);
    hold on;
    
    nr = size(nse_test_best, 1);

    GLASSO_REFACTORED.PLOT.plotGraphYinv(G, 0, color, LineWidth, MarkerSize);
    hold on;
    
    blue =  [0 0 1];
    green = [0 1 0];
    yellow = [1 1 0];
    orange = [1 0.5 0];
    red = [1 0 0];
      
    for i=1:nr
        nse = nse_test_best(i);

        if nse >= 0.9
           mycolor = blue;
        elseif nse >=0.8
           mycolor = green;
        elseif nse >=0.7
           mycolor = yellow;
        elseif nse >=0.6
           mycolor = orange;
        else
            mycolor = red;
        end   
            
        scatter(x(i),-y(i),100, 'MarkerEdgeColor',[0 0 0], 'MarkerFaceColor', mycolor, 'LineWidth',1');
    end    
        
    hold off;
    
end

